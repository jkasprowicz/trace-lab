# Projeto TRACE-LAB

## 1. Apresentação

O TRACE-LAB é um sistema de apoio à rastreabilidade do transporte de amostras biológicas. A solução combina um backend em Django com API REST e um aplicativo móvel em Flutter, permitindo que perfis distintos executem etapas diferentes do processo operacional.

O foco identificado no código-fonte está no ciclo:

1. autenticação do usuário;
2. início da rota pelo motorista;
3. registro de coletas durante o trajeto;
4. finalização da rota;
5. recebimento da rota por um recebedor.

Embora o nome do projeto sugira um contexto laboratorial mais amplo, a implementação analisada concentra-se principalmente na logística e na rastreabilidade do transporte.

## 2. Objetivo do Sistema

Com base no que está implementado no repositório, o TRACE-LAB tem como objetivo:

- registrar a abertura de rotas de transporte;
- identificar veículo, turno e bolsa utilizada;
- permitir o lançamento de eventos de coleta com temperatura e observações;
- manter o histórico cronológico das coletas;
- controlar o encerramento da rota;
- disponibilizar rotas encerradas para recebimento;
- registrar temperatura e integridade no recebimento final;
- separar o acesso por perfis operacionais.

Não foram identificadas, na base atual, implementações completas para:

- cadastro de pacientes;
- cadastro de exames;
- emissão de laudos;
- registro de resultados laboratoriais.

Esses pontos podem ser tratados como evolução futura, mas não devem ser apresentados como funcionalidades concluídas.

## 3. Tecnologias Utilizadas

| Tecnologia | Finalidade | Observação |
|---|---|---|
| Django | Backend web | Base do servidor principal |
| Django REST Framework | API REST | Implementação de `APIView`, serializadores e respostas JSON |
| Simple JWT | Autenticação | Emissão e renovação de tokens JWT |
| Flutter | Aplicativo cliente | Interface mobile para motoristas e recebedores |
| Dart package `http` | Integração frontend/backend | Consumo de endpoints REST |
| SQLite | Persistência atual | Banco configurado em ambiente de desenvolvimento |
| CORS Headers | Integração local | Permite chamadas do app para o backend local |
| Git/GitHub | Versionamento | Repositório remoto identificado no `origin` |

## 4. Estrutura de Diretórios

```text
backend/
  accounts/
  config/
  core/
  routes_app/
docs/
mobile/
  lib/
    app/
    core/
    features/
```

### Interpretação da estrutura

- `backend/accounts`: autenticação e autorização por papel.
- `backend/routes_app`: domínio principal de rotas, coletas e recebimento.
- `backend/core`: app base do projeto, hoje com baixa participação funcional.
- `mobile/lib/core`: configuração, rede, tema e strings globais.
- `mobile/lib/features`: organização por funcionalidades, separando telas, serviços, DTOs e modelos.

Essa estrutura sugere uma separação coerente de responsabilidades, com backend modular e frontend organizado por features.

## 5. Arquitetura da Solução

### Visão conceitual

```text
Usuário
↓
Aplicativo Flutter
↓
API REST
↓
Camada de serviços e validação
↓
Modelos Django
↓
Banco SQLite
```

### Backend

O backend utiliza Django 4.2 com Django REST Framework. As rotas são expostas por meio de classes baseadas em `APIView`, protegidas por autenticação JWT e por permissões específicas de perfil.

Papéis identificados:

- `driver`
- `receiver`
- `admin`

Permissões específicas:

- `IsDriverOrAdmin`
- `IsReceiverOrAdmin`
- `IsAdminRole`

### Frontend

O aplicativo Flutter segue uma abordagem orientada por funcionalidades. Em cada módulo, há separação entre:

- DTOs
- serviços
- modelos de domínio
- telas
- widgets

Essa organização reduz acoplamento e favorece manutenção.

### Banco de Dados

O banco configurado no projeto é SQLite, suficiente para ambiente acadêmico e desenvolvimento local. O MER mostra um modelo simples, coerente com o escopo atual.

## 6. Modelo de Dados

## 6.1 Entidades principais

### Usuário

Representa o operador autenticado no sistema. O modelo personalizado adiciona o campo `role`, que define o perfil de uso.

### Rota

Entidade central do transporte. Armazena:

- nome da rota;
- tipo de veículo;
- turno;
- identificação da bolsa;
- observações;
- status;
- data e hora de início;
- data e hora de término;
- motorista responsável.

### Coleta

Cada coleta representa um evento ocorrido durante a rota. Os registros incluem:

- local da coleta;
- temperatura registrada;
- observações;
- horário da coleta.

### Recebimento

Representa o fechamento do ciclo logístico. Inclui:

- nome do recebedor;
- temperatura de recebimento;
- integridade das amostras;
- observações;
- horário do recebimento.

## 6.2 Relacionamentos

- um usuário pode possuir várias rotas;
- uma rota pode possuir várias coletas;
- uma rota pode possuir um único recebimento.

## 6.3 MER analisado

![Modelo entidade-relacionamento do TRACE-LAB](MER-trace-lab.png)

Observação: o MER anexado também apresenta tabelas padrão do ecossistema Django, como autenticação, permissões, sessões e logs administrativos.

## 7. Fluxos Implementados

## 7.1 Fluxo de autenticação

1. O usuário informa `username` e `password`.
2. O backend retorna `access`, `refresh` e dados resumidos do usuário.
3. O frontend armazena o token de acesso em memória.
4. A tela `RoleGateScreen` encaminha o usuário conforme seu papel.

## 7.2 Fluxo do motorista

1. O motorista acessa a tela inicial do seu perfil.
2. Inicia uma nova rota.
3. O sistema gera nome da rota, turno e identificador da bolsa.
4. Durante a execução, o motorista adiciona eventos de coleta.
5. Ao finalizar, a rota muda para `finished`.
6. O usuário visualiza um resumo com indicadores operacionais e de temperatura.

## 7.3 Fluxo do recebedor

1. O recebedor acessa a fila de rotas finalizadas pendentes.
2. Seleciona uma rota para recebimento.
3. Informa nome, temperatura e condição das amostras.
4. O sistema grava o recebimento e conclui o fluxo.

## 7.4 Regra de separação de papéis

O projeto já evidencia uma preocupação importante: o fluxo do motorista deve permanecer separado do fluxo do recebedor. Essa regra é sensível em sistemas de rastreabilidade porque evita confusão operacional e reduz risco de navegação incorreta entre perfis.

## 8. Endpoints Identificados

| Método | Endpoint | Finalidade |
|---|---|---|
| `POST` | `/api/auth/login/` | autenticação |
| `POST` | `/api/auth/refresh/` | renovação de token |
| `POST` | `/api/routes/` | criação de rota |
| `GET` | `/api/routes/<id>/` | detalhamento de rota |
| `GET` | `/api/routes/<id>/collections/` | listagem de coletas |
| `POST` | `/api/routes/<id>/collections/` | criação de coleta |
| `POST` | `/api/routes/<id>/finish/` | encerramento de rota |
| `POST` | `/api/routes/<id>/receiving/` | registro de recebimento |
| `GET` | `/api/routes/pending-receiving/` | fila de rotas pendentes para recebimento |

## 9. Pontos Fortes do Projeto

- separação entre backend e frontend;
- autenticação baseada em JWT;
- uso de papéis operacionais claros;
- estrutura Flutter orientada por features;
- modelo de dados simples e coerente com o problema;
- implementação já funcional para um ciclo real de transporte e recebimento.

## 10. Limitações Observadas

### Testes automatizados

Os arquivos de teste encontrados estão praticamente vazios no backend, e o Flutter mantém apenas o teste padrão inicial do template. Isso indica que a camada de testes ainda não acompanha a evolução do sistema.

### Cobertura funcional

O nome TRACE-LAB sugere um escopo laboratorial completo, porém a implementação atual cobre essencialmente a logística de transporte. Isso não é um problema em si, mas deve ser explicitado na documentação para não gerar expectativa incorreta.

### Painel administrativo

O painel do perfil administrador ainda está em estágio embrionário.

### Persistência e ambiente

O projeto está configurado com SQLite, adequado para contexto acadêmico e prototipação, mas normalmente insuficiente para operação institucional com múltiplos usuários simultâneos.

## 11. Possibilidades de Evolução

Com base na arquitetura atual, o sistema pode evoluir para:

- auditoria mais detalhada das operações;
- relatórios gerenciais;
- exportação de dados;
- rastreamento por geolocalização;
- dashboard administrativo mais completo;
- testes automatizados de backend e frontend;
- migração para banco relacional de produção, como PostgreSQL.

Esses itens são possibilidades técnicas compatíveis com a estrutura, não funcionalidades confirmadas no estado atual do código.

## 12. Conclusão

O TRACE-LAB apresenta uma base consistente para controle de transporte e recebimento de amostras. A solução já demonstra autenticação por perfil, API REST, modelagem relacional coerente e uma interface mobile voltada à operação.

Para uso acadêmico, o projeto é adequado como estudo aplicado de arquitetura full stack, rastreabilidade e segregação de fluxos operacionais. Para evolução profissional, os próximos passos mais relevantes são ampliação da cobertura funcional, melhoria do módulo administrativo e fortalecimento da estratégia de testes.

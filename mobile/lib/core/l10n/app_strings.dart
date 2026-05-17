class AppStrings {
  AppStrings._();

  static const appName = 'TransportApp';

  // Auth
  static const loginTitle = 'Entrar';
  static const loginSubtitle = 'Acesse sua área operacional no TraceLab.';
  static const loginLoading = 'Acessando...';
  static const emailLabel = 'E-mail';
  static const usernameLabel = 'Usuário';
  static const usernameHint = 'Ex.: driver1';
  static const passwordLabel = 'Senha';
  static const passwordHint = 'Digite sua senha';
  static const loginButton = 'Acessar';
  static const logoutButton = 'Sair';
  static const restrictedAccessMessage =
      'Acesso restrito a usuários autorizados.';
  static const unauthorizedRole = 'Perfil não autorizado';
  static const appTagline = 'Inteligência no transporte de amostras';

  // Common
  static const continueButton = 'Continuar';
  static const cancelButton = 'Cancelar';
  static const saveButton = 'Salvar';
  static const confirmButton = 'Confirmar';
  static const backButton = 'Voltar';
  static const requiredField = 'Campo obrigatório';
  static const genericError = 'Não foi possível concluir a operação.';
  static const invalidCredentials =
      'Usuário ou senha incorretos. Verifique suas credenciais e tente novamente.';
  static const loading = 'Carregando...';
  static const noRecordsFound = 'Nenhum registro encontrado.';

  // Driver
  static const driverHomeTitle = 'Início do motorista';
  static const driverMode = 'Modo motorista';
  static const driverReadyStatus = 'PRONTO';
  static const driverReadyTitle = 'Pronto para iniciar uma nova rota de amostras?';
  static const driverReadyDescription =
      'Inicie sua rota, registre cada ponto de coleta e mantenha a linha do tempo do transporte rastreável.';
  static const startRoute = 'Iniciar rota';
  static const routeNotStarted = 'Não iniciada';
  static const manualMode = 'Manual';
  static const assignedRoutes = 'Rotas atribuídas';
  static const temperatureShortLabel = 'Temp.';
  static const pickupEventsTitle = 'Eventos de coleta';
  static const pickupEventsDescription =
      'Registre cada parada com temperatura e observações.';
  static const liveTimelineTitle = 'Linha do tempo';
  static const liveTimelineDescription =
      'Cada evento da rota será registrado em ordem cronológica.';
  static const traceabilityTitle = 'Rastreabilidade';
  static const traceabilityDescription =
      'A conclusão da rota preparará a etapa de recebimento.';
  static const registerPickupTemperature = 'Registrar temperatura de retirada';
  static const pickupTemperature = 'Temperatura de retirada';
  static const confirmPickup = 'Confirmar retirada';

  // Admin
  static const adminDashboardTitle = 'Painel administrativo';
  static const adminLabel = 'Administrador';

  // Receiver
  static const receiverHomeTitle = 'Início do recebimento';
  static const receiverMode = 'Modo recebimento';
  static const pendingRoutes = 'Rotas pendentes';
  static const pendingReceivingTitle = 'Recebimentos pendentes';
  static const receivingQueueTitle = 'Fila de recebimento';
  static const receivingQueueDescription =
      'Revise as rotas finalizadas e registre a temperatura de recebimento, a condição das amostras e as observações.';
  static const routesWaitingSuffix = 'rotas aguardando';
  static const bagLabel = 'Bolsa';
  static const collectionsLabel = 'coletas';
  static const finishedLabel = 'Finalizada';
  static const noRoutesWaitingTitle = 'Nenhuma rota aguardando';
  static const noRoutesWaitingDescription =
      'As rotas de transporte finalizadas aparecerão aqui quando estiverem prontas para o recebimento.';
  static const pendingRoutesLoadError =
      'Não foi possível carregar as rotas pendentes.';
  static const receiveRoute = 'Receber rota';
  static const receiverName = 'Nome do recebedor';
  static const registerReceivingTemperature = 'Registrar temperatura de recebimento';
  static const receivingTemperature = 'Temperatura de recebimento';
  static const integrityStatus = 'Condição das amostras';
  static const notes = 'Observações';
  static const confirmReceiving = 'Confirmar recebimento';
  static const receivingTitle = 'Recebimento';
  static const registerReceivingTitle = 'Registrar recebimento';
  static const receivingIntro =
      'Finalize o ciclo de transporte registrando os dados de recebimento desta rota.';
  static const routeContext = 'Contexto da rota';
  static const routeLabel = 'Rota';
  static const vehicleLabel = 'Veículo';
  static const shiftLabel = 'Turno';
  static const bagIdLabel = 'Identificação da bolsa';
  static const receivingDetails = 'Detalhes do recebimento';
  static const receivingDetailsDescription =
      'Registre quem recebeu a rota, a temperatura de recebimento e a condição das amostras.';
  static const receiverNameHint = 'Ex.: João Kasprowicz';
  static const receivingTemperatureLabel = 'Temperatura de recebimento (°C)';
  static const temperatureHint = 'Ex.: 6,1';
  static const notesHint = 'Adicione observações do recebimento';
  static const integrityStatusOk = 'OK';
  static const integrityStatusRestricted = 'Com ressalva';
  static const integrityStatusRejected = 'Rejeitado';
  static const requiredSuffix = 'é obrigatório';
  static const temperatureRequired = 'A temperatura é obrigatória.';
  static const integrityStatusRequired = 'A condição das amostras é obrigatória.';
  static const receivingRegisteredSuccessfully =
      'Recebimento registrado com sucesso.';
  static const receivingSaveInProgress = 'Salvando...';

  // Receiving success
  static const receivingSuccessTitle = 'Recebimento concluído';
  static const receivingSuccessMessage =
      'As amostras foram recebidas e registradas com sucesso.';
  static const backToReceiverHome = 'Voltar para o início do recebimento';

  // Errors
  static const invalidTemperature = 'Informe uma temperatura válida.';
  static const routeLoadError = 'Não foi possível carregar as rotas.';
  static const receivingSaveError = 'Não foi possível salvar o recebimento.';
}

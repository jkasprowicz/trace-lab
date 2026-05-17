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
  static const activeRouteLiveStatus = 'ROTA EM ANDAMENTO';
  static const activeRouteFinishedStatus = 'ROTA FINALIZADA';
  static const activeRouteStartedNow = 'Iniciada agora';
  static const activeRouteClosed = 'Encerrada';
  static const activeRouteIntro =
      'Rota em andamento. Acompanhe coletas, registros de temperatura e eventos operacionais em tempo real.';
  static const activeRouteSummaryTitle = 'Resumo operacional';
  static const activeRouteSummaryDescription =
      'Contexto da rota em andamento e metadados do transporte.';
  static const addCollection = 'Adicionar coleta';
  static const collectionAddedSuccessfully = 'Coleta adicionada com sucesso.';
  static const finishRouteTitle = 'Finalizar rota';
  static const finishRouteConfirmation =
      'Tem certeza de que deseja finalizar esta rota? Após a finalização, não será possível adicionar novas coletas.';
  static const finishRouteAction = 'Finalizar';
  static const routeFinishedSuccessfully = 'Rota finalizada com sucesso.';
  static const finishRouteError = 'Não foi possível finalizar a rota.';
  static const routeFinishedLabel = 'Rota finalizada';
  static const finishingRoute = 'Finalizando...';
  static const collectionTimelineTitle = 'Linha do tempo das coletas';
  static const noCollectionsYetTitle = 'Nenhuma coleta registrada ainda';
  static const noCollectionsYetDescription =
      'Comece adicionando o primeiro evento de coleta desta rota.';
  static const collectionTemperatureLabel = 'Temperatura';
  static const logoutCta = 'Sair da conta';
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
  static const addCollectionScreenTitle = 'Adicionar coleta';
  static const registerPickupTitle = 'Registrar coleta';
  static const registerPickupDescription =
      'Registre o local e a temperatura do ponto de coleta atual.';
  static const collectionDetailsTitle = 'Detalhes da coleta';
  static const collectionDetailsDescription =
      'Registre o ponto de retirada e a temperatura da coleta para esta rota.';
  static const locationNameLabel = 'Nome do local';
  static const locationNameHint = 'Ex.: Unidade Centro';
  static const useCurrentLocation = 'Usar localização atual';
  static const locationCaptureNotImplemented =
      'Captura de localização ainda não implementada.';
  static const collectionLocationPreparationDescription =
      'Você pode informar o nome do local manualmente ou preparar o uso da localização atual para uma futura integração.';
  static const collectionTemperatureFieldLabel = 'Temperatura (°C)';
  static const collectionTemperatureHint = 'Ex.: 5,2';
  static const collectionNotesHint =
      'Adicione observações operacionais desta coleta';
  static const saveCollection = 'Salvar coleta';
  static const saveCollectionInProgress = 'Salvando...';
  static const addCollectionError = 'Não foi possível adicionar a coleta.';
  static const backToHome = 'Voltar ao início';
  static const startRouteTitle = 'Iniciar rota';
  static const initializeTransportTitle = 'Iniciar transporte';
  static const initializeTransportDescription =
      'Defina o veículo e revise o contexto operacional antes de iniciar as atividades em campo.';
  static const routeDetailsTitle = 'Detalhes da rota';
  static const routeDetailsDescription =
      'Revise os dados operacionais antes de habilitar o acompanhamento da rota.';
  static const routeNameGeneratedLabel = 'Nome da rota';
  static const routeNameGeneratedHint = 'Gerado automaticamente';
  static const vehicleTypeLabel = 'Tipo de veículo';
  static const shiftLabelAuto = 'Turno';
  static const shiftAutoHint = 'Definido automaticamente pelo horário local';
  static const bagIdGeneratedHint = 'Gerado automaticamente';
  static const routeNotesHint = 'Adicione observações operacionais para esta rota';
  static const startRouteInProgress = 'Iniciando...';
  static const routeStartedSuccessfully = 'Rota iniciada com sucesso.';
  static const startRouteError = 'Não foi possível iniciar a rota.';
  static const routeSummaryStatus = 'ROTA FINALIZADA';
  static const routeSummaryDescription =
      'Operação de transporte concluída com sucesso. Revise abaixo o resumo da rota.';
  static const startedLabel = 'Iniciada';
  static const operationalSummaryTitle = 'Resumo operacional';
  static const temperatureSummaryTitle = 'Resumo de temperatura';
  static const minLabel = 'Mín.';
  static const avgLabel = 'Média';
  static const maxLabel = 'Máx.';
  static const noCollectionsRegisteredTitle = 'Nenhuma coleta registrada';
  static const noCollectionsRegisteredDescription =
      'Esta rota foi concluída sem registros de coleta.';

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

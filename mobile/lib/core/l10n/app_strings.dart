class AppStrings {
  AppStrings._();

  static const appName = 'TransportApp';

  // Auth
  static const loginTitle = 'Entrar';
  static const emailLabel = 'E-mail';
  static const passwordLabel = 'Senha';
  static const loginButton = 'Acessar';
  static const logoutButton = 'Sair';

  // Common
  static const continueButton = 'Continuar';
  static const cancelButton = 'Cancelar';
  static const saveButton = 'Salvar';
  static const confirmButton = 'Confirmar';
  static const backButton = 'Voltar';
  static const requiredField = 'Campo obrigatório';
  static const genericError = 'Não foi possível concluir a operação.';
  static const loading = 'Carregando...';
  static const noRecordsFound = 'Nenhum registro encontrado.';

  // Driver
  static const driverHomeTitle = 'Início do motorista';
  static const startRoute = 'Iniciar rota';
  static const assignedRoutes = 'Rotas atribuídas';
  static const registerPickupTemperature = 'Registrar temperatura de retirada';
  static const pickupTemperature = 'Temperatura de retirada';
  static const confirmPickup = 'Confirmar retirada';

  // Receiver
  static const receiverHomeTitle = 'Início do recebimento';
  static const pendingRoutes = 'Rotas pendentes';
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

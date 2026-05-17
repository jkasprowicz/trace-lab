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
import 'core/services/network_api_caller.dart';
import 'features/auth/presentation/providers/auth_controller.dart';

NetworkCaller getNetworkcaller() {
  NetworkCaller networkCaller = NetworkCaller(
    headers: {
      'Content-Type': 'application/json',
      'token': AuthController.accessToken ?? ''
    },
    onUnauthorize: () {
      // TODO: navigate to login
    },
  );

  return networkCaller;
}

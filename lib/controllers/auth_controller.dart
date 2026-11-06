import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../routes/routes.dart';

class AuthController extends GetxController {
  final GetStorage storage = GetStorage();

  final RxString username = ''.obs;

  bool get isLoggedIn {
    return storage.read('isLoggedIn') == true;
  }

  String get savedUsername {
    return storage.read('username') ?? 'Admin';
  }

  bool get rememberLogin {
    return storage.read('rememberLogin') ?? false;
  }

  void login({
    required String inputUsername,
    required String inputPassword,
    required bool remember,
  }) {
    if (inputUsername.trim().isEmpty || inputPassword.isEmpty) {
      Get.snackbar(
        'Login gagal',
        'Username dan password wajib diisi.',
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    if (inputUsername.trim() == 'admin' && inputPassword == 'admin') {
      username.value = 'admin';

      storage.write('username', 'admin');

      storage.write('rememberLogin', remember);

      storage.write('isLoggedIn', remember);

      Get.offAllNamed(Routes.home);
    } else {
      Get.snackbar(
        'Login gagal',
        'Username atau password salah.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void logout() {
    storage.remove('isLoggedIn');
    storage.remove('rememberLogin');

    username.value = '';

    Get.offAllNamed(Routes.login);
  }
}

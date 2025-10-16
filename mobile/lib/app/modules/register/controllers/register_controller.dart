import 'package:get/get.dart';
import 'package:salonku/app/core/controllers/auth_controller.dart';

class RegisterController extends GetxController {
  void logout() {
    AuthController.instance.signOut();
  }
}

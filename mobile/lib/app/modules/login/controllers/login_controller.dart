import 'package:get/get.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/core/controllers/auth_controller.dart';

class LoginController extends GetxController {
  var authCon = AuthController.instance;

  final RxBool isRegisterEmail = false.obs;
  final emailCon = InputTextController(type: InputTextType.email);
  final passCon = InputTextController(type: InputTextType.password);
  final confirmPassCon = InputTextController(type: InputTextType.password);

  void googleLoginOnPress() async {
    await authCon.signInWithGoogle();
  }

  void appleLoginOnPress() async {
    await authCon.signInWithApple();
  }

  void emailLogin() async {
    if (!emailCon.isValid && !passCon.isValid) return;

    await authCon.singInWithPassword(emailCon.value, passCon.value);
  }

  void emailRegister() async {
    if (!emailCon.isValid && !passCon.isValid && !confirmPassCon.isValid) {
      return;
    }
    if (passCon.value != confirmPassCon.value) {
      ReusableWidgets.notifBottomSheet(
        subtitle: "Password yang anda masukkan tidak sama",
      );
    }
    await authCon.signUpWithPassword(emailCon.value, confirmPassCon.value);
  }
}

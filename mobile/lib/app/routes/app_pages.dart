import 'package:get/get.dart';

import '../modules/base_page/bindings/base_page_binding.dart';
import '../modules/base_page/views/base_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/owner_approval/bindings/owner_approval_binding.dart';
import '../modules/owner_approval/views/owner_approval_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/register_salon/bindings/register_salon_binding.dart';
import '../modules/register_salon/views/register_salon_view.dart';
import '../modules/register_setup/bindings/register_setup_binding.dart';
import '../modules/register_setup/views/register_setup_view.dart';
import '../modules/service_list/bindings/service_list_binding.dart';
import '../modules/service_list/views/service_list_view.dart';
import '../modules/service_setup/bindings/service_setup_binding.dart';
import '../modules/service_setup/views/service_setup_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.BASE,
      page: () => const BasePageView(),
      binding: BasePageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_SETUP,
      page: () => const RegisterSetupView(),
      binding: RegisterSetupBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_SALON,
      page: () => const RegisterSalonView(),
      binding: RegisterSalonBinding(),
    ),
    GetPage(
      name: _Paths.OWNER_APPROVAL,
      page: () => const OwnerApprovalView(),
      binding: OwnerApprovalBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE_LIST,
      page: () => const ServiceListView(),
      binding: ServiceListBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE_SETUP,
      page: () => const ServiceSetupView(),
      binding: ServiceSetupBinding(),
    ),
  ];
}

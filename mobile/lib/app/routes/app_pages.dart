import 'package:get/get.dart';

import '../modules/base_page/bindings/base_page_binding.dart';
import '../modules/base_page/views/base_page_view.dart';
import '../modules/client_list/bindings/client_list_binding.dart';
import '../modules/client_list/views/client_list_view.dart';
import '../modules/client_setup/bindings/client_setup_binding.dart';
import '../modules/client_setup/views/client_setup_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notification_list/bindings/notification_list_binding.dart';
import '../modules/notification_list/views/notification_list_view.dart';
import '../modules/notification_setup/bindings/notification_setup_binding.dart';
import '../modules/notification_setup/views/notification_setup_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/owner_approval/bindings/owner_approval_binding.dart';
import '../modules/owner_approval/views/owner_approval_view.dart';
import '../modules/payment_method_list/bindings/payment_method_list_binding.dart';
import '../modules/payment_method_list/views/payment_method_list_view.dart';
import '../modules/payment_method_setup/bindings/payment_method_setup_binding.dart';
import '../modules/payment_method_setup/views/payment_method_setup_view.dart';
import '../modules/pengeluaran_list/bindings/pengeluaran_list_binding.dart';
import '../modules/pengeluaran_list/views/pengeluaran_list_view.dart';
import '../modules/pengeluaran_setup/bindings/pengeluaran_setup_binding.dart';
import '../modules/pengeluaran_setup/views/pengeluaran_setup_view.dart';
import '../modules/product_list/bindings/product_list_binding.dart';
import '../modules/product_list/views/product_list_view.dart';
import '../modules/product_setup/bindings/product_setup_binding.dart';
import '../modules/product_setup/views/product_setup_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/promo_list/bindings/promo_list_binding.dart';
import '../modules/promo_list/views/promo_list_view.dart';
import '../modules/promo_setup/bindings/promo_setup_binding.dart';
import '../modules/promo_setup/views/promo_setup_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/register_salon/bindings/register_salon_binding.dart';
import '../modules/register_salon/views/register_salon_view.dart';
import '../modules/register_setup/bindings/register_setup_binding.dart';
import '../modules/register_setup/views/register_setup_view.dart';
import '../modules/salon_cabang_list/bindings/salon_cabang_list_binding.dart';
import '../modules/salon_cabang_list/views/salon_cabang_list_view.dart';
import '../modules/salon_cabang_setup/bindings/salon_cabang_setup_binding.dart';
import '../modules/salon_cabang_setup/views/salon_cabang_setup_view.dart';
import '../modules/schedule_calendar/bindings/schedule_calendar_binding.dart';
import '../modules/schedule_calendar/views/schedule_calendar_view.dart';
import '../modules/service_list/bindings/service_list_binding.dart';
import '../modules/service_list/views/service_list_view.dart';
import '../modules/service_management_list/bindings/service_management_list_binding.dart';
import '../modules/service_management_list/views/service_management_list_view.dart';
import '../modules/service_management_setup/bindings/service_management_setup_binding.dart';
import '../modules/service_management_setup/views/service_management_setup_view.dart';
import '../modules/service_setup/bindings/service_setup_binding.dart';
import '../modules/service_setup/views/service_setup_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/staff_list/bindings/staff_list_binding.dart';
import '../modules/staff_list/views/staff_list_view.dart';
import '../modules/staff_setup/bindings/staff_setup_binding.dart';
import '../modules/staff_setup/views/staff_setup_view.dart';
import '../modules/supplier_list/bindings/supplier_list_binding.dart';
import '../modules/supplier_list/views/supplier_list_view.dart';
import '../modules/supplier_setup/bindings/supplier_setup_binding.dart';
import '../modules/supplier_setup/views/supplier_setup_view.dart';

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
    GetPage(
      name: _Paths.SALON_CABANG_LIST,
      page: () => const SalonCabangListView(),
      binding: SalonCabangListBinding(),
    ),
    GetPage(
      name: _Paths.SALON_CABANG_SETUP,
      page: () => const SalonCabangSetupView(),
      binding: SalonCabangSetupBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_LIST,
      page: () => const ProductListView(),
      binding: ProductListBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_SETUP,
      page: () => const ProductSetupView(),
      binding: ProductSetupBinding(),
    ),
    GetPage(
      name: _Paths.SUPPLIER_LIST,
      page: () => const SupplierListView(),
      binding: SupplierListBinding(),
    ),
    GetPage(
      name: _Paths.SUPPLIER_SETUP,
      page: () => const SupplierSetupView(),
      binding: SupplierSetupBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_METHOD_LIST,
      page: () => const PaymentMethodListView(),
      binding: PaymentMethodListBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_METHOD_SETUP,
      page: () => const PaymentMethodSetupView(),
      binding: PaymentMethodSetupBinding(),
    ),
    GetPage(
      name: _Paths.CLIENT_LIST,
      page: () => const ClientListView(),
      binding: ClientListBinding(),
    ),
    GetPage(
      name: _Paths.CLIENT_SETUP,
      page: () => const ClientSetupView(),
      binding: ClientSetupBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE_MANAGEMENT_LIST,
      page: () => const ServiceManagementListView(),
      binding: ServiceManagementListBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE_MANAGEMENT_SETUP,
      page: () => const ServiceManagementSetupView(),
      binding: ServiceManagementSetupBinding(),
    ),
    GetPage(
      name: _Paths.STAFF_LIST,
      page: () => const StaffListView(),
      binding: StaffListBinding(),
    ),
    GetPage(
      name: _Paths.STAFF_SETUP,
      page: () => const StaffSetupView(),
      binding: StaffSetupBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_LIST,
      page: () => const NotificationListView(),
      binding: NotificationListBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_SETUP,
      page: () => const NotificationSetupView(),
      binding: NotificationSetupBinding(),
    ),
    GetPage(
      name: _Paths.SCHEDULE_CALENDAR,
      page: () => const ScheduleCalendarView(),
      binding: ScheduleCalendarBinding(),
    ),
    GetPage(
      name: _Paths.PROMO_LIST,
      page: () => const PromoListView(),
      binding: PromoListBinding(),
    ),
    GetPage(
      name: _Paths.PROMO_SETUP,
      page: () => const PromoSetupView(),
      binding: PromoSetupBinding(),
    ),
    GetPage(
      name: _Paths.PENGELUARAN_LIST,
      page: () => const PengeluaranListView(),
      binding: PengeluaranListBinding(),
    ),
    GetPage(
      name: _Paths.PENGELUARAN_SETUP,
      page: () => const PengeluaranSetupView(),
      binding: PengeluaranSetupBinding(),
    ),
  ];
}

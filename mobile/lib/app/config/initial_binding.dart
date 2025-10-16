import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:salonku/app/core/controllers/auth_controller.dart';
import 'package:salonku/app/data/providers/api/user_salon_provider.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/providers/local/local_data_source_impl.dart';
import 'package:salonku/app/data/providers/network/dio_client.dart';
import 'package:salonku/app/data/repositories/contract/user_salon_repository_contract.dart';
import 'package:salonku/app/data/repositories/implementation/user_salon_repository_impl.dart';
import 'package:salonku/app/services/base_api_service.dart';
import 'package:salonku/app/services/error_handler_service.dart';
import 'package:salonku/app/services/notification_service.dart';

// ===== COMPLETE INITIAL BINDING =====
// config/initial_binding.dart
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    developer.log(
      '🚀 Initializing app dependencies...',
      name: 'INITIAL_BINDING',
    );

    // ===== PHASE 1: ASYNC SERVICES (Critical Foundation) =====
    _initAsyncServices();

    // ===== PHASE 2: CORE SERVICES (Essential Services) =====
    _initCoreServices();

    // ===== PHASE 3: NETWORK SERVICES (API Related) =====
    _initNetworkServices();

    // // ===== PHASE 4: API PROVIDERS (Lazy Loaded) =====
    _initApiProviders();

    // // ===== PHASE 5: REPOSITORIES (Business Logic) =====
    _initRepositories();
  }

  // ===== PHASE 1: ASYNC SERVICES =====
  void _initAsyncServices() {
    developer.log(
      'Phase 1: Initializing async services...',
      name: 'INITIAL_BINDING',
    );

    Get.putAsync<LocalDataSource>(() async {
      final helper = LocalDataSourceImpl();
      await helper.init();
      developer.log('✓ PreferencesHelper initialized', name: 'INITIAL_BINDING');

      return helper;
    }, permanent: true).then((v) {
      _initControllers();
    });

    Get.putAsync<NotificationService>(() async {
      final service = NotificationService();
      await service.init();
      developer.log(
        '✓ NotificationService initialized',
        name: 'INITIAL_BINDING',
      );
      return service;
    }, permanent: true);
  }

  // ===== PHASE 2: CORE SERVICES =====
  void _initCoreServices() {
    developer.log(
      'Phase 2: Initializing core services...',
      name: 'INITIAL_BINDING',
    );

    // Error Handler Service - Must be available for all error handling
    Get.put<ErrorHandlerService>(ErrorHandlerService(), permanent: true);
  }

  // ===== PHASE 3: NETWORK SERVICES =====
  void _initNetworkServices() {
    developer.log(
      'Phase 3: Initializing network services...',
      name: 'INITIAL_BINDING',
    );

    // Dio Client - Core HTTP client with all interceptors
    Get.put<Dio>(DioClient.instance, permanent: true);

    // Base API Service - Foundation for all API calls
    Get.put<BaseApiService>(BaseApiService(), permanent: true);
  }

  // ===== PHASE 4: API PROVIDERS (Lazy Loaded) =====
  void _initApiProviders() {
    developer.log(
      'Phase 4: Registering API providers...',
      name: 'INITIAL_BINDING',
    );

    Get.lazyPut<UserSalonProvider>(() => UserSalonProvider(), fenix: true);
    // Get.lazyPut<UserProvider>(() => UserProvider(), fenix: true);
    // Get.lazyPut<OtpProvider>(() => OtpProvider(), fenix: true);
  }

  // // ===== PHASE 5: REPOSITORIES (Business Logic) =====
  void _initRepositories() {
    developer.log(
      'Phase 5: Registering repositories...',
      name: 'INITIAL_BINDING',
    );

    // Init Repository
    Get.lazyPut<UserSalonRepositoryContract>(() => UserSalonRepositoryImpl());
  }

  // // ===== PHASE 6: CONTROLLER ( =====
  void _initControllers() {
    developer.log(
      '🏗️ Phase 6: Registering controllers...',
      name: 'INITIAL_BINDING',
    );

    Get.lazyPut<AuthController>(
      () => AuthController(
        Get.find<UserSalonRepositoryContract>(),
        Get.find<LocalDataSource>(),
      ),
    );
    AuthController.instance;
  }
}

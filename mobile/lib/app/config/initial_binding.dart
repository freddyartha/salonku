import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/providers/local/local_data_source_impl.dart';
import 'package:salonku/app/data/providers/network/dio_client.dart';
import 'package:salonku/app/services/auth_service.dart';
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
    // _initApiProviders();

    // // ===== PHASE 5: REPOSITORIES (Business Logic) =====
    // _initRepositories();

    developer.log(
      '✅ All dependencies initialized successfully',
      name: 'INITIAL_BINDING',
    );
  }

  // ===== PHASE 1: ASYNC SERVICES =====
  void _initAsyncServices() {
    developer.log(
      '📦 Phase 1: Initializing async services...',
      name: 'INITIAL_BINDING',
    );

    Get.putAsync<LocalDataSource>(() async {
      final helper = LocalDataSourceImpl();
      await helper.init();
      developer.log('✓ PreferencesHelper initialized', name: 'INITIAL_BINDING');

      // Trigger AuthService full initialization after storage is ready
      _triggerAuthServiceFullInit();

      return helper;
    }, permanent: true);

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

  void _triggerAuthServiceFullInit() {
    // Wait a bit then trigger full auth initialization
    Future.delayed(Duration(milliseconds: 100), () {
      try {
        if (Get.isRegistered<AuthService>()) {
          final authService = Get.find<AuthService>();
          authService.completeInitialization(); // New method we'll add
        }
      } catch (e) {
        developer.log(
          'Error triggering auth full init: $e',
          name: 'INITIAL_BINDING',
        );
      }
    });
  }

  // ===== PHASE 2: CORE SERVICES =====
  void _initCoreServices() {
    developer.log(
      '🔧 Phase 2: Initializing core services...',
      name: 'INITIAL_BINDING',
    );

    // Error Handler Service - Must be available for all error handling
    Get.put<ErrorHandlerService>(ErrorHandlerService(), permanent: true);
    developer.log('✓ ErrorHandlerService initialized', name: 'INITIAL_BINDING');

    // Auth Service - For authentication logic
    Get.put<AuthService>(AuthService(), permanent: true);
    developer.log('✓ AuthService initialized', name: 'INITIAL_BINDING');

    developer.log('✓ LocalizationService initialized', name: 'INITIAL_BINDING');
  }

  // ===== PHASE 3: NETWORK SERVICES =====
  void _initNetworkServices() {
    developer.log(
      '🌐 Phase 3: Initializing network services...',
      name: 'INITIAL_BINDING',
    );

    // Dio Client - Core HTTP client with all interceptors
    Get.put<Dio>(DioClient.instance, permanent: true);
    developer.log('✓ Dio Client initialized', name: 'INITIAL_BINDING');

    // Base API Service - Foundation for all API calls
    Get.put<BaseApiService>(BaseApiService(), permanent: true);
    developer.log('✓ BaseApiService initialized', name: 'INITIAL_BINDING');
  }

  // ===== PHASE 4: API PROVIDERS (Lazy Loaded) =====
  // void _initApiProviders() {
  //   developer.log(
  //     '🔌 Phase 4: Registering API providers...',
  //     name: 'INITIAL_BINDING',
  //   );

  //   // Get.lazyPut<AuthProvider>(() => AuthProvider(), fenix: true);
  //   // Get.lazyPut<UserProvider>(() => UserProvider(), fenix: true);
  //   // Get.lazyPut<OtpProvider>(() => OtpProvider(), fenix: true);

  //   developer.log('✓ API Providers registered', name: 'INITIAL_BINDING');
  // }

  // // ===== PHASE 5: REPOSITORIES (Business Logic) =====
  // void _initRepositories() {
  //   developer.log(
  //     '🏗️ Phase 5: Registering repositories...',
  //     name: 'INITIAL_BINDING',
  //   );

  //   // Init Repository
  //   // Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(), fenix: true);

  //   developer.log('✓ Repositories registered', name: 'INITIAL_BINDING');
  // }
}

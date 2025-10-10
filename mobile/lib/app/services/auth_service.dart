import 'dart:developer' as developer;

import 'package:get/get.dart';
import 'package:salonku/app/data/models/auth_model.dart';
import 'package:salonku/app/data/models/user_model.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/routes/app_pages.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  // ===== REACTIVE PROPERTIES =====
  final RxBool isLoggedIn = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isInitialized = false.obs; // Basic initialization
  final RxBool isFullyInitialized =
      false.obs; // Full initialization with storage
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxString authToken = ''.obs;

  // ===== DEPENDENCIES (NO REPOSITORY!) =====
  LocalDataSource get _localDataSource => Get.find<LocalDataSource>();

  @override
  void onInit() {
    super.onInit();
    _initializeBasicAuthService();
  }

  // ===== INITIALIZATION =====
  Future<void> _initializeBasicAuthService() async {
    try {
      developer.log(
        '🔐 Basic AuthService initialization...',
        name: 'AUTH_SERVICE',
      );

      // Set basic initialized state (allows middleware to work)
      isInitialized.value = true;

      developer.log('✅ Basic AuthService initialized', name: 'AUTH_SERVICE');
    } catch (e) {
      developer.log(
        '❌ Error in basic AuthService init: $e',
        name: 'AUTH_SERVICE',
      );
      isInitialized.value = true; // Set anyway to prevent blocking
    }
  }

  // ===== PHASE 2: FULL INITIALIZATION (ASYNC) =====
  Future<void> completeInitialization() async {
    try {
      if (isFullyInitialized.value) return; // Already done

      isLoading.value = true;
      developer.log(
        '🔐 Completing AuthService initialization...',
        name: 'AUTH_SERVICE',
      );

      // Wait for required services
      await _waitForRequiredServices();

      // Load saved auth data from storage
      await _loadAuthData();

      checkLoginStatus();

      isFullyInitialized.value = true;
      developer.log(
        '✅ Full AuthService initialization complete',
        name: 'AUTH_SERVICE',
      );
    } catch (e) {
      developer.log(
        '❌ Error in full AuthService init: $e',
        name: 'AUTH_SERVICE',
      );
      await clearAuthData();
    } finally {
      isLoading.value = false;
    }
  }

  void checkLoginStatus() {
    if (Get.currentRoute == Routes.SPLASH_SCREEN) {
      if (isAuthenticated) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    }
  }

  // ===== WAIT FOR REQUIRED SERVICES =====
  Future<void> _waitForRequiredServices() async {
    int attempts = 0;
    const maxAttempts = 50; // 5 seconds max

    while ((!_localDataSource.initialized) && attempts < maxAttempts) {
      await Future.delayed(Duration(milliseconds: 100));
      attempts++;
    }

    if (!_localDataSource.initialized) {
      throw Exception('PreferencesHelper not available after timeout');
    }
  }

  // ===== CORE STATE MANAGEMENT METHODS =====

  /// Load authentication data from storage
  Future<void> _loadAuthData() async {
    try {
      final user = _localDataSource.userData;
      final token = _localDataSource.getAccessToken();

      if (user != null && token.isNotEmpty) {
        currentUser.value = user;
        authToken.value = token;
        isLoggedIn.value = true;

        developer.log('📱 Auth data loaded from storage', name: 'AUTH_SERVICE');
      } else {
        developer.log('📱 No auth data found in storage', name: 'AUTH_SERVICE');
      }
    } catch (e) {
      developer.log('❌ Error loading auth data: $e', name: 'AUTH_SERVICE');
    }
  }

  // ===== PUBLIC METHODS (CALLED BY CONTROLLERS) =====

  /// Set authentication data (called by LoginController after successful login)
  Future<void> setAuthData(AuthModel authModel) async {
    try {
      currentUser.value = authModel.user;
      authToken.value = authModel.accessToken;
      isLoggedIn.value = true;

      // Save to storage
      await _localDataSource.cacheAuth(authModel);

      developer.log(
        '📱 Auth data set for user: ${authModel.user.name}',
        name: 'AUTH_SERVICE',
      );
    } catch (e) {
      developer.log('❌ Error setting auth data: $e', name: 'AUTH_SERVICE');
      rethrow;
    }
  }

  /// Update user data (called by ProfileController after profile update)
  Future<void> updateUserData(UserModel user) async {
    try {
      currentUser.value = user;

      // Update stored user data
      await _localDataSource.cacheUser(user);

      developer.log('👤 User data updated', name: 'AUTH_SERVICE');
    } catch (e) {
      developer.log('❌ Error updating user data: $e', name: 'AUTH_SERVICE');
    }
  }

  /// Clear all authentication data
  Future<void> clearAuthData() async {
    try {
      currentUser.value = null;
      authToken.value = '';
      isLoggedIn.value = false;

      // Clear from storage
      await _localDataSource.clearAllCache();

      developer.log('🗑️ Auth data cleared', name: 'AUTH_SERVICE');
    } catch (e) {
      developer.log('❌ Error clearing auth data: $e', name: 'AUTH_SERVICE');
    }
  }

  // ===== NAVIGATION LOGIC =====

  /// Determine where user should be navigated
  Future<NavigationTarget> determineInitialRoute() async {
    try {
      // Wait for service to be initialized
      await _waitForInitialization();

      developer.log('🧭 Determining initial route...', name: 'AUTH_SERVICE');

      // Check authentication status
      if (!isLoggedIn.value) {
        developer.log(
          '🔒 User not logged in - going to login',
          name: 'AUTH_SERVICE',
        );
        return NavigationTarget.login();
      }

      // All good, go to home
      developer.log(
        '🏠 User authenticated - going to home',
        name: 'AUTH_SERVICE',
      );
      return NavigationTarget.home();
    } catch (e) {
      developer.log('❌ Error determining route: $e', name: 'AUTH_SERVICE');
      return NavigationTarget.login();
    }
  }

  /// Navigate to appropriate screen based on auth status
  Future<void> navigateToAppropriateScreen() async {
    try {
      final target = await determineInitialRoute();

      switch (target.type) {
        case NavigationType.login:
          Get.offAllNamed(Routes.LOGIN);
          break;
        case NavigationType.home:
          Get.offAllNamed(Routes.HOME);
          break;
      }
    } catch (e) {
      developer.log('❌ Navigation error: $e', name: 'AUTH_SERVICE');
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  /// Handle successful login navigation (called by LoginController)
  Future<void> handleLoginSuccess() async {
    try {
      final target = await determineInitialRoute();

      if (target.type == NavigationType.home) {
        Get.offAllNamed(Routes.HOME);
      } else {
        // User needs additional setup
        navigateToAppropriateScreen();
      }
    } catch (e) {
      developer.log(
        '❌ Login success navigation error: $e',
        name: 'AUTH_SERVICE',
      );
      Get.offAllNamed(Routes.HOME);
    }
  }

  /// Handle logout navigation (called by any controller)
  Future<void> handleLogout() async {
    await clearAuthData();
    Get.offAllNamed(Routes.LOGIN);
  }

  // ===== UTILITY METHODS =====

  /// Wait for auth service to be initialized
  Future<void> _waitForInitialization() async {
    int attempts = 0;
    const maxAttempts = 50; // 5 seconds max

    while (!isInitialized.value && attempts < maxAttempts) {
      await Future.delayed(Duration(milliseconds: 100));
      attempts++;
    }

    if (!isInitialized.value) {
      throw Exception('AuthService initialization timeout');
    }
  }

  // ===== GETTERS =====
  bool get isAuthenticated => isLoggedIn.value && currentUser.value != null;
  bool get isGuest => !isLoggedIn.value;
  String get userName => currentUser.value?.name ?? '';
  String? get userAvatar => currentUser.value?.avatarUrl;
}

// ===== SUPPORTING CLASSES =====

enum NavigationType { login, home }

/// Navigation target wrapper
class NavigationTarget {
  final NavigationType type;
  final Map<String, dynamic>? arguments;

  NavigationTarget._(this.type, {this.arguments});

  factory NavigationTarget.login({Map<String, dynamic>? arguments}) {
    return NavigationTarget._(NavigationType.login, arguments: arguments);
  }

  factory NavigationTarget.home({Map<String, dynamic>? arguments}) {
    return NavigationTarget._(NavigationType.home, arguments: arguments);
  }
}

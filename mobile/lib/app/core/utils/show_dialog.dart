import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowDialog {
  static coreDialog({
    required BuildContext context,
    required Widget icon,
    required String title,
    required String description,
    required String onCancelText,
    required String onConfirmText,
    required void Function()? onCancel,
    required void Function()? onConfirm,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,

      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return PopScope(
          canPop: false,
          child: Center(
            child: Material(
              type: MaterialType.transparency,
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutBack,
                ),
                child: AlertDialog(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: EdgeInsets.all(24),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      icon,
                      SizedBox(height: 16),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      (description != "")
                          ? Column(
                            children: [
                              Text(
                                description,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 24),
                            ],
                          )
                          : const SizedBox.shrink(),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: onCancel,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                backgroundColor: Colors.grey[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                onCancelText,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: TextButton(
                              onPressed: onConfirm,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                onConfirmText,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          child: child,
        );
      },
    );
  }

  static coreLoadingDialog({
    required BuildContext context,
    String? loadingText,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible:
          false, // Biasanya loading dialog tidak bisa di-dismiss
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutBack,
              ),
              child: AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                contentPadding: EdgeInsets.all(24),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.redAccent,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      loadingText ?? "loading".tr,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          child: child,
        );
      },
    );
  }

  static void showDeleteAccountDialog(Function()? onTap) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: 60,
              color: Colors.redAccent,
            ),
            SizedBox(height: 16),
            Text(
              "confirm_delete_account".tr,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Text(
              "confirm_delete_account_description".tr,
              style: TextStyle(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Get.back(),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "cancel".tr,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextButton(
                    onPressed: onTap,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "delete_account".tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> showLogoutDialog(
    BuildContext context,
    VoidCallback onConfirm,
  ) {
    return coreDialog(
      context: context,
      icon: Icon(Icons.exit_to_app_rounded, size: 60, color: Colors.redAccent),
      title: "confirm_logout".tr,
      description: "logout_message".tr,
      onCancelText: "cancel".tr,
      onConfirmText: "Logout",
      onCancel: () => Get.back(),
      onConfirm: onConfirm,
    );
  }

  static Future<void> showError500(
    BuildContext context,
    VoidCallback onConfirm,
  ) {
    return coreDialog(
      context: context,
      icon: Icon(Icons.error, size: 60, color: Colors.redAccent),
      title: "internalerror".tr,
      description: "",
      onCancelText: "cancel".tr,
      onConfirmText: "retry".tr,
      onCancel: () => Get.back(),
      onConfirm: onConfirm,
    );
  }

  static Future<void> showErrorText(
    BuildContext context,
    String text,
    VoidCallback onConfirm,
  ) {
    return coreDialog(
      context: context,
      icon: Icon(Icons.error, size: 60, color: Colors.redAccent),
      title: text,
      description: "",
      onCancelText: "cancel".tr,
      onConfirmText: "retry".tr,
      onCancel: () => Get.back(),
      onConfirm: onConfirm,
    );
  }

  static Future<void> showWarningDialog({
    required BuildContext context,
    VoidCallback? onRetry,
    String? description,
    String? pathBack,
  }) {
    return coreDialog(
      context: context,
      icon: Icon(
        Icons.warning,
        size: MediaQuery.of(context).size.width * 0.25,
        color: Colors.orange,
      ),
      title: "title_warning_error".tr,
      description: description ?? "",
      onCancelText: "back".tr,
      onConfirmText: "try_again".tr,
      onCancel:
          () =>
              pathBack != ""
                  ? Get.until((route) => route.settings.name == pathBack)
                  : Get.back(),
      onConfirm: onRetry ?? () => Get.back(),
    );
  }

  static Future<void> showInfoDialog({
    required BuildContext context,
    required String description,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    String? pathBack,
  }) {
    return coreDialog(
      context: context,
      icon: Icon(
        Icons.info,
        size: MediaQuery.of(context).size.width * 0.25,
        color: Colors.lightBlue,
      ),
      title: "confirm_service_cancel_title".tr,
      description: description,
      onCancelText: "back".tr,
      onConfirmText: "confirm".tr,

      onCancel: onCancel ?? () => Get.back(),
      onConfirm: onConfirm ?? () => Get.back(),
    );
  }

  static Future<void> showConnectionError({
    required BuildContext context,
    VoidCallback? onRetry,
    String? pathBack,
  }) {
    return coreDialog(
      context: context,
      icon: Icon(
        Icons.wifi_off_rounded,
        size: MediaQuery.of(context).size.width * 0.25,
        color: Colors.orange,
      ),
      title: "modal_dialog_internet_error_title".tr,
      description: "modal_dialog_internet_error_desc".tr,
      onCancelText: "back".tr,
      onConfirmText: "try_again".tr,
      onCancel:
          () =>
              pathBack != ""
                  ? Get.until((route) => route.settings.name == pathBack)
                  : Get.back(),
      onConfirm: onRetry ?? () => Get.back(),
    );
  }

  static Future<void> showActionSuccessDialog({
    required BuildContext context,
    required String description,
    String? onConfirmText,
    VoidCallback? onConfirm,
    String? pathBack,
  }) {
    return coreDialog(
      context: context,
      icon: Icon(
        Icons.check_circle_rounded,
        size: MediaQuery.of(context).size.width * 0.25,
        color: Colors.green,
      ),
      title: "modal_dialog_success_title".tr,
      description: description,
      onCancelText: "back".tr,
      onConfirmText: onConfirmText ?? "confirm_success".tr,
      onCancel:
          () =>
              pathBack != ""
                  ? Get.until((route) => route.settings.name == pathBack)
                  : Get.back(),
      onConfirm: onConfirm ?? () => Get.back(),
    );
  }

  static Future<void> showSuccessDialog({
    required BuildContext context,
    required String title,
    String description = "",
    required VoidCallback onConfirm,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutBack,
              ),
              child: AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                contentPadding: const EdgeInsets.all(24),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      size: 60,
                      color: Colors.green, // Green color for success
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    (description.isNotEmpty)
                        ? Column(
                          children: [
                            Text(
                              description,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                          ],
                        )
                        : const SizedBox.shrink(),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: onConfirm,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor:
                              Colors.green, // Green button for success
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "OK",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          child: child,
        );
      },
    );
  }
}

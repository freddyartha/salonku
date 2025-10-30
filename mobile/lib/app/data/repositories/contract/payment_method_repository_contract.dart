import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/models/payment_method_model.dart';

abstract class PaymentMethodRepositoryContract {
  Future<Result<List<PaymentMethodModel>>> getPaymentMethodByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  });

  Future<Result<PaymentMethodModel>> getPaymentMethodById(int id);

  Future<Result<PaymentMethodModel>> createPaymentMethod(
    Map<String, dynamic> model,
  );

  Future<Result<PaymentMethodModel>> updatePaymentMethodById(
    int id,
    Map<String, dynamic> model,
  );

  Future<Result<List>> deletePaymentMethodById(int id);
}

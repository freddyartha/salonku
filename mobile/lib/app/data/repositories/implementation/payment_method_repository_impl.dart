import 'package:get/get.dart';
import 'package:salonku/app/core/base/base_repository.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/network/paged_api_response_parser.dart';
import 'package:salonku/app/data/network/simple_api_response_parser.dart';
import 'package:salonku/app/data/network/general_api_response_parser.dart';
import 'package:salonku/app/data/providers/api/payment_method_provider.dart';
import 'package:salonku/app/data/repositories/contract/payment_method_repository_contract.dart';
import 'package:salonku/app/models/payment_method_model.dart';

class PaymentMethodRepositoryImpl extends BaseRepository
    implements PaymentMethodRepositoryContract {
  final PaymentMethodProvider _provider = Get.find();

  @override
  Future<Result<List<PaymentMethodModel>>> getPaymentMethodByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  }) {
    return executeRequest(
      () => _provider.getPaymentMethodByIdSalon(
        idSalon: idSalon,
        pageIndex: pageIndex,
        pageSize: pageSize,
        keyword: keyword,
      ),
      PagedApiResponseParser(PaymentMethodModel.fromDynamic),
    );
  }

  @override
  Future<Result<PaymentMethodModel>> createPaymentMethod(
    Map<String, dynamic> model,
  ) {
    return executeRequest(
      () => _provider.createPaymentMethod(model),
      GeneralApiResponseParser(PaymentMethodModel.fromDynamic),
    );
  }

  @override
  Future<Result<PaymentMethodModel>> getPaymentMethodById(int id) {
    return executeRequest(
      () => _provider.getPaymentMethodById(id),
      GeneralApiResponseParser(PaymentMethodModel.fromDynamic),
    );
  }

  @override
  Future<Result<PaymentMethodModel>> updatePaymentMethodById(
    int id,
    Map<String, dynamic> model,
  ) {
    return executeRequest(
      () => _provider.updatePaymentMethod(id, model),
      GeneralApiResponseParser(PaymentMethodModel.fromDynamic),
    );
  }

  @override
  Future<Result<List>> deletePaymentMethodById(int id) {
    return executeRequest(
      () => _provider.deletePaymentMethodById(id),
      SimpleApiResponseParser((res) => []),
    );
  }
}

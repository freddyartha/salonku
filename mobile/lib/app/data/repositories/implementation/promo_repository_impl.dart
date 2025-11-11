import 'package:get/get.dart';
import 'package:salonku/app/core/base/base_repository.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/network/paged_api_response_parser.dart';
import 'package:salonku/app/data/network/simple_api_response_parser.dart';
import 'package:salonku/app/data/providers/api/promo_provider.dart';
import 'package:salonku/app/data/network/general_api_response_parser.dart';
import 'package:salonku/app/data/repositories/contract/promo_repository_contract.dart';
import 'package:salonku/app/models/promo_model.dart';

class PromoRepositoryImpl extends BaseRepository
    implements PromoRepositoryContract {
  final PromoProvider _provider = Get.find();

  @override
  Future<Result<List<PromoModel>>> getPromoByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  }) {
    return executeRequest(
      () => _provider.getPromoByIdSalon(
        idSalon: idSalon,
        pageIndex: pageIndex,
        pageSize: pageSize,
        keyword: keyword,
      ),
      PagedApiResponseParser(PromoModel.fromDynamic),
    );
  }

  @override
  Future<Result<PromoModel>> createPromo(Map<String, dynamic> model) {
    return executeRequest(
      () => _provider.createPromo(model),
      GeneralApiResponseParser(PromoModel.fromDynamic),
    );
  }

  @override
  Future<Result<PromoModel>> getPromoById(int id) {
    return executeRequest(
      () => _provider.getPromoById(id),
      GeneralApiResponseParser(PromoModel.fromDynamic),
    );
  }

  @override
  Future<Result<PromoModel>> updatePromoById(
    int id,
    Map<String, dynamic> model,
  ) {
    return executeRequest(
      () => _provider.updatePromo(id, model),
      GeneralApiResponseParser(PromoModel.fromDynamic),
    );
  }

  @override
  Future<Result<List>> deletePromoById(int id) {
    return executeRequest(
      () => _provider.deletePromoById(id),
      SimpleApiResponseParser((res) => []),
    );
  }
}

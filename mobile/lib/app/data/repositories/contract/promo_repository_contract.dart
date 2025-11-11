import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/models/promo_model.dart';

abstract class PromoRepositoryContract {
  Future<Result<List<PromoModel>>> getPromoByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  });

  Future<Result<PromoModel>> getPromoById(int id);

  Future<Result<PromoModel>> createPromo(Map<String, dynamic> model);

  Future<Result<PromoModel>> updatePromoById(
    int id,
    Map<String, dynamic> model,
  );

  Future<Result<List>> deletePromoById(int id);
}

import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/models/product_model.dart';

abstract class ProductRepositoryContract {
  Future<Result<List<ProductModel>>> getProductByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  });

  Future<Result<ProductModel>> getProductById(int id);

  Future<Result<ProductModel>> createProduct(Map<String, dynamic> model);

  Future<Result<ProductModel>> updateProductById(
    int id,
    Map<String, dynamic> model,
  );

  Future<Result<List>> deleteProductById(int id);
}

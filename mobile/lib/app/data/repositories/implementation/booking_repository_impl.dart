import 'package:get/get.dart';
import 'package:salonku/app/core/base/base_repository.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/network/paged_api_response_parser.dart';
import 'package:salonku/app/data/providers/api/booking_provider.dart';
import 'package:salonku/app/data/repositories/contract/booking_repository_contract.dart';
import 'package:salonku/app/models/booking_model.dart';

class BookingRepositoryImpl extends BaseRepository
    implements BookingRepositoryContract {
  final BookingProvider _provider = Get.find();

  @override
  Future<Result<List<BookingModel>>> getBookingByUserId({
    required int idUser,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  }) {
    return executeRequest(
      () => _provider.getBookingByUserId(
        idUser: idUser,
        pageIndex: pageIndex,
        pageSize: pageSize,
        keyword: keyword,
      ),
      PagedApiResponseParser(BookingModel.fromDynamic),
    );
  }

  // @override
  // Future<Result<List<ProductModel>>> getProductByIdSalon({
  //   required int idSalon,
  //   required int pageIndex,
  //   required int pageSize,
  //   String? keyword,
  // }) {
  //   return executeRequest(
  //     () => _provider.getProductByIdSalon(
  //       idSalon: idSalon,
  //       pageIndex: pageIndex,
  //       pageSize: pageSize,
  //       keyword: keyword,
  //     ),
  //     PagedApiResponseParser(ProductModel.fromDynamic),
  //   );
  // }

  // @override
  // Future<Result<ProductModel>> createProduct(Map<String, dynamic> model) {
  //   return executeRequest(
  //     () => _provider.createProduct(model),
  //     GeneralApiResponseParser(ProductModel.fromDynamic),
  //   );
  // }

  // @override
  // Future<Result<ProductModel>> getProductById(int id) {
  //   return executeRequest(
  //     () => _provider.getProductById(id),
  //     GeneralApiResponseParser(ProductModel.fromDynamic),
  //   );
  // }

  // @override
  // Future<Result<ProductModel>> updateProductById(
  //   int id,
  //   Map<String, dynamic> model,
  // ) {
  //   return executeRequest(
  //     () => _provider.updateProduct(id, model),
  //     GeneralApiResponseParser(ProductModel.fromDynamic),
  //   );
  // }

  // @override
  // Future<Result<List>> deleteProductById(int id) {
  //   return executeRequest(
  //     () => _provider.deleteProductById(id),
  //     SimpleApiResponseParser((res) => []),
  //   );
  // }
}

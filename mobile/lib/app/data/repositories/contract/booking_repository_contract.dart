import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/models/booking_model.dart';

abstract class BookingRepositoryContract {
  Future<Result<List<BookingModel>>> getBookingByUserId({
    required int idUser,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  });

  // Future<Result<List<BookingModel>>> getClientByIdSalon({
  //   required int idSalon,
  //   required int pageIndex,
  //   required int pageSize,
  //   String? keyword,
  // });

  // Future<Result<BookingModel>> getClientById(int id);

  // Future<Result<BookingModel>> createClient(Map<String, dynamic> model);

  // Future<Result<BookingModel>> updateClientById(
  //   int id,
  //   Map<String, dynamic> model,
  // );

  // Future<Result<List>> deleteClientById(int id);
}

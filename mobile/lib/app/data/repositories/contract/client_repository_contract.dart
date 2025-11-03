import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/models/client_model.dart';

abstract class ClientRepositoryContract {
  Future<Result<List<ClientModel>>> getClientByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  });

  Future<Result<ClientModel>> getClientById(int id);

  Future<Result<ClientModel>> createClient(Map<String, dynamic> model);

  Future<Result<ClientModel>> updateClientById(
    int id,
    Map<String, dynamic> model,
  );

  Future<Result<List>> deleteClientById(int id);
}

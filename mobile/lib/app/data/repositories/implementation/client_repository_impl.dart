import 'package:get/get.dart';
import 'package:salonku/app/core/base/base_repository.dart';
import 'package:salonku/app/data/models/result.dart';
import 'package:salonku/app/data/network/paged_api_response_parser.dart';
import 'package:salonku/app/data/network/simple_api_response_parser.dart';
import 'package:salonku/app/data/providers/api/client_provider.dart';
import 'package:salonku/app/data/repositories/contract/client_repository_contract.dart';
import 'package:salonku/app/data/network/general_api_response_parser.dart';
import 'package:salonku/app/models/client_model.dart';

class ClientRepositoryImpl extends BaseRepository
    implements ClientRepositoryContract {
  final ClientProvider _provider = Get.find();

  @override
  Future<Result<List<ClientModel>>> getClientByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  }) {
    return executeRequest(
      () => _provider.getClientByIdSalon(
        idSalon: idSalon,
        pageIndex: pageIndex,
        pageSize: pageSize,
        keyword: keyword,
      ),
      PagedApiResponseParser(ClientModel.fromDynamic),
    );
  }

  @override
  Future<Result<ClientModel>> createClient(Map<String, dynamic> model) {
    return executeRequest(
      () => _provider.createClient(model),
      GeneralApiResponseParser(ClientModel.fromDynamic),
    );
  }

  @override
  Future<Result<ClientModel>> getClientById(int id) {
    return executeRequest(
      () => _provider.getClientById(id),
      GeneralApiResponseParser(ClientModel.fromDynamic),
    );
  }

  @override
  Future<Result<ClientModel>> updateClientById(
    int id,
    Map<String, dynamic> model,
  ) {
    return executeRequest(
      () => _provider.updateClient(id, model),
      GeneralApiResponseParser(ClientModel.fromDynamic),
    );
  }

  @override
  Future<Result<List>> deleteClientById(int id) {
    return executeRequest(
      () => _provider.deleteClientById(id),
      SimpleApiResponseParser((res) => []),
    );
  }
}

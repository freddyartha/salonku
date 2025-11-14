import 'package:get/get.dart';
import 'package:salonku/app/core/base/list_base_controller.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/repositories/contract/booking_repository_contract.dart';
import 'package:salonku/app/models/booking_model.dart';

class ScheduleCalendarController extends ListBaseController {
  final LocalDataSource _localDataSource = Get.find();

  final BookingRepositoryContract _repository;
  ScheduleCalendarController(this._repository);

  List<BookingModel> model = [];

  Future<void> getBookingByUserId() async {
    await handlePaginationRequest(
      showEasyLoading: true,
      () => _repository.getBookingByUserId(
        idUser: _localDataSource.userData.id,
        pageIndex: 1,
        pageSize: 10,
        keyword: searchController.value,
      ),
      onSuccess: (res) {
        if (res.data.isNotEmpty) {
          model.clear();
          model.addAll(res.data);
          update();
        }
      },
    );
  }
}

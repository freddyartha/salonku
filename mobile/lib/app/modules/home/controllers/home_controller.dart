import 'package:salonku/app/core/base/base_controller.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/models/user_model.dart';

class HomeController extends BaseController {
  late UserModel userData;

  final LocalDataSource _localDataSource;
  HomeController(this._localDataSource);

  @override
  void onInit() {
    userData = _localDataSource.userData;
    super.onInit();
  }
}

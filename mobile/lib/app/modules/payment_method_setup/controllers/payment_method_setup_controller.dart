import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/core/base/setup_base_controller.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/repositories/contract/payment_method_repository_contract.dart';
import 'package:salonku/app/models/payment_method_model.dart';

class PaymentMethodSetupController extends SetupBaseController {
  final paymentMethodCon = InputTextController();
  final codeCon = InputTextController();

  final PaymentMethodRepositoryContract _repository;
  final LocalDataSource _localDataSource;
  PaymentMethodSetupController(this._repository, this._localDataSource);

  late final String currencyCode = _localDataSource.salonData.currencyCode;
  PaymentMethodModel? model;

  @override
  void onInit() {
    super.onInit();
    if (itemId != null) {
      getById();
    }
  }

  void addValueInputFields(PaymentMethodModel? model) {
    if (model != null) {
      paymentMethodCon.value = model.nama;
      codeCon.value = model.kode;
    }
  }

  Future<void> getById() async {
    await handleRequest(
      showLoading: true,
      () => _repository.getPaymentMethodById(
        InputFormatter.dynamicToInt(itemId) ?? 0,
      ),
      onSuccess: (res) {
        model = res;
        addValueInputFields(res);
      },
      showErrorSnackbar: false,
    );
  }

  Future<void> saveOnTap() async {
    if (!paymentMethodCon.isValid) return;
    if (!codeCon.isValid) return;

    final model = PaymentMethodModel(
      id: 0,
      idSalon: _localDataSource.salonData.id,
      nama: paymentMethodCon.value,
      kode: codeCon.value,
    );

    await handleRequest(
      showLoading: false,
      () => itemId == null
          ? _repository.createPaymentMethod(paymentMethodModelToJson(model))
          : _repository.updatePaymentMethodById(
              InputFormatter.dynamicToInt(itemId) ?? 0,
              paymentMethodModelToJson(model),
            ),
      onSuccess: (res) {
        isEditable(false);
        itemId = res.id;
        addValueInputFields(res);
      },
      showErrorSnackbar: false,
    );
  }

  bool showConfirmationCondition() {
    if (isEditable.value &&
        (paymentMethodCon.value != null || codeCon.value != null)) {
      return true;
    } else {
      return false;
    }
  }
}

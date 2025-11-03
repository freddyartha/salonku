import 'package:get/get.dart';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/common/reusable_statics.dart';
import 'package:salonku/app/components/inputs/input_phone_component.dart';
import 'package:salonku/app/components/inputs/input_radio_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/core/base/setup_base_controller.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/data/repositories/contract/client_repository_contract.dart';
import 'package:salonku/app/models/client_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientSetupController extends SetupBaseController {
  final namaCon = InputTextController();
  final phoneCon = InputPhoneController();
  final emailCon = InputTextController(type: InputTextType.email);
  final alamatCon = InputTextController(type: InputTextType.paragraf);
  final jenisKelaminCon = InputRadioController(
    items: ReusableStatics.jenisKelaminRadioItem,
  );

  final LocalDataSource _localDataSource = Get.find();
  final ClientRepositoryContract _repository;
  ClientSetupController(this._repository);

  ClientModel? model;

  @override
  void onInit() {
    super.onInit();
    if (itemId != null) {
      getById();
    }
  }

  void addValueInputFields(ClientModel? model) {
    if (model != null) {
      namaCon.value = model.nama;
      phoneCon.value = model.phone;
      emailCon.value = model.email;
      jenisKelaminCon.value = model.jenisKelamin;
      alamatCon.value = model.alamat;
    }
  }

  Future<void> getById() async {
    await handleRequest(
      showLoading: true,
      () => _repository.getClientById(InputFormatter.dynamicToInt(itemId) ?? 0),
      onSuccess: (res) {
        model = res;
        addValueInputFields(res);
      },
      showErrorSnackbar: false,
    );
  }

  Future<void> saveOnTap() async {
    if (!namaCon.isValid) return;
    if (!phoneCon.isValid) return;
    if (!emailCon.isValid) return;
    if (!jenisKelaminCon.isValid) return;
    if (!alamatCon.isValid) return;

    final model = ClientModel(
      id: 0,
      idSalon: _localDataSource.salonData.id,
      nama: namaCon.value,
      phone: phoneCon.value,
      email: emailCon.value,
      jenisKelamin: jenisKelaminCon.value,
      alamat: alamatCon.value,
    );

    await handleRequest(
      showLoading: false,
      () => itemId == null
          ? _repository.createClient(clientModelToJson(model))
          : _repository.updateClientById(
              InputFormatter.dynamicToInt(itemId) ?? 0,
              clientModelToJson(model),
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
        (namaCon.value != null ||
            phoneCon.value != null ||
            emailCon.value != null ||
            jenisKelaminCon.value != null ||
            alamatCon.value != null)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> openWhatsApp() async {
    final encodedMessage = Uri.encodeComponent(
      "Halo ${model?.nama} kami dari ${_localDataSource.salonData.namaSalon}",
    );
    final cleanNumber = model?.phone.toString().replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );
    final whatsappUrl = Uri.parse(
      'https://wa.me/$cleanNumber?text=$encodedMessage',
    );

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      ReusableWidgets.notifBottomSheet(subtitle: "open_whatsapp_error".tr);
    }
  }

  Future<void> openEmail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: model?.email,
      query: {
        'body':
            "Halo ${model?.nama} kami dari ${_localDataSource.salonData.namaSalon}",
      }.entries.map((e) => '${e.key}=${Uri.encodeComponent(e.value)}').join('&'),
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ReusableWidgets.notifBottomSheet(subtitle: "open_email_error".tr);
    }
  }
}

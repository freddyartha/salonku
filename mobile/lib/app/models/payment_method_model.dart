import 'dart:convert';
import 'package:salonku/app/common/input_formatter.dart';

Map<String, dynamic> paymentMethodModelToJson(PaymentMethodModel data) =>
    data.toJson();

PaymentMethodModel paymentMethodModelFromJson(String str) =>
    PaymentMethodModel.fromJson(json.decode(str));

class PaymentMethodModel {
  int id;
  int idSalon;
  String nama;
  String kode;

  PaymentMethodModel({
    required this.id,
    required this.idSalon,
    required this.nama,
    required this.kode,
  });

  static PaymentMethodModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static PaymentMethodModel fromDynamic(dynamic dynamicData) {
    return PaymentMethodModel(
      id: InputFormatter.dynamicToInt(dynamicData['id']) ?? 0,
      idSalon: InputFormatter.dynamicToInt(dynamicData['id_salon']) ?? 0,
      nama: dynamicData['nama'],
      kode: dynamicData['kode'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'id_salon': idSalon,
    'nama': nama,
    'kode': kode,
  };
}

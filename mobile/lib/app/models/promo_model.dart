import 'dart:convert';
import 'package:salonku/app/common/input_formatter.dart';

Map<String, dynamic> promoModelToJson(PromoModel data) => data.toJson();

PromoModel promoModelFromJson(String str) =>
    PromoModel.fromJson(json.decode(str));

class PromoModel {
  int id;
  int idSalon;
  String nama;
  String currencyCode;
  String? deskripsi;
  double? potonganHarga;
  double? potonganPersen;
  DateTime berlakuMulai;
  DateTime berlakuSampai;

  PromoModel({
    required this.id,
    required this.idSalon,
    required this.currencyCode,
    required this.nama,
    this.deskripsi,
    this.potonganHarga,
    this.potonganPersen,
    required this.berlakuMulai,
    required this.berlakuSampai,
  });

  static PromoModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static PromoModel fromDynamic(dynamic dynamicData) {
    return PromoModel(
      id: InputFormatter.dynamicToInt(dynamicData['id']) ?? 0,
      idSalon: InputFormatter.dynamicToInt(dynamicData['id_salon']) ?? 0,
      currencyCode: dynamicData["currency_code"],
      nama: dynamicData['nama'],
      deskripsi: dynamicData['deskripsi'],
      potonganHarga: InputFormatter.dynamicToDouble(
        dynamicData["potongan_harga"],
      ),
      potonganPersen: InputFormatter.dynamicToDouble(
        dynamicData["potongan_persen"],
      ),
      berlakuMulai:
          InputFormatter.dynamicToDateTime(dynamicData['berlaku_mulai']) ??
          DateTime.now(),
      berlakuSampai:
          InputFormatter.dynamicToDateTime(dynamicData['berlaku_sampai']) ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id_salon': idSalon,
    'nama': nama,
    'deskripsi': deskripsi,
    'potongan_harga': potonganHarga,
    'potongan_persen': potonganPersen,
    'berlaku_mulai': InputFormatter.dateToString(berlakuMulai),
    'berlaku_sampai': InputFormatter.dateToString(berlakuSampai),
  };
}

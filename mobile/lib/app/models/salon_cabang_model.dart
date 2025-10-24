import 'dart:convert';
import 'package:salonku/app/common/input_formatter.dart';

Map<String, dynamic> salonCabangModelToJson(SalonCabangModel data) =>
    data.toJson();

SalonCabangModel salonCabangModelFromJson(String str) =>
    SalonCabangModel.fromJson(json.decode(str));

class SalonCabangModel {
  int id;
  int idSalon;
  String? currencyCode;
  String nama;
  String alamat;
  String phone;
  DateTime? createdAt;
  DateTime? updatedAt;

  SalonCabangModel({
    required this.id,
    required this.idSalon,
    this.currencyCode,
    required this.nama,
    required this.alamat,
    required this.phone,
    this.createdAt,
    this.updatedAt,
  });

  static SalonCabangModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static SalonCabangModel fromDynamic(dynamic dynamicData) {
    return SalonCabangModel(
      id: InputFormatter.dynamicToInt(dynamicData['id']) ?? 0,
      idSalon: InputFormatter.dynamicToInt(dynamicData['id_salon']) ?? 0,
      currencyCode: dynamicData['currency_code'],
      nama: dynamicData['nama'],
      alamat: dynamicData['alamat'],
      phone: dynamicData['phone'],
      createdAt:
          InputFormatter.dynamicToDateTime(dynamicData['created_at']) ??
          DateTime.now(),
      updatedAt: InputFormatter.dynamicToDateTime(dynamicData['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'id_salon': idSalon,
    "currency_code": currencyCode,
    'nama': nama,
    'alamat': alamat,
    'phone': phone,
    'created_at': InputFormatter.dateToString(createdAt),
    'updated_at': InputFormatter.dateToString(updatedAt),
  };
}

import 'dart:convert';
import 'package:salonku/app/common/input_formatter.dart';

Map<String, dynamic> supplierModelToJson(SupplierModel data) => data.toJson();

SupplierModel supplierModelFromJson(String str) =>
    SupplierModel.fromJson(json.decode(str));

class SupplierModel {
  int id;
  int idSalon;
  String nama;
  String alamat;
  String phone;

  SupplierModel({
    required this.id,
    required this.idSalon,
    required this.nama,
    required this.alamat,
    required this.phone,
  });

  static SupplierModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static SupplierModel fromDynamic(dynamic dynamicData) {
    return SupplierModel(
      id: InputFormatter.dynamicToInt(dynamicData['id']) ?? 0,
      idSalon: InputFormatter.dynamicToInt(dynamicData['id_salon']) ?? 0,
      nama: dynamicData['nama'],
      alamat: dynamicData['alamat'],
      phone: dynamicData['phone'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'id_salon': idSalon,
    'nama': nama,
    'alamat': alamat,
    'phone': phone,
  };
}

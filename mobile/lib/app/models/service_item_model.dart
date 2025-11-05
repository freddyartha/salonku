import 'dart:convert';

import 'package:salonku/app/common/input_formatter.dart';

Map<String, dynamic> serviceItemModelToJson(ServiceItemModel data) =>
    data.toJson();

ServiceItemModel serviceItemModelFromJson(String str) =>
    ServiceItemModel.fromJson(json.decode(str));

class ServiceItemModel {
  int id;
  int idServiceManagement;
  String namaService;
  double harga;
  String? deskripsi;

  ServiceItemModel({
    required this.id,
    required this.idServiceManagement,
    required this.namaService,
    required this.harga,
    this.deskripsi,
  });

  static ServiceItemModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static ServiceItemModel fromDynamic(dynamic data) {
    return ServiceItemModel(
      id: InputFormatter.dynamicToInt(data['id']) ?? 0,
      idServiceManagement:
          InputFormatter.dynamicToInt(data['id_service_management']) ?? 0,
      namaService: data['nama_service'] ?? '',
      harga: InputFormatter.dynamicToDouble(data['harga']) ?? 0.0,
      deskripsi: data['deskripsi'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'id_service_management': idServiceManagement,
    'nama_service': namaService,
    'harga': harga,
    'deskripsi': deskripsi,
  };
}

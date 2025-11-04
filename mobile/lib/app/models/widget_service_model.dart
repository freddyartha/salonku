import 'dart:convert';
import 'package:salonku/app/common/input_formatter.dart';

// Map<String, dynamic> WidgetserviceModelToJson(WidgetServiceModel data) => data.toJson();

class WidgetServiceModel {
  int id;
  int idServiceManagement;
  String namaService;
  String? deskripsi;
  double harga;
  WidgetServiceModel({
    required this.id,
    required this.idServiceManagement,
    required this.namaService,
    this.deskripsi,
    required this.harga,
  });

  static WidgetServiceModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static WidgetServiceModel fromDynamic(dynamic dynamicData) {
    final model = WidgetServiceModel(
      id: InputFormatter.dynamicToInt(dynamicData['id']) ?? 0,
      idServiceManagement:
          InputFormatter.dynamicToInt(dynamicData['id_service_management']) ??
          0,
      namaService: dynamicData['nama_service'],
      deskripsi: dynamicData['deskripsi'],
      harga: InputFormatter.dynamicToDouble(dynamicData['harga']) ?? 0,
    );
    return model;
  }

  Map<String, dynamic> toJson() => {
    'id_salon': idServiceManagement,
    'nama_service': namaService,
    'deskripsi': deskripsi,
    'harga': harga,
  };
}

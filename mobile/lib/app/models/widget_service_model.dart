import 'dart:convert';
import 'package:salonku/app/common/input_formatter.dart';

Map<String, dynamic> widgetserviceModelToJson(WidgetServiceModel data) =>
    data.toJson();

class WidgetServiceModel {
  String namaService;
  String? deskripsi;
  double harga;
  WidgetServiceModel({
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
      namaService: dynamicData['nama_service'],
      deskripsi: dynamicData['deskripsi'],
      harga: InputFormatter.dynamicToDouble(dynamicData['harga']) ?? 0,
    );
    return model;
  }

  Map<String, dynamic> toJson() => {
    'nama_service': namaService,
    'deskripsi': deskripsi,
    'harga': harga,
  };
}

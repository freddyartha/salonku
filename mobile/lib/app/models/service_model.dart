import 'dart:convert';
import 'package:salonku/app/common/input_formatter.dart';

Map<String, dynamic> serviceModelToJson(ServiceModel data) => data.toJson();

class ServiceModel {
  int id;
  int idSalon;
  String nama;
  String? deskripsi;
  double harga;
  String? currencyCode;
  List<ServiceCabangModel>? cabang;
  DateTime? createdAt;

  ServiceModel({
    required this.id,
    required this.idSalon,
    required this.nama,
    this.deskripsi,
    required this.harga,
    required this.currencyCode,
    this.cabang,
    this.createdAt,
  });

  static ServiceModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static ServiceModel fromDynamic(dynamic dynamicData) {
    final model = ServiceModel(
      id: InputFormatter.dynamicToInt(dynamicData['id']) ?? 0,
      idSalon: InputFormatter.dynamicToInt(dynamicData['id_salon']) ?? 0,
      nama: dynamicData['nama'],
      deskripsi: dynamicData['deskripsi'],
      harga: InputFormatter.dynamicToDouble(dynamicData['harga']) ?? 0,
      currencyCode: dynamicData['currency_code'],
      createdAt:
          InputFormatter.dynamicToDateTime(dynamicData['created_at']) ??
          DateTime.now(),
    );

    if (dynamicData['cabang'] != null) {
      final detailT = dynamicData['cabang'] as List;
      model.cabang = [];
      for (var i = 0; i < detailT.length; i++) {
        model.cabang!.add(ServiceCabangModel.fromDynamic(detailT[i]));
      }
    }

    return model;
  }

  Map<String, dynamic> toJson() => {
    'id_salon': idSalon,
    'nama': nama,
    'deskripsi': deskripsi,
    'harga': harga,
    'cabangs': cabang?.map((e) => e.id).toList() ?? [],
  };
}

class ServiceCabangModel {
  int id;
  String nama;
  String alamat;
  String phone;

  ServiceCabangModel({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.phone,
  });

  static ServiceCabangModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static ServiceCabangModel fromDynamic(dynamic dynamicData) {
    final model = ServiceCabangModel(
      id: InputFormatter.dynamicToInt(dynamicData['id']) ?? 0,
      nama: dynamicData['nama'],
      alamat: dynamicData['alamat'],
      phone: dynamicData['phone'],
    );

    return model;
  }
}

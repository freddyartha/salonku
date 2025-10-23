import 'dart:convert';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/models/salon_cabang_model.dart';

Map<String, dynamic> salonModelToJson(SalonModel data) => data.toJson();

SalonModel salonModelFromJson(String str) =>
    SalonModel.fromJson(json.decode(str));

class SalonModel {
  int id;
  String namaSalon;
  String kodeSalon;
  String alamat;
  String phone;
  List<SalonCabangModel>? cabang;
  String? logoUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  SalonModel({
    required this.id,
    required this.namaSalon,
    required this.kodeSalon,
    required this.alamat,
    required this.phone,
    this.cabang,
    this.logoUrl,
    this.createdAt,
    this.updatedAt,
  });

  static SalonModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static SalonModel fromDynamic(dynamic dynamicData) {
    var model = SalonModel(
      id: InputFormatter.dynamicToInt(dynamicData['id']) ?? 0,
      namaSalon: dynamicData['nama_salon'],
      kodeSalon: dynamicData['kode_salon'],
      alamat: dynamicData['alamat'],
      phone: dynamicData['phone'],
      logoUrl: dynamicData['logo_url'] ?? "",
      createdAt:
          InputFormatter.dynamicToDateTime(dynamicData['created_at']) ??
          DateTime.now(),
      updatedAt: InputFormatter.dynamicToDateTime(dynamicData['updated_at']),
    );

    if (dynamicData['cabang'] != null) {
      final detailT = dynamicData['cabang'] as List;
      model.cabang = [];
      for (var i = 0; i < detailT.length; i++) {
        model.cabang!.add(SalonCabangModel.fromDynamic(detailT[i]));
      }
    }

    return model;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nama_salon': namaSalon,
    'kode_salon': kodeSalon,
    'alamat': alamat,
    'phone': phone,
    'logo_url': logoUrl,
    'created_at': InputFormatter.dateToString(createdAt),
    'updated_at': InputFormatter.dateToString(updatedAt),
  };
}

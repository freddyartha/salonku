import 'dart:convert';
import 'package:salonku/app/common/input_formatter.dart';

Map<String, dynamic> clientModelToJson(ClientModel data) => data.toJson();

ClientModel clientModelFromJson(String str) =>
    ClientModel.fromJson(json.decode(str));

class ClientModel {
  int id;
  int idSalon;
  String nama;
  String? jenisKelamin;
  String? alamat;
  String? email;
  String? phone;

  ClientModel({
    required this.id,
    required this.idSalon,
    required this.nama,
    this.jenisKelamin,
    this.alamat,
    this.email,
    this.phone,
  });

  static ClientModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static ClientModel fromDynamic(dynamic dynamicData) {
    return ClientModel(
      id: InputFormatter.dynamicToInt(dynamicData['id']) ?? 0,
      idSalon: InputFormatter.dynamicToInt(dynamicData['id_salon']) ?? 0,
      nama: dynamicData['nama'],
      jenisKelamin: dynamicData['jenis_kelamin'],
      alamat: dynamicData['alamat'],
      email: dynamicData['email'],
      phone: dynamicData['phone'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'id_salon': idSalon,
    'nama': nama,
    'jenis_kelamin': jenisKelamin,
    'alamat': alamat,
    'email': email,
    'phone': phone,
  };
}

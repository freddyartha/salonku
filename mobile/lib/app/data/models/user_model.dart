import 'dart:convert';
import 'package:salonku/app/common/input_formatter.dart';

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int id;
  int? idSalon;
  String idUserFirebase;
  int level;
  String nama;
  String email;
  String phone;
  String nik;
  String jenisKelamin;
  DateTime tanggalLahir;
  String alamat;
  String? avatarUrl;
  DateTime createdAt;
  DateTime? updatedAt;

  UserModel({
    required this.id,
    this.idSalon,
    required this.idUserFirebase,
    required this.level,
    required this.nama,
    required this.email,
    required this.phone,
    required this.nik,
    required this.jenisKelamin,
    required this.tanggalLahir,
    required this.alamat,
    this.avatarUrl,
    required this.createdAt,
    this.updatedAt,
  });

  static UserModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static UserModel fromDynamic(dynamic dynamicData) {
    return UserModel(
      id: InputFormatter.dynamicToInt(dynamicData['id']) ?? 0,
      idSalon: InputFormatter.dynamicToInt(dynamicData['id_salon']),
      idUserFirebase: dynamicData['id_user_firebase'],
      level: InputFormatter.dynamicToInt(dynamicData['level']) ?? 0,
      nama: dynamicData['nama'],
      email: dynamicData['email'],
      phone: dynamicData['phone'],
      nik: dynamicData['nik'],
      jenisKelamin: dynamicData['jenis_kelamin'],
      tanggalLahir:
          InputFormatter.dynamicToDateTime(dynamicData['tanggal_lahir']) ??
          DateTime.now(),
      alamat: dynamicData['alamat'],
      avatarUrl: dynamicData['avatar_url'],
      createdAt:
          InputFormatter.dynamicToDateTime(dynamicData['created_at']) ??
          DateTime.now(),
      updatedAt: InputFormatter.dynamicToDateTime(dynamicData['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'id_salon': idSalon,
    'id_user_firebase': idUserFirebase,
    'level': level,
    'nama': nama,
    'email': email,
    'phone': phone,
    'nik': nik,
    'jenis_kelamin': jenisKelamin,
    'tangal_lahir': tanggalLahir,
    'alamat': alamat,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

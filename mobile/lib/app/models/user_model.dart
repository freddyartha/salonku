import 'dart:convert';
import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/models/salon_cabang_model.dart';

Map<String, dynamic> userModelToJson(UserModel data) => data.toJson();

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

class UserModel {
  int id;
  int? idSalon;
  bool? ownerApproval;
  DateTime? approvedDate;
  bool aktif;
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
  List<SalonCabangModel>? cabangs;

  UserModel({
    required this.id,
    this.idSalon,
    this.ownerApproval,
    this.approvedDate,
    required this.aktif,
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
    this.cabangs,
  });

  static UserModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static UserModel fromDynamic(dynamic dynamicData) {
    return UserModel(
      id: InputFormatter.dynamicToInt(dynamicData['id']) ?? 0,
      idSalon: InputFormatter.dynamicToInt(dynamicData['id_salon']),
      ownerApproval: InputFormatter.dynamicToBool(
        dynamicData['owner_approval'],
      ),

      approvedDate: InputFormatter.dynamicToDateTime(
        dynamicData['approved_date'],
      ),
      aktif: InputFormatter.dynamicToBool(dynamicData['aktif']) ?? false,
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
      avatarUrl: dynamicData['avatar_url'] ?? "",
      cabangs: dynamicData['cabangs'] != null
          ? List<SalonCabangModel>.from(
              dynamicData['cabangs'].map(
                (x) => SalonCabangModel.fromDynamic(x),
              ),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'id_salon': idSalon,
    'owner_approval': ownerApproval,
    'approved_date': InputFormatter.dateToString(approvedDate),
    'aktif': aktif,
    'id_user_firebase': idUserFirebase,
    'level': level,
    'nama': nama,
    'email': email,
    'phone': phone,
    'nik': nik,
    'jenis_kelamin': jenisKelamin,
    'tanggal_lahir': InputFormatter.dateToString(tanggalLahir),
    'alamat': alamat,
    'avatar_url': avatarUrl,
    'cabangs': cabangs?.map((item) => item.id).toList() ?? [],
  };
}

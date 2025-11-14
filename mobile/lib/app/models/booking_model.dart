import 'dart:convert';
import 'package:salonku/app/common/input_formatter.dart';

BookingModel bookingModelFromJson(String str) =>
    BookingModel.fromJson(json.decode(str));

class BookingModel {
  int id;
  ClientItemModel? client;
  DateTime tanggalJam;
  String? catatan;

  BookingModel({
    required this.id,
    this.client,
    required this.tanggalJam,
    this.catatan,
  });

  static BookingModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static BookingModel fromDynamic(dynamic dynamicData) {
    return BookingModel(
      id: InputFormatter.dynamicToInt(dynamicData['id']) ?? 0,

      client: dynamicData['client'] != null
          ? ClientItemModel.fromDynamic(dynamicData['client'])
          : null,
      tanggalJam:
          InputFormatter.dynamicToDateTime(dynamicData['tanggal_jam']) ??
          DateTime.now(),
      catatan: dynamicData['catatan'],
    );
  }
}

class ClientItemModel {
  int id;
  String nama;
  String phone;
  String email;

  ClientItemModel({
    required this.id,
    required this.nama,
    required this.phone,
    required this.email,
  });

  static ClientItemModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static ClientItemModel fromDynamic(dynamic dynamicData) {
    return ClientItemModel(
      id: InputFormatter.dynamicToInt(dynamicData['id']) ?? 0,
      nama: dynamicData['nama'],
      phone: dynamicData['phone'],
      email: dynamicData['email'],
    );
  }
}

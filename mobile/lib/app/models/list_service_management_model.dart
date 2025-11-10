import 'dart:convert';
import 'package:salonku/app/common/input_formatter.dart';

class ListServiceManagementModel {
  int id;
  String? catatan;
  String currencyCode;
  String? client;
  String cabang;
  List<ListServicesModel>? services;
  List<ListServicesModel>? serviceItems;

  ListServiceManagementModel({
    required this.id,
    this.catatan,
    required this.currencyCode,
    this.client,
    required this.cabang,
    this.services,
  });

  static ListServiceManagementModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static ListServiceManagementModel fromDynamic(dynamic dynamicData) {
    final model = ListServiceManagementModel(
      id: InputFormatter.dynamicToInt(dynamicData['id']) ?? 0,
      catatan: dynamicData['catatan'],
      currencyCode: dynamicData['currency_code'],
      client: dynamicData['client'],
      cabang: dynamicData['cabang'],
    );

    if (dynamicData['services'] != null) {
      final detailT = dynamicData['services'] as List;
      model.services = [];
      for (var i = 0; i < detailT.length; i++) {
        model.services!.add(ListServicesModel.fromDynamic(detailT[i]));
      }
    }
    if (dynamicData['service_items'] != null) {
      final detailT = dynamicData['service_items'] as List;
      model.serviceItems = [];
      for (var i = 0; i < detailT.length; i++) {
        model.serviceItems!.add(ListServicesModel.fromDynamic(detailT[i]));
      }
    }

    return model;
  }
}

class ListServicesModel {
  int id;
  String nama;
  double harga;

  ListServicesModel({
    required this.id,
    required this.nama,
    required this.harga,
  });

  static ListServicesModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static ListServicesModel fromDynamic(dynamic dynamicData) {
    final model = ListServicesModel(
      id: InputFormatter.dynamicToInt(dynamicData['id']) ?? 0,
      nama: dynamicData['nama'],
      harga: InputFormatter.dynamicToDouble(dynamicData['harga']) ?? 0,
    );
    return model;
  }
}

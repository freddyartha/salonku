import 'dart:convert';

import 'package:salonku/app/common/input_formatter.dart';
import 'package:salonku/app/models/client_model.dart';
import 'package:salonku/app/models/payment_method_model.dart';
import 'package:salonku/app/models/salon_cabang_model.dart';
import 'package:salonku/app/models/salon_model.dart';
import 'package:salonku/app/models/service_item_model.dart';
import 'package:salonku/app/models/service_model.dart';

Map<String, dynamic> serviceManagementModelToJson(
  ServiceManagementModel data,
) => data.toJson();

ServiceManagementModel serviceManagementModelFromJson(String str) =>
    ServiceManagementModel.fromJson(json.decode(str));

class ServiceManagementModel {
  int id;
  int? idClient;
  int idPaymentMethod;
  int idSalon;
  int? idCabang;
  String? catatan;
  SalonModel? salon;
  ClientModel? client;
  PaymentMethodModel? paymentMethod;
  List<ServiceModel>? services;
  SalonCabangModel? cabang;
  List<ServiceItemModel>? serviceItems;
  List<PromoItemModel>? promos;

  ServiceManagementModel({
    required this.id,
    this.idClient,
    required this.idPaymentMethod,
    required this.idSalon,
    this.idCabang,
    this.catatan,
    this.salon,
    this.client,
    this.paymentMethod,
    this.services,
    this.cabang,
    this.serviceItems,
    this.promos,
  });

  static ServiceManagementModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static ServiceManagementModel fromDynamic(dynamic data) {
    var model = ServiceManagementModel(
      id: InputFormatter.dynamicToInt(data['id']) ?? 0,
      idClient: InputFormatter.dynamicToInt(data['id_client']) ?? 0,
      idPaymentMethod:
          InputFormatter.dynamicToInt(data['id_payment_method']) ?? 0,
      idSalon: InputFormatter.dynamicToInt(data['id_salon']) ?? 0,
      idCabang: InputFormatter.dynamicToInt(data['id_cabang']) ?? 0,
      catatan: data['catatan'],
      cabang: SalonCabangModel.fromDynamic(data['cabang']),

      // Nested
      salon: data['salon'] != null
          ? SalonModel.fromDynamic(data['salon'])
          : null,
      client: data['client'] != null
          ? ClientModel.fromDynamic(data['client'])
          : null,
      paymentMethod: data['payment_method'] != null
          ? PaymentMethodModel.fromDynamic(data['payment_method'])
          : null,
      services: data['services'] != null
          ? List<ServiceModel>.from(
              data['services'].map((x) => ServiceModel.fromDynamic(x)),
            )
          : [],
      serviceItems: data['service_items'] != null
          ? List<ServiceItemModel>.from(
              data['service_items'].map((x) => ServiceItemModel.fromDynamic(x)),
            )
          : [],
      promos: data['promos'] != null
          ? List<PromoItemModel>.from(
              data['promos'].map((x) => PromoItemModel.fromDynamic(x)),
            )
          : [],
    );

    return model;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'id_client': idClient,
    'id_payment_method': idPaymentMethod,
    'id_salon': idSalon,
    'id_cabang': idCabang,
    'catatan': catatan,
    // 'client': client?.toJson(),
    // 'payment_method': paymentMethod?.toJson(),
    // 'service': service?.toJson(),
    // 'cabang': cabang?.toJson(),
    'services': services?.map((item) => item.id).toList() ?? [],
    'service_items': serviceItems?.map((item) => item.toJson()).toList() ?? [],
    'id_promo': promos?.last.id,
  };
}

class PromoItemModel {
  int id;
  String nama;
  double? potonganHarga;
  double? potonganPersen;

  PromoItemModel({
    required this.id,
    required this.nama,
    this.potonganHarga,
    this.potonganPersen,
  });

  static PromoItemModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static PromoItemModel fromDynamic(dynamic dynamicData) {
    return PromoItemModel(
      id: InputFormatter.dynamicToInt(dynamicData['id']) ?? 0,
      nama: dynamicData['nama'],
      potonganHarga: InputFormatter.dynamicToDouble(
        dynamicData["potongan_harga"],
      ),
      potonganPersen: InputFormatter.dynamicToDouble(
        dynamicData["potongan_persen"],
      ),
    );
  }
}

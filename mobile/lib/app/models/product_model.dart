import 'dart:convert';
import 'package:salonku/app/common/input_formatter.dart';

Map<String, dynamic> productModelToJson(ProductModel data) => data.toJson();

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

class ProductModel {
  int id;
  int idSalon;
  int? idSupplier;
  ProductSupplierModel? supplier;
  String brand;
  String nama;
  String? ukuran;
  String satuan;
  double hargaSatuan;
  String currencyCode;

  ProductModel({
    required this.id,
    required this.idSalon,
    this.idSupplier,
    this.supplier,
    required this.brand,
    required this.nama,
    this.ukuran,
    required this.satuan,
    required this.hargaSatuan,
    required this.currencyCode,
  });

  static ProductModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static ProductModel fromDynamic(dynamic dynamicData) {
    return ProductModel(
      id: InputFormatter.dynamicToInt(dynamicData['id']) ?? 0,
      idSalon: InputFormatter.dynamicToInt(dynamicData['id_salon']) ?? 0,
      idSupplier: InputFormatter.dynamicToInt(dynamicData['id_supplier']),
      supplier: dynamicData['supplier'] != null
          ? ProductSupplierModel.fromDynamic(dynamicData['supplier'])
          : null,
      brand: dynamicData['brand'],
      nama: dynamicData['nama'],
      ukuran: dynamicData['ukuran'],
      satuan: dynamicData['satuan'],
      hargaSatuan:
          InputFormatter.dynamicToDouble(dynamicData['harga_satuan']) ?? 0,
      currencyCode: dynamicData['currency_code'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'id_salon': idSalon,
    'id_supplier': idSupplier,
    'brand': brand,
    'nama': nama,
    'ukuran': ukuran,
    'satuan': satuan,
    'harga_satuan': hargaSatuan,
  };
}

class ProductSupplierModel {
  int id;
  String nama;
  String alamat;
  String phone;

  ProductSupplierModel({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.phone,
  });

  static ProductSupplierModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static ProductSupplierModel fromDynamic(dynamic dynamicData) {
    return ProductSupplierModel(
      id: InputFormatter.dynamicToInt(dynamicData['id']) ?? 0,
      nama: dynamicData['nama'],
      alamat: dynamicData['alamat'],
      phone: dynamicData['phone'],
    );
  }
}

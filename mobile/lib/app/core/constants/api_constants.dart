import 'package:salonku/app/common/input_formatter.dart';

import '../../config/environment.dart';

class ApiConstants {
  static const String contentTypeJson = 'application/json';
  static const String contentTypeForm = 'multipart/form-data';
  static const String accept = 'application/json';

  // Headers
  static const String headerContentType = 'Content-Type';
  static const String headerAccept = 'Accept';
  static const String headerAuthorization = 'X-Authorization';
  // -- Endpoint --
  static final api = "${EnvironmentConfig.hostUrl}/api";

  //user
  static String getUserSalonByFirebaseId(String userFirebaseId) =>
      "$api/user-salon/$userFirebaseId";
  static String registerUser = "$api/user-register";

  //salon
  static String createSalon = "$api/salon";
  static String updateSalon(int idSalon) => "$api/salon/$idSalon";
  static String userAddSalon(int userId) => '$api/user-salon/$userId/add-salon';
  static String getSalonByIdSalon(int idSalon) => '$api/salon/$idSalon';
  static String getSalonByKodeSalon(String kodeSalon) =>
      '$api/salon/kode/$kodeSalon';
  static String userRemoveSalon(int userId) =>
      '$api/user-salon/$userId/remove-salon';
  static String staffApproval(int staffId) =>
      '$api/user-salon/staff-approval/$staffId';

  //general
  static String getSalonSummary(int salonId) =>
      '$api/general/salon-summary/$salonId';
  static String getIncomeExpenseSummary(int salonId) =>
      '$api/general/income-expense-summary/$salonId';
  static String getIncomeExpenseList({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    required DateTime fromDate,
    required DateTime toDate,
    int? idCabang,
    String? keyword,
  }) {
    final queryParams = <String, String>{
      'page': '$pageIndex',
      'per_page': '$pageSize',
      'from_date': InputFormatter.dateToString(fromDate) ?? '',
      'to_date': InputFormatter.dateToString(toDate) ?? '',
      if (keyword != null && keyword.isNotEmpty) 'search': keyword,
      if (idCabang != null) 'cabang_id': '$idCabang',
    };

    final queryString = Uri(queryParameters: queryParams).query;
    return '$api/general/income-expense/$idSalon/list?$queryString';
  }

  static String getTransactionReport({
    required int idSalon,
    required DateTime fromDate,
    required DateTime toDate,
    int? idCabang,
  }) {
    final queryParams = <String, String>{
      'from_date': InputFormatter.dateToString(fromDate) ?? '',
      'to_date': InputFormatter.dateToString(toDate) ?? '',
      if (idCabang != null) 'cabang_id': '$idCabang',
    };

    final queryString = Uri(queryParameters: queryParams).query;
    return '$api/general/transaction-report/$idSalon?$queryString';
  }

  //service
  static String getServiceList({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    int? idCabang,
    String? keyword,
  }) {
    final queryParams = <String, String>{
      'page': '$pageIndex',
      'per_page': '$pageSize',
      if (keyword != null && keyword.isNotEmpty) 'search': keyword,
      if (idCabang != null) 'cabang_id': '$idCabang',
    };

    final queryString = Uri(queryParameters: queryParams).query;
    return "$api/service/$idSalon/list?$queryString";
  }

  static String postService = '$api/service';
  static String putServiceById(int id) => '$api/service/$id';
  static String getServiceById(int id) => '$api/service/$id';
  static String deleteServiceById(int id) => '$api/service/$id/delete';

  //cabang
  static String getCabangByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    int? idCabang,
    String? keyword,
  }) {
    final queryParams = <String, String>{
      'page': '$pageIndex',
      'per_page': '$pageSize',
      if (keyword != null && keyword.isNotEmpty) 'search': keyword,
      if (idCabang != null) 'cabang_id': '$idCabang',
    };

    final queryString = Uri(queryParameters: queryParams).query;
    return "$api/salon/$idSalon/cabang/list?$queryString";
  }

  static String postCabang = '$api/salon/cabang';
  static String putCabangById(int id) => '$api/salon/cabang/$id';
  static String getCabangById(int id) => '$api/salon/cabang/$id';
  static String deleteCabangById(int id) => '$api/salon/cabang/$id/delete';

  //Product
  static String getProductByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  }) {
    final queryParams = <String, String>{
      'page': '$pageIndex',
      'per_page': '$pageSize',
      if (keyword != null && keyword.isNotEmpty) 'search': keyword,
    };

    final queryString = Uri(queryParameters: queryParams).query;
    return "$api/salon/$idSalon/product/list?$queryString";
  }

  static String postProduct = '$api/salon/product';
  static String putProductById(int id) => '$api/salon/product/$id';
  static String getProductById(int id) => '$api/salon/product/$id';
  static String deleteProductById(int id) => '$api/salon/product/$id/delete';

  //Supplier
  static String getSupplierByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  }) {
    final queryParams = <String, String>{
      'page': '$pageIndex',
      'per_page': '$pageSize',
      if (keyword != null && keyword.isNotEmpty) 'search': keyword,
    };

    final queryString = Uri(queryParameters: queryParams).query;
    return "$api/salon/$idSalon/supplier/list?$queryString";
  }

  static String postSupplier = '$api/salon/supplier';
  static String putSupplierById(int id) => '$api/salon/supplier/$id';
  static String getSupplierById(int id) => '$api/salon/supplier/$id';
  static String deleteSupplierById(int id) => '$api/salon/supplier/$id/delete';

  //Payment Method
  static String getPaymentMethodByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  }) {
    final queryParams = <String, String>{
      'page': '$pageIndex',
      'per_page': '$pageSize',
      if (keyword != null && keyword.isNotEmpty) 'search': keyword,
    };

    final queryString = Uri(queryParameters: queryParams).query;
    return "$api/salon/$idSalon/payment-method/list?$queryString";
  }

  static String postPaymentMethod = '$api/salon/payment-method';
  static String putPaymentMethodById(int id) => '$api/salon/payment-method/$id';
  static String getPaymentMethodById(int id) => '$api/salon/payment-method/$id';
  static String deletePaymentMethodById(int id) =>
      '$api/salon/payment-method/$id/delete';

  //Client
  static String getClientByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  }) {
    final queryParams = <String, String>{
      'page': '$pageIndex',
      'per_page': '$pageSize',
      if (keyword != null && keyword.isNotEmpty) 'search': keyword,
    };

    final queryString = Uri(queryParameters: queryParams).query;
    return "$api/salon/$idSalon/client/list?$queryString";
  }

  static String postClient = '$api/salon/client';
  static String putClientById(int id) => '$api/salon/client/$id';
  static String getClientById(int id) => '$api/salon/client/$id';
  static String deleteClientById(int id) => '$api/salon/client/$id/delete';

  //Service Management
  static String getServiceManagementByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    int? idCabang,
    String? keyword,
  }) {
    final queryParams = <String, String>{
      'page': '$pageIndex',
      'per_page': '$pageSize',
      if (keyword != null && keyword.isNotEmpty) 'search': keyword,
      if (idCabang != null) 'cabang_id': '$idCabang',
    };

    final queryString = Uri(queryParameters: queryParams).query;
    return "$api/salon/$idSalon/service-management/list?$queryString";
  }

  static String postServiceManagement = '$api/salon/service-management';
  static String putServiceManagementById(int id) =>
      '$api/salon/service-management/$id';
  static String getServiceManagementById(int id) =>
      '$api/salon/service-management/$id';
  static String deleteServiceManagementById(int id) =>
      '$api/salon/service-management/$id/delete';

  //Staff
  static String getStaffByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    String? keyword,
  }) {
    final queryParams = <String, String>{
      'page': '$pageIndex',
      'per_page': '$pageSize',
      if (keyword != null && keyword.isNotEmpty) 'search': keyword,
    };

    final queryString = Uri(queryParameters: queryParams).query;
    return "$api/salon/$idSalon/staff/list?$queryString";
  }

  static String putStaffById(int id) => '$api/salon/staff/$id';
  static String getStaffById(int id) => '$api/salon/staff/$id';
  static String deactivateStaff(int idStaff) =>
      '$api/salon/staff/$idStaff/deactivate-staff';
  static String promoteDemoteStaff(int idStaff, bool promote) => promote
      ? '$api/salon/staff/$idStaff/promote-staff'
      : '$api/salon/staff/$idStaff/demote-staff';

  //Promo
  static String getPromoByIdSalon({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    int? idCabang,
    String? keyword,
  }) {
    final queryParams = <String, String>{
      'page': '$pageIndex',
      'per_page': '$pageSize',
      if (keyword != null && keyword.isNotEmpty) 'search': keyword,
    };

    final queryString = Uri(queryParameters: queryParams).query;
    return "$api/salon/$idSalon/promo/list?$queryString";
  }

  static String postPromo = '$api/salon/promo';
  static String putPromoById(int id) => '$api/salon/promo/$id';
  static String getPromoById(int id) => '$api/salon/promo/$id';
  static String deletePromoById(int id) => '$api/salon/promo/$id/delete';

  //Booking
  static String getBookingByUserId({
    required int idUser,
    required int pageIndex,
    required int pageSize,
    int? idCabang,
    String? keyword,
  }) {
    final queryParams = <String, String>{
      'page': '$pageIndex',
      'per_page': '$pageSize',
      if (keyword != null && keyword.isNotEmpty) 'search': keyword,
    };

    final queryString = Uri(queryParameters: queryParams).query;
    return "$api/salon/booking/staff/$idUser/list?$queryString";
  }
  // static String getPromoByIdSalon({
  //   required int idSalon,
  //   required int pageIndex,
  //   required int pageSize,
  //   int? idCabang,
  //   String? keyword,
  // }) {
  //   final queryParams = <String, String>{
  //     'page': '$pageIndex',
  //     'per_page': '$pageSize',
  //     if (keyword != null && keyword.isNotEmpty) 'search': keyword,
  //   };

  //   final queryString = Uri(queryParameters: queryParams).query;
  //   return "$api/salon/$idSalon/promo/list?$queryString";
  // }

  // static String postPromo = '$api/salon/promo';
  // static String putPromoById(int id) => '$api/salon/promo/$id';
  // static String getPromoById(int id) => '$api/salon/promo/$id';
  // static String deletePromoById(int id) => '$api/salon/promo/$id/delete';

  //pengeluaran
  static String getPengeluaranList({
    required int idSalon,
    required int pageIndex,
    required int pageSize,
    int? idCabang,
    String? keyword,
  }) {
    final queryParams = <String, String>{
      'page': '$pageIndex',
      'per_page': '$pageSize',
      if (keyword != null && keyword.isNotEmpty) 'search': keyword,
      if (idCabang != null) 'cabang_id': '$idCabang',
    };

    final queryString = Uri(queryParameters: queryParams).query;
    return "$api/pengeluaran/$idSalon/list?$queryString";
  }

  static String postPengeluaran = '$api/pengeluaran';
  static String putPengeluaranById(int id) => '$api/pengeluaran/$id';
  static String getPengeluaranById(int id) => '$api/pengeluaran/$id';
  static String deletePengeluaranById(int id) => '$api/pengeluaran/$id/delete';
}

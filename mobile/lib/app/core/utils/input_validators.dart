class InputValidators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Nama harus diisi";
    } else if (value.length < 5) {
      return "Nama minimal 5 karakter";
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return "Alamat harus diisi";
    } else if (value.length < 6) {
      return "Alamat minimal 6 karakter";
    }
    return null;
  }

  static String? validateNik(String? value) {
    if (value == null || value.isEmpty) {
      return "NIK harus diisi";
    } else if (value.length < 6) {
      return "NIK minimal panjang 15 karakter";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password harus diisi";
    } else if (value.length < 6) {
      return "Password minimal 6 karakter";
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Konfirmasi password harus diisi";
    } else if (value.length < 6) {
      return "Konfirmasi password minimal 6 karakter";
    } else if (value != password) {
      return "Konfirmasi password tidak cocok";
    }
    return null;
  }
}

mixin ValidationMixin {
  /// Validate email format
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email tidak boleh kosong';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Format email tidak valid';
    }

    return null;
  }

  /// Validate password strength
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password tidak boleh kosong';
    }

    if (password.length < 6) {
      return 'Password minimal 6 karakter';
    }

    return null;
  }

  /// Validate required field
  String? validateRequired(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    return null;
  }

  /// Validate phone number (Indonesian format)
  String? validatePhoneNumber(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }

    // Remove all non-digit characters
    final cleanPhone = phone.replaceAll(RegExp(r'\D'), '');

    // Check Indonesian phone number format
    if (cleanPhone.length < 10 || cleanPhone.length > 13) {
      return 'Nomor telepon tidak valid';
    }

    // Must start with 08 or +628 or 628
    if (!cleanPhone.startsWith('08') && !cleanPhone.startsWith('628')) {
      return 'Nomor telepon harus dimulai dengan 08 atau +628';
    }

    return null;
  }
}

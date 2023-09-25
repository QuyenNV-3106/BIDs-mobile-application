class TokenManager {
  static String? _token;

  static void setToken(String token) {
    _token = token;
  }

  static String? getToken() {
    return _token;
  }

  static bool isTokenExpired() {
    // Kiểm tra hết hạn của token, trả về true nếu đã hết hạn, ngược lại trả về false
    bool valid = false;
    return false;
  }
}

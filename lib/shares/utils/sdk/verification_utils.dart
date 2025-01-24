import 'dart:convert';

import 'package:crypto/crypto.dart';

class VerificationUtils {
  /// Xây dựng hash request từ các tham số đầu vào
  static String buildRequestHash(String apiKey, String secretKey,
      String transactionId, int timestamp, String message) {
    final verifyHashPlainText =
        _buildHashValue(apiKey, transactionId, timestamp, message);
    final verifyHash = _hashSHA512(secretKey, verifyHashPlainText);
    var hashToHex = stringToHex(verifyHash);
    return hashToHex;
  }

  /// Ghép các giá trị đầu vào thành một chuỗi duy nhất
  static String _buildHashValue(
      String apiKey, String transactionId, int timestamp, String message) {
    return apiKey + transactionId + timestamp.toString() + message;
  }

  /// Hàm hash SHA-512 với key
  static String _hashSHA512(String key, String data) {
    try {
      final keyBytes = utf8.encode(key);
      final dataBytes = utf8.encode(data);

      final hmac = Hmac(sha512, keyBytes);
      final digest = hmac.convert(dataBytes);

      return digest.toString();
    } catch (e) {
      return '';
    }
  }

  static String stringToHex(String input) {
    // Chuyển chuỗi ký tự thành danh sách byte
    List<int> bytes = utf8.encode(input);

    // Chuyển danh sách byte thành chuỗi Hex
    return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }
}

import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionHelper {
  static final key = encrypt.Key.fromUtf8('12345678901234567890123456789012');
  static final iv = encrypt.IV.fromLength(16);

  static final encrypter = encrypt.Encrypter(
    encrypt.AES(key),
  );

  static String encryptText(String text) {
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base64;
  }

  static String decryptText(String encryptedText) {
    final encrypted = encrypt.Encrypted.fromBase64(encryptedText);
    return encrypter.decrypt(encrypted, iv: iv);
  }
}
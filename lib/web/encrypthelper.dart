import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionHelper {
  static final encrypt.Key key = encrypt.Key.fromUtf8(
    '12345678901234567890123456789012',
  );

  static final encrypt.IV iv = encrypt.IV.fromLength(16);

  static final encrypt.Encrypter encrypter = encrypt.Encrypter(
    encrypt.AES(
      key,
      mode: encrypt.AESMode.cbc,
      padding: 'PKCS7',
    ),
  );

  static String encryptText(String text) {
    final encrypt.Encrypted encrypted = encrypter.encrypt(
      text,
      iv: iv,
    );

    return encrypted.base64;
  }

  static String decryptText(String encryptedText) {
    final String cleanText = encryptedText.trim();

    final encrypt.Encrypted encrypted =
    encrypt.Encrypted.fromBase64(cleanText);

    return encrypter.decrypt(
      encrypted,
      iv: iv,
    );
  }
}
import 'dart:convert';

import 'dart:typed_data';

import 'package:crypto/crypto.dart';

///ClearKey helper class to generate the key
class BetterPlayerClearKeyUtils {
  static final _byteMask = BigInt.from(0xff);

  ///The ClearKey from a Map. The key in map should be the kid with the associated value being the key. Both values should be provide in HEX format.
  static String generateKey(Map<String, String> keys,
      {String type = "temporary"}) {
    final Map keyMap = <String, dynamic>{"type": type};
    keyMap["keys"] = <Map<String, String>>[];
    keys.forEach((key, value) => keyMap["keys"]
        .add({"kty": "oct", "kid": _base64(key), "k": _base64(value)}));

    return jsonEncode(keyMap);
  }

  static String _base64(String source) {
    return base64
        .encode(_encodeBigInt(BigInt.parse(source, radix: 16)))
        .replaceAll("=", "");
  }

  static Uint8List _encodeBigInt(BigInt number) {
    var passedNumber = number;
    final int size = (number.bitLength + 7) >> 3;

    final result = Uint8List(size);
    int pos = size - 1;
    for (int i = 0; i < size; i++) {
      result[pos--] = (passedNumber & _byteMask).toInt();
      passedNumber = passedNumber >> 8;
    }
    return result;
  }

  static String computeHmacSha256Base64(String key, String data) {
    final keyBytes = utf8.encode(key); // Convert key to bytes
    final dataBytes = utf8.encode(data); // Convert data to bytes

    final hmacSha256 = Hmac(sha256, keyBytes); // Create Hmac instance
    final digest = hmacSha256.convert(dataBytes); // Compute HMAC

    return base64UrlEncode(digest.bytes).replaceAll("=", "");
  }
}

import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

class OctalHelper {
  final String secretKey;
  OctalHelper({required this.secretKey});

  String generateOctalCode({required String uid, int length = 6}){

    if(length <= 0) throw ArgumentError('Length must be positive');

    // HMAC-SHA512(uid) / SHA512(uid) with secret key.. Cause this two Encryption method are very strong than other
    final hmac = Hmac(sha512, utf8.encode(secretKey));
    final digest = hmac.convert(utf8.encode(uid)).bytes;

    // Take last 4 bytes to 32-bit int
    int value = 0;
    for(int i = digest.length - 4; i<digest.length; i++){
      value = (value << 8) | digest[i];
    }
    value = value.abs();

    // Convert to Octal string of required length
    final mod = pow(8, length).toInt();
    final octal = (value % mod).toRadixString(8).padLeft(length, '0');
    return octal;
  }

}
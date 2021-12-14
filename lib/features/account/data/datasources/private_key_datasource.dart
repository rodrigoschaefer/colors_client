import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PrivateKeyDatasource {
  static const storage = FlutterSecureStorage();

  static Future<Map<String, String>> getAll() async {
    return await storage.readAll();
  }

  static void store(key, value) async {
    return await storage.write(key: key, value: value);
  }

  static Future<String?> read(key) async {
    return await storage.read(key: key);
  }

  static Future<void> delete(key) async {
    return await storage.delete(key: key);
  }
}

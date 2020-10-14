import 'package:ifix/app/data/provider/sqliteProvider.dart';

class SqliteRepository {
  SqliteProvider provider = SqliteProvider();

  Future<void> startDatabase(Map<String, dynamic> initialSettings) async {
    await provider.startDatabase(initialSettings);
  }

  Future<Map<String, dynamic>> getConfig() async {
    return await provider.getConfig();
  }

  Future<dynamic> updateSettings(settings) async {
    return await provider.updateSettings(settings);
  }

  Future<dynamic> updateMecanic(Map<String, dynamic> mecanic) async {
    return await provider.updateMecanic(mecanic);
  }

  Future<List<Map<String, dynamic>>> getAllMecanics() async {
    return await provider.getAllMecanics();
  }

  Future<List<Map<String, dynamic>>> getSpecificMecanic(id) async {
    return await provider.getSpecificMecanic(id);
  }

  Future<dynamic> insertMecanics(List<Map<String, dynamic>> mecanics) async {
    await provider.insertMecanics(mecanics);
  }
}

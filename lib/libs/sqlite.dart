import 'package:geolocator/geolocator.dart';
import 'package:ifix/libs/localizations.dart';
import 'package:sqflite/sqflite.dart';

class Sqlite {
  Database db;

  Future<void> startDatabase(Map<String, dynamic> initialSettings) async {
    if (db == null) {
      db = await openDatabase('my_db.db');
      var databasesPath = await getDatabasesPath();

      String path = databasesPath + '/demo.db';

      try {
        if (initialSettings != null) {
          db = await openDatabase(path, version: 1,
              onCreate: (Database db, int version) async {
            Position pos = await new Localization().getCurrentPosition();

            initialSettings['latitude'] = pos.latitude;
            initialSettings['longitude'] = pos.longitude;
            await db.execute(
                'CREATE TABLE Mecanic(id STRING,placeid TEXT, name TEXT, latitude REAL, longitude REAL, weekdayText TEXT, formattedAddress TEXT, number TEXT, rating REAL, nRating INTEGER)');
            await db.execute(
                'CREATE TABLE Settings(id PRIMARY KEY, lastModified DATE, latitude REAL, longitude REAL)');
          });

          await _insertSettings(initialSettings);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> _resetMecanics() async {
    return await db.transaction((txn) async {
      await txn.rawQuery("DELETE FROM Mecanic ");
    });
  }

  Future<Map<String, dynamic>> getConfig() async {
    return await db.transaction((txn) async {
      List<Map<String, dynamic>> result =
          await txn.rawQuery("SELECT * FROM Settings LIMIT 1");

      return result.elementAt(0);
    });
  }

  Future<dynamic> _insertSettings(settings) async {
    return await db.transaction((transaction) async {
      return await transaction.rawInsert(
          "INSERT INTO Settings (lastModified, latitude, longitude) VALUES('${settings['lastModified']}', ${settings['latitude']}, ${settings['longitude']})");
    });
  }

  Future<dynamic> updateSettings(settings) async {
    String query =
        "UPDATE Settings SET lastModified = ${settings['lastModified']}, latitude = ${settings['latitude']},longitude = ${settings['longitude']} ";

    return await db.transaction((transaction) async {
      return await transaction.rawUpdate(query);
    });
  }

  Future<dynamic> updateMecanic(Map<String, dynamic> mecanic) async {
    String query = "UPDATE Mecanic SET ";

    query += "placeid = '${mecanic['placeid']}',";
    query += "name = '${mecanic['name']}',";
    query += "latitude = ${mecanic['latitude']},";
    query += "longitude = ${mecanic['longitude']},";
    query += "weekdayText = '${mecanic['weekdayText']}',";
    query += "formattedAddress = '${mecanic['formattedAddress']}',";
    query += "number = ${mecanic['number']},";
    query += "rating = ${mecanic['rating']},";
    query += "nRating = ${mecanic['rating']}";
    query += "WHERE id = ${mecanic['id']}";

    return await db.transaction((transaction) async {
      return await transaction.rawUpdate(query);
    });
  }

  Future<List<Map<String, dynamic>>> getAllMecanics() async {
    var result;
    await db.transaction((txn) async {
      result = await txn.rawQuery("SELECT * FROM Mecanic");
    });

    return result;
  }

  Future<List<Map<String, dynamic>>> getSpecificMecanic(id) async {
    return await db.transaction((txn) async {
      return await txn.rawQuery("SELECT * FROM Mecanic WHERE id = '$id'");
    });
  }

  Future<dynamic> insertMecanics(List<Map<String, dynamic>> mecanics) async {
    await _resetMecanics();

    String query =
        "INSERT INTO Mecanic(id, placeid, name, latitude, longitude, weekdayText, formattedAddress, number, rating, nRating) VALUES";

    mecanics.forEach((element) {
      query += "(";
      query += "'${element['id']}',";
      query += "'${element['placeid']}',";
      query += "'${element['name']}',";
      query += "${element['latitude']},";
      query += "${element['longitude']},";
      query += "'${element['weekdayText']}',";
      query += "'${element['formattedAddress']}',";
      query += "'' ,";
      query += "${element['rating']},";
      query += "${element['userRatingsTotal']}";
      query += "),";
    });

    query = query.substring(0, query.length - 1);

    try {
      return await db.transaction((transaction) async {
        return await transaction.rawInsert(query);
      });
    } catch (e) {
      print(e);
    }
  }
}

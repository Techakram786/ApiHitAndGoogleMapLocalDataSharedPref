import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/location/LocationData.dart';

class DatabaseHelper {
  Database? _database;
  static const _databaseName = "LOCATION.db";
  static const _databaseVersion = 2;
  static const table = 'LOCATION_TABLE';
  //static const initScript = []; // Initialization script split into seperate statements
  //static const migrationScripts = [];

  //TODO  this opens the database (and creates it if it doesn't exist)
  Future<Database?> initializeDatabase() async {
    if (_database == null) {
      _database = await openDatabase(

        join(await getDatabasesPath(), _databaseName),
        version: _databaseVersion,
        onCreate: (db, version) {
          //initScript.forEach((script) async => await db.execute(script));//todo for migration new data if change table
          // Create your table
          db.execute('''
            CREATE TABLE $table(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            latitude REAL,
            longitude REAL,
            area TEXT,
            locality TEXT,
            postal_code TEXT,
            country TEXT,
            battery_level TEXT,
            device_id TEXT
            )
          ''');

        },

      );
    }
    return _database; // Return the initialized database
  }


  //TODO insert data in table
  Future<int> insertLocationData(LocationData data) async {
    final db = await initializeDatabase(); // Initialize the database
   int result= await db!.insert(table, data.toJson() );
   return result;
  }

  // TODO: Fetch all location data from the table
  Future<List<LocationData>> getAllLocationData() async {
    try {
      final db = await initializeDatabase();
      final List<Map<String, dynamic>> maps = await db!.query(table);

      // TODO Convert the List<Map> to a List<LocationData>
      return List.generate(maps.length, (i) {
        return LocationData(
            latitude: maps[i]['latitude'],
            longitude: maps[i]['longitude'],
            area: maps[i]['area'],
            locality: maps[i]['locality'],
            postal_code: maps[i]['postal_code'],
            country: maps[i]['country'],
            battery_level: maps[i]['battery_level'],
            device_id: maps[i]['device_id']
        );
      });
    }catch(e){
      return[];
    }
  }


  // TODO: Delete all data from the table
  Future<int> deleteAllLocationData() async {
    final db = await initializeDatabase();
    int result =await db!.delete(table);
    return result;
  }
}

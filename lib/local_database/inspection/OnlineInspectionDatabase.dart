import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:pristine_seeds/models/online_inspection_model/OfflineInspectionResponse.dart';
import 'package:sqflite/sqflite.dart';

class OnlineInspectionDatabase {
  Database? _database;
  static const _databaseName = "OnlineInspection.db";
  static const _databaseVersion = 2;
  static const table = 'OnlineInspection_Table';

  Future<Database?> initializeDatabase() async {
    if (_database == null || !_database!.isOpen) {
      _database = await openDatabase(join(await getDatabasesPath(), _databaseName),
        version: _databaseVersion,
        onCreate: (db, version) {
          db.execute('''
          CREATE TABLE $table (
            code TEXT ,
            productionLotNo TEXT,
            seasonCode TEXT,
            seasonName TEXT,
            plantingDate TEXT,
            productionCenterLoc TEXT,
            organizerCode TEXT,
            organizerName TEXT,
            cropCode TEXT,
            varietyCode TEXT,
            itemProductGroupCode TEXT,
            itemClassOfSeeds TEXT,
            sowingDateMale TEXT,
            sowingDateFemale TEXT,
            organizerDetail TEXT,
            growerDetail TEXT,
            inspectionDetail,
            is_offline INTEGER DEFAULT 0,
            UNIQUE(code,productionLotNo)
          )
        ''');
        },
      );
    }
    return _database;
  }

  Future<void> closeDatabase() async {
    if (_database != null && _database!.isOpen) {
      _database!.close();
    }
    _database = null;
  }

  Future<int> insertOnlineInspectionDataList(
      List<OfflineInspectionResponse> dataList) async {
    int result = 0;
    final db = await initializeDatabase();
    try {
      await db!.transaction((txn) async {
        for (var data in dataList) {
          // todo Check if productionLotNo already exists in the table
          List<Map<String, dynamic>> existingLot = await txn.rawQuery('''
          SELECT * FROM $table WHERE productionLotNo = ? AND code = ?
        ''', [data.productionLotNo, data.code]);

          if (existingLot.isEmpty ) {
            // todo Convert growerDetail and organizerDetail to JSON strings
            String growerDetailJson = jsonEncode(data.growerDetail!.toJson());
            String organizerDetailJson =
                jsonEncode(data.organizerDetail!.toJson());
            String inspectionDetailJson = jsonEncode(data.inspectionDetail!
                .map((detail) => detail.toJson())
                .toList());

            result += await txn.rawInsert('''
          INSERT INTO $table (
            code, 
            productionLotNo, 
            seasonCode, 
            seasonName, 
            plantingDate, 
            productionCenterLoc, 
            organizerCode, 
            organizerName, 
            cropCode, 
            varietyCode, 
            itemProductGroupCode, 
            itemClassOfSeeds, 
            sowingDateMale, 
            sowingDateFemale, 
            organizerDetail, 
            growerDetail,
            inspectionDetail,
            is_offline
          ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?)
        ''', [
              data.code,
              data.productionLotNo,
              data.seasonCode,
              data.seasonName,
              data.plantingDate,
              data.productionCenterLoc,
              data.organizerCode,
              data.organizerName,
              data.cropCode,
              data.varietyCode,
              data.itemProductGroupCode,
              data.itemClassOfSeeds,
              data.sowingDateMale,
              data.sowingDateFemale,
              organizerDetailJson,
              growerDetailJson,
              inspectionDetailJson,
              0
            ]);
            print('Insert Data ${result.toString()}');
          }
          else {
            // print("aaa"+existingLot[0]["is_offline"].toString());
            if(existingLot[0]["is_offline"].toString()==null || existingLot[0]["is_offline"].toString()=='' || existingLot[0]["is_offline"].toString()=="0"){
              // todo Convert growerDetail and organizerDetail to JSON strings
              String growerDetailJson = jsonEncode(data.growerDetail!.toJson());
              String organizerDetailJson =
              jsonEncode(data.organizerDetail!.toJson());
              String inspectionDetailJson = jsonEncode(data.inspectionDetail!
                  .map((detail) => detail.toJson())
                  .toList());

              result += await txn.rawUpdate('''
          UPDATE $table SET
            seasonCode=?, 
            seasonName=?, 
            plantingDate=?, 
            productionCenterLoc=?, 
            organizerCode=?, 
            organizerName=?, 
            cropCode=?, 
            varietyCode=?, 
            itemProductGroupCode=?, 
            itemClassOfSeeds=?, 
            sowingDateMale=?, 
            sowingDateFemale=?, 
            organizerDetail=?, 
            growerDetail=?,
            inspectionDetail=?,
            is_offline=?
            where code=? AND productionLotNo=?
        ''', [

                data.seasonCode,
                data.seasonName,
                data.plantingDate,
                data.productionCenterLoc,
                data.organizerCode,
                data.organizerName,
                data.cropCode,
                data.varietyCode,
                data.itemProductGroupCode,
                data.itemClassOfSeeds,
                data.sowingDateMale,
                data.sowingDateFemale,
                organizerDetailJson,
                growerDetailJson,
                inspectionDetailJson,
                0,
                data.code,
                data.productionLotNo
              ]);

            }
          }
        }
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    } catch (e) {
      print(e);
    } finally {
      closeDatabase();
    }

    return result;
  }

  Future<int> updateOfflineInspection(List<InspectionDetail>? inspectionList,

      String planting_no, String production_lot_no, int isOffline) async {
    final db = await initializeDatabase();
    int result = 0;
    try {
      await db!.transaction((txn) async {
        String inspectionDetailJson = jsonEncode(
            inspectionList!.map((detail) => detail.toJson()).toList());
        result += await txn.rawUpdate('''
          UPDATE $table SET
            inspectionDetail=?,
            is_offline=? 
            WHERE code=? AND productionLotNo=?
        ''', [inspectionDetailJson, isOffline, planting_no, production_lot_no]);

        print('Update Data ${result.toString()}');
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    } catch (e) {
      print(e);
    } finally {
      closeDatabase();
    }
    return result;
  }

  Future<List<OfflineInspectionResponse>> getAllOfflineData() async {
    final db = await initializeDatabase();
    try {
      final List<Map<String, dynamic>> maps = await db!.query(table,orderBy: ' code ASC,productionLotNo ASC');

      return List.generate(maps.length, (i) {
        // Retrieve the JSON strings from the database
        String growerDetailJson = maps[i]['growerDetail'];
        String organizerDetailJson = maps[i]['organizerDetail'];
        String inspectionDetailJson = maps[i]['inspectionDetail'];
        // print('aa_'+maps[i]['inspectionDetail']);

        // Convert JSON strings to Map<String, dynamic>
        Map<String, dynamic> growerDetailMap = jsonDecode(growerDetailJson);
        Map<String, dynamic> organizerDetailMap =
            jsonDecode(organizerDetailJson);

        GrowerDetail growerDetail = GrowerDetail.fromJson(growerDetailMap);
        OrganizerDetail organizerDetail =
            OrganizerDetail.fromJson(organizerDetailMap);

        // Parse inspectionDetail JSON
        List<dynamic> inspectionDetailList = jsonDecode(inspectionDetailJson);

        List<InspectionDetail> inspectionDetails = inspectionDetailList
            .map((detailJson) => InspectionDetail.fromJson(detailJson))
            .toList();

        return OfflineInspectionResponse(
          code: maps[i]['code'],
          productionLotNo: maps[i]['productionLotNo'],
          seasonCode: maps[i]['seasonCode'],
          seasonName: maps[i]['seasonName'],
          plantingDate: maps[i]['plantingDate'],
          productionCenterLoc: maps[i]['productionCenterLoc'],
          organizerCode: maps[i]['organizerCode'],
          organizerName: maps[i]['organizerName'],
          cropCode: maps[i]['cropCode'],
          varietyCode: maps[i]['varietyCode'],
          itemProductGroupCode: maps[i]['itemProductGroupCode'],
          itemClassOfSeeds: maps[i]['itemClassOfSeeds'],
          sowingDateMale: maps[i]['sowingDateMale'],
          sowingDateFemale: maps[i]['sowingDateFemale'],
          organizerDetail: organizerDetail,
          growerDetail: growerDetail,
          inspectionDetail: inspectionDetails,
          isOffline:  maps[i]['is_offline'],
        );
      });
    } catch (e) {
      print(e);
    } finally {
      closeDatabase();
    }
    return [];
  }

  Future<List<OfflineInspectionResponse>>
      getAllOfflineInspectionCompleteData() async {
    final db = await initializeDatabase();
    try {
      final List<Map<String, dynamic>> maps = await db!.query(
        table, where: 'is_offline = ? ',
        // Assuming 'code' and 'lot' are column names
        whereArgs: [1], // Pass the values to filter
      );

      return List.generate(maps.length, (i) {
        // Retrieve the JSON strings from the database
        String growerDetailJson = maps[i]['growerDetail'];
        String organizerDetailJson = maps[i]['organizerDetail'];
        String inspectionDetailJson = maps[i]['inspectionDetail'];
        // print('aa_'+maps[i]['inspectionDetail']);

        // Convert JSON strings to Map<String, dynamic>
        Map<String, dynamic> growerDetailMap = jsonDecode(growerDetailJson);
        Map<String, dynamic> organizerDetailMap =
            jsonDecode(organizerDetailJson);

        GrowerDetail growerDetail = GrowerDetail.fromJson(growerDetailMap);
        OrganizerDetail organizerDetail =
            OrganizerDetail.fromJson(organizerDetailMap);

        // Parse inspectionDetail JSON
        List<dynamic> inspectionDetailList = jsonDecode(inspectionDetailJson);

        List<InspectionDetail> inspectionDetails = inspectionDetailList
            .map((detailJson) => InspectionDetail.fromJson(detailJson))
            .toList();

        return OfflineInspectionResponse(
          code: maps[i]['code'],
          productionLotNo: maps[i]['productionLotNo'],
          seasonCode: maps[i]['seasonCode'],
          seasonName: maps[i]['seasonName'],
          plantingDate: maps[i]['plantingDate'],
          productionCenterLoc: maps[i]['productionCenterLoc'],
          organizerCode: maps[i]['organizerCode'],
          organizerName: maps[i]['organizerName'],
          cropCode: maps[i]['cropCode'],
          varietyCode: maps[i]['varietyCode'],
          itemProductGroupCode: maps[i]['itemProductGroupCode'],
          itemClassOfSeeds: maps[i]['itemClassOfSeeds'],
          sowingDateMale: maps[i]['sowingDateMale'],
          sowingDateFemale: maps[i]['sowingDateFemale'],
          organizerDetail: organizerDetail,
          growerDetail: growerDetail,
          inspectionDetail: inspectionDetails,
        );
      });
    } catch (e) {
      print(e);
    } finally {
      closeDatabase();
    }
    return [];
  }

  Future<List<OfflineInspectionResponse>> getProductionLotData(
      String code, String lot) async {
    final db = await initializeDatabase();
    try {
      final List<Map<String, dynamic>> maps = await db!.query(
        table,
        where: 'code = ? AND productionLotNo = ?',
        // Assuming 'code' and 'lot' are column names
        whereArgs: [code, lot], // Pass the values to filter
      );
      return List.generate(maps.length, (i) {
        // Retrieve the JSON strings from the database
        String growerDetailJson = maps[i]['growerDetail'];
        String organizerDetailJson = maps[i]['organizerDetail'];
        String inspectionDetailJson = maps[i]['inspectionDetail'];
        print('aa_' + maps[i]['inspectionDetail']);

        // Convert JSON strings to Map<String, dynamic>
        Map<String, dynamic> growerDetailMap = jsonDecode(growerDetailJson);
        Map<String, dynamic> organizerDetailMap =
            jsonDecode(organizerDetailJson);

        GrowerDetail growerDetail = GrowerDetail.fromJson(growerDetailMap);
        OrganizerDetail organizerDetail =
            OrganizerDetail.fromJson(organizerDetailMap);

        // Parse inspectionDetail JSON
        List<dynamic> inspectionDetailList = jsonDecode(inspectionDetailJson);

        List<InspectionDetail> inspectionDetails = inspectionDetailList
            .map((detailJson) => InspectionDetail.fromJson(detailJson))
            .toList();

        return OfflineInspectionResponse(
          code: maps[i]['code'],
          productionLotNo: maps[i]['productionLotNo'],
          seasonCode: maps[i]['seasonCode'],
          seasonName: maps[i]['seasonName'],
          plantingDate: maps[i]['plantingDate'],
          productionCenterLoc: maps[i]['productionCenterLoc'],
          organizerCode: maps[i]['organizerCode'],
          organizerName: maps[i]['organizerName'],
          cropCode: maps[i]['cropCode'],
          varietyCode: maps[i]['varietyCode'],
          itemProductGroupCode: maps[i]['itemProductGroupCode'],
          itemClassOfSeeds: maps[i]['itemClassOfSeeds'],
          sowingDateMale: maps[i]['sowingDateMale'],
          sowingDateFemale: maps[i]['sowingDateFemale'],
          organizerDetail: organizerDetail,
          growerDetail: growerDetail,
          inspectionDetail: inspectionDetails,
        );
      });
    } catch (e) {
      print(e);
    } finally {
      closeDatabase();
    }
    return [];
  }

  Future<int> deleteAllOfflineInspectionData() async {
    final db = await initializeDatabase();
    int result = 0;
    try {
      result = await db!.delete(
        table, where: 'is_offline = ? ', // Assuming is_offline is  column name
        whereArgs: [1], // Pass the values to filter
      );
    } catch (e) {
    } finally {
      closeDatabase();
    }

    return result;
  }
  Future<int> deleteAllInspectionData() async {
    final db = await initializeDatabase();
    int result = 0;
    try {
      result = await db!.delete(
        table
      );
    } catch (e) {
    } finally {
      closeDatabase();
    }

    return result;
  }


  Future<void> deleteMyLocalDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);
    try{
      await deleteDatabase(path);
      _database = null; // Reset the database instance
    }catch(e){
      print(e);
    }
  }
}



import 'dart:io';

import 'package:mubrm_tag/model/social_media.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "mubrm_tag.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE SocialMedia("
              "id INTEGER PRIMARY KEY,"
              "socialName TEXT,"
              "socialLinkIos TEXT,"
              "socialLinkAndroid TEXT,"
              "socialLinkWeb TEXT,"
              "socialIcon TEXT,"
              "value TEXT,"
              "socialAddedTo BIT,"
              "socialIsSelect BIT"
              ")");
          await db.execute("CREATE TABLE SocialMediaSelected("
              "id INTEGER PRIMARY KEY,"
              "socialName TEXT,"
              "socialLinkIos TEXT,"
              "socialLinkAndroid TEXT,"
              "socialLinkWeb TEXT,"
              "socialIcon TEXT,"
              "value TEXT,"
              "socialAddedTo BIT,"
              "socialIsSelect BIT"
              ")");
        });
    /*
        "id": id,
    "socialName": socialName,
    "socialLinkIos": socialLinkIos,
    "socialLinkAndroid": socialLinkAndroid,
    "socialLinkWeb": socialLinkWeb,
    "socialIcon": socialIcon,
    "socialIsSelect": socialIsSelect,
     */
  }
  newSocialMedia(SocialMedia media) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM SocialMedia");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into SocialMedia (id,socialName,socialLinkIos,socialLinkAndroid,socialLinkWeb,socialIcon,socialIsSelect,socialAddedTo,value)"
            " VALUES (?,?,?,?,?,?,?,?,?)",
        [media.id,media.socialName, media.socialLinkIos, media.socialLinkAndroid, media.socialLinkWeb,media.socialIcon, media.socialIsSelect ? 1: 0,media.socialAddedTo ? 1:0,media.value]);
    print(raw);
    return raw;
  }
  newSocialMediaSelected(SocialMedia media) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM SocialMediaSelected");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into SocialMediaSelected (id,socialName,socialLinkIos,socialLinkAndroid,socialLinkWeb,socialIcon,socialIsSelect,socialAddedTo,value)"
            " VALUES (?,?,?,?,?,?,?,?,?)",
        [media.id,media.socialName, media.socialLinkIos, media.socialLinkAndroid, media.socialLinkWeb,media.socialIcon, media.socialIsSelect,media.socialAddedTo,media.value]);
    print(raw);
    return raw;
  }
  getSocialMedia(int id) async {
    final db = await database;
    var res = await db.query("SocialMedia", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? SocialMedia.fromJson(res.first) : null;
  }
  Future<SocialMedia> getSocialMediaSelected(int id) async {
    final db = await database;
    var res = await db.query("SocialMediaSelected", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? SocialMedia.fromJson(res.first) : null;
  }
  Future<List<Map<String,dynamic>>> getAllMedia() async {
    final db = await database;
    var res = await db.query("SocialMedia",columns: ['id','socialName','socialLinkIos','socialLinkAndroid','socialLinkWeb','socialIcon','socialIsSelect','socialAddedTo','value']);
    return res;
  }
  Future<List<SocialMedia>> getAllMediaSelected() async {
    final db = await database;
    var res = await db.query("SocialMediaSelected",columns: ['id','socialName','socialLinkIos','socialLinkAndroid','socialLinkWeb','socialIcon','socialIsSelect','socialAddedTo','value']);
    List<SocialMedia> list =
    res.isNotEmpty ? res.map((c) => SocialMedia.fromJson(c)).toList() : [];
    return list;
  }
  Future<bool> checkDatabaseIsNotEmpty() async{
    final db = await database;
    var res = await db.query("SocialMedia",columns: ['id','socialName','socialLinkIos','socialLinkAndroid','socialLinkWeb','socialIcon','socialIsSelect','socialAddedTo','value']);
    if(res.isNotEmpty)
      return true;
    return false;
  }
  updateClient(SocialMedia newSocialMedia) async {
    final db = await database;
    var res = await db.update("SocialMedia", newSocialMedia.toJson(),
        where: "id = ?", whereArgs: [newSocialMedia.id]);
    return res;
  }
  updateMediaSelected(SocialMedia _media) async {
    final db = await database;
    SocialMedia media = SocialMedia(
      socialName: _media.socialName,
      id: _media.id,
      socialIcon: _media.socialIcon,
      socialIsSelect: false,
      socialAddedTo: true,
      socialLinkAndroid: _media.socialLinkAndroid,
      socialLinkWeb: _media.socialLinkWeb,
      socialLinkIos: _media.socialLinkIos,
      value: _media.value,
    );

    var res = await db.update("SocialMediaSelected", media.toJson(),
        where: "id = ?", whereArgs: [media.id]);

    return res;
  }

  deleteAll() async {
    final db = await database;
    //db.rawDelete("Delete * from SocialMedia");
    db.delete('SocialMedia');
  }



}

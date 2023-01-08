import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class KitaplarDatabase {
  static const String databaseName = "kitap.sqlite";

  static Future<Database> databaseAccess() async {
    String databasePath = join(await getDatabasesPath(), databaseName);
    if (await databaseExists(databasePath)) {
      if (kDebugMode) {
        print("database zaten ekli");
      }
    } else {
      ByteData data = await rootBundle.load("veritabani/$databaseName");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(databasePath).writeAsBytes(bytes, flush: true);
      if (kDebugMode) {
        print("database kopyalandı");
      }
    }
    return openDatabase(databasePath);
  }
}

import 'package:to_do_application/data/entity/kitaplar.dart';
import 'package:to_do_application/data/sqlite/kitaplar_database.dart';

class KitaplarDaoRepository {
  Future<void> save(String kitap_ad, String yazar_ad) async {
    var db = await KitaplarDatabase.databaseAccess();
    var bilgiler = Map<String, dynamic>();
    bilgiler["kitap_ad"] = kitap_ad;
    bilgiler["yazar_ad"] = yazar_ad;
    await db.insert("toDos", bilgiler);
  }

  Future<void> update(int id, String kitap_ad, String yazar_ad) async {
    var db = await KitaplarDatabase.databaseAccess();
    var bilgiler = Map<String, dynamic>();
    bilgiler["kitap_ad"] = kitap_ad;
    bilgiler["yazar_ad"] = yazar_ad;
    await db.update("toDos", bilgiler, where: "id=?", whereArgs: [id]);
  }

  Future<List<Kitaplar>> loadBooks() async {
    var db = await KitaplarDatabase.databaseAccess();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM toDos");
    return List.generate(maps.length, (index) {
      var satir = maps[index];
      return Kitaplar(
          kitap_id: satir["id"],
          kitap_ad: satir["kitap_ad"],
          yazar_ad: satir["yazar_ad"]);
    });
  }

  Future<List<Kitaplar>> search(String searchWord) async {
    var db = await KitaplarDatabase.databaseAccess();
    List<Map<String, dynamic>> maps = await db
        .rawQuery("SELECT * FROM toDos WHERE kitap_ad LIKE '%$searchWord%'");
    return List.generate(maps.length, (index) {
      var satir = maps[index];
      return Kitaplar(
          kitap_id: satir["id"],
          kitap_ad: satir["kitap_ad"],
          yazar_ad: satir["yazar_ad"]);
    });
  }

  Future<void> delete(int kitap_id) async {
    var db = await KitaplarDatabase.databaseAccess();
    var bilgiler = Map<String, dynamic>();
    bilgiler["kitap_ad"] = kitap_id;
    await db.delete("toDos", where: "id=?", whereArgs: [kitap_id]);
  }
}

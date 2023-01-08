import 'package:to_do_application/data/repo/kitaplardao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/entity/kitaplar.dart';

class AnasayfaCubit extends Cubit<List<Kitaplar>> {
  AnasayfaCubit() : super(<Kitaplar>[]);

  var krepo = KitaplarDaoRepository();

  Future<void> search(String searchWord) async {
    var liste = await krepo.search(searchWord);
    emit(liste);
  }

  Future<void> loadBooks() async {
    var liste = await krepo.loadBooks();
    emit(liste);
  }

  Future<void> delete(int kitap_id) async {
    await krepo.delete(kitap_id);
    await loadBooks();
  }
}

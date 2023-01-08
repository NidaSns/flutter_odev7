import 'package:to_do_application/data/repo/kitaplardao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KitapKayitCubit extends Cubit<void> {
  KitapKayitCubit() : super(0);

  var krepo = KitaplarDaoRepository();

  Future<void> save(String kitap_ad, String yazar_ad) async {
    await krepo.save(kitap_ad, yazar_ad);
  }
}

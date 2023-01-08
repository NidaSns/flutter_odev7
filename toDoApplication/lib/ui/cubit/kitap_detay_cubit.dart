import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/data/repo/kitaplardao_repository.dart';

class KitapDetayCubit extends Cubit {
  KitapDetayCubit() : super(0);

  var krepo = KitaplarDaoRepository();

  Future<void> update(int kitap_id, String kitap_ad, String yazar_ad) async {
    await krepo.update(kitap_id, kitap_ad, yazar_ad);
  }
}

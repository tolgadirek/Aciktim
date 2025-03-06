import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_uygulamasi/data/entitiy/repo/yemeklerdao_repository.dart';
import 'package:yemek_uygulamasi/data/entitiy/yemekler.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>> {
  AnasayfaCubit():super(<Yemekler>[]);

  var yrepo = YemeklerDaoRepository();

  Future<void> yemekleriYukle() async {
    var liste = await yrepo.yemekleriYukle();
    emit(liste); // Listeyi arayüze gönderiyoruz, arayüzü güncelliyoruz.
  }

}
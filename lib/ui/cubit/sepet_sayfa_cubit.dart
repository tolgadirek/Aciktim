import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_uygulamasi/data/entitiy/repo/yemeklerdao_repository.dart';
import 'package:yemek_uygulamasi/data/entitiy/sepet_yemekler.dart';

class SepetSayfaCubit extends Cubit<List<SepetYemekler>> {
  SepetSayfaCubit():super(<SepetYemekler>[]);

  var yrepo = YemeklerDaoRepository();

  Future<void> sepetYemekleriYukle(String kullanici_adi) async {
    var liste = await yrepo.sepetYemekleriYukle(kullanici_adi);
    emit(liste); // Listeyi arayüze gönderiyoruz, arayüzü güncelliyoruz.

  }

  Future<void> sil(int sepet_yemek_id, String kullanici_adi) async {
    await yrepo.sil(sepet_yemek_id, kullanici_adi);
    await sepetYemekleriYukle(kullanici_adi); // En son sildikten sonra ekranda da yok olması için tekrar çağırıyoruz.
  }

  Future<void> sepetiBosalt(String kullanici_adi) async {
    await yrepo.sepetiBosalt(kullanici_adi);
    await sepetYemekleriYukle(kullanici_adi); // En son sildikten sonra ekranda da yok olması için tekrar çağırıyoruz.
  }

}
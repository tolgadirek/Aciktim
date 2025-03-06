import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_uygulamasi/data/entitiy/repo/yemeklerdao_repository.dart';

class DetaySayfaCubit extends Cubit<void> {
  DetaySayfaCubit():super(0);

  var yrepo = YemeklerDaoRepository();

  Future<void> sepeteEkle(
      String yemek_adi, String yemek_resim_adi, String yemek_fiyat, int yemek_siparis_adet, String kullanici_adi) async {
    await yrepo.sepeteEkle(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi); // Daha sonradan veritabanı işlemleri için await performans sağlar bize.
  }

}
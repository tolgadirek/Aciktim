import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:yemek_uygulamasi/data/entitiy/sepet_yemekler.dart';
import 'package:yemek_uygulamasi/data/entitiy/sepet_yemekler_cevap.dart';
import 'package:yemek_uygulamasi/data/entitiy/yemekler.dart';
import 'package:yemek_uygulamasi/data/entitiy/yemekler_cevap.dart';

class YemeklerDaoRepository {

  List<Yemekler> parseYemekler(String cevap) {
    return YemeklerCevap.fromJson(json.decode(cevap)).yemekler;
  }

  List<SepetYemekler> parseSepetYemekler(String cevap) {
    return SepetYemeklerCevap.fromJson(json.decode(cevap)).sepet_yemekler;
  }

  Future<List<Yemekler>> yemekleriYukle() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parseYemekler(cevap.data.toString());
  }

  Future<List<SepetYemekler>> sepetYemekleriYukle(String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    try {
      var veri = {"kullanici_adi": kullanici_adi};
      var cevap = await Dio().post(url, data: FormData.fromMap(veri));
      return parseSepetYemekler(cevap.data.toString());

    } catch (e) {
      print('Hata: $e');
      return [];
    }
  }

  Future<void> sepeteEkle(
      String yemek_adi, String yemek_resim_adi, String yemek_fiyat, int yemek_siparis_adet, String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {
      "yemek_adi":yemek_adi,
      "yemek_resim_adi":yemek_resim_adi,
      "yemek_fiyat":yemek_fiyat,
      "yemek_siparis_adet":yemek_siparis_adet,
      "kullanici_adi": kullanici_adi
    };
    await Dio().post(url, data: FormData.fromMap(veri));
  }

  Future<void> sil(int sepet_yemek_id, String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {"sepet_yemek_id":sepet_yemek_id , "kullanici_adi":kullanici_adi};
    await Dio().post(url, data: FormData.fromMap(veri));
  }

  Future<List<int>> kullaniciyaAitSepetIdleriGetir(String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";

    try {
      var veri = {"kullanici_adi": kullanici_adi};
      var cevap = await Dio().post(url, data: FormData.fromMap(veri));

      var jsonCevap = jsonDecode(cevap.data.toString()); // Gelen cevabı JSON formatına çeviriyoruz

      List<dynamic> sepetYemekler = jsonCevap["sepet_yemekler"];

      List<int> idListesi = sepetYemekler.map((yemek) => int.parse(yemek["sepet_yemek_id"])).toList(); // Tüm ID'leri listeye atıyoruz

      return idListesi;
    } catch (e) {
      print('Hata: $e');
      return [];
    }
  }

  Future<void> sepetiBosalt(String kullanici_adi) async {
    List<int> idler = await kullaniciyaAitSepetIdleriGetir(kullanici_adi);
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    for (var id in idler) {
      await Dio().post(url, data: FormData.fromMap({"sepet_yemek_id": id, "kullanici_adi": kullanici_adi}));
    }
  }

}
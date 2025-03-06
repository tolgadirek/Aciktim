import 'package:yemek_uygulamasi/data/entitiy/sepet_yemekler.dart';

class SepetYemeklerCevap {
  List<SepetYemekler> sepet_yemekler;
  int success;

  SepetYemeklerCevap({required this.sepet_yemekler, required this.success});

  factory SepetYemeklerCevap.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["sepet_yemekler"];
    int success = json["success"] ?? 0; // Null ise 0 ata

    List<SepetYemekler> sepet_yemekler = (jsonArray != null) ?
    List<SepetYemekler>.from(jsonArray.map((jsonArrayNesnesi) => SepetYemekler.fromJson(jsonArrayNesnesi))) : []; // Null ise boş liste ata

    return SepetYemeklerCevap(sepet_yemekler: sepet_yemekler, success: success);
  }
}
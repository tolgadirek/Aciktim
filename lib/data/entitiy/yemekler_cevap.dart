import 'package:yemek_uygulamasi/data/entitiy/yemekler.dart';

class YemeklerCevap {
  List<Yemekler> yemekler;
  int success;

  YemeklerCevap({required this.yemekler, required this.success});

  factory YemeklerCevap.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["yemekler"] as List;
    int success = json["success"] as int;

    var yemekler = jsonArray.map((jsonArrayNesnesi) => Yemekler.fromJson(jsonArrayNesnesi)).toList();

    return YemeklerCevap(yemekler: yemekler, success: success);
  }
}
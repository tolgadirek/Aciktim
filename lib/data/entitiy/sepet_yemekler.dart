class SepetYemekler {
  int sepet_yemek_id;
  String yemek_adi;
  String yemek_resim_adi;
  int yemek_fiyat;
  int yemek_siparis_adet;
  String kullanici_adi;

  SepetYemekler(
        {required this.sepet_yemek_id,
        required this.yemek_adi,
        required this.yemek_resim_adi,
          required this.yemek_fiyat,
          required this.yemek_siparis_adet,
          required this.kullanici_adi
        });

  factory SepetYemekler.fromJson(Map<String, dynamic> json) {
    return SepetYemekler(
      sepet_yemek_id: int.parse(json['sepet_yemek_id'].toString()),
      yemek_adi: json['yemek_adi'],
      yemek_resim_adi: json['yemek_resim_adi'],
      yemek_fiyat: int.parse(json['yemek_fiyat'].toString()),
      yemek_siparis_adet: int.parse(json['yemek_siparis_adet'].toString()),
      kullanici_adi: json['kullanici_adi'],
    );
  }
}
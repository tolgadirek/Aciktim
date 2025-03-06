import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_uygulamasi/data/entitiy/sepet_yemekler.dart';
import 'package:yemek_uygulamasi/ui/cubit/sepet_sayfa_cubit.dart';

class SepetSayfa extends StatefulWidget {
  String kullanici_adi;


  SepetSayfa({required this.kullanici_adi});

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {

  @override
  void initState() {
    super.initState();
    context.read<SepetSayfaCubit>().sepetYemekleriYukle(widget.kullanici_adi);
  }

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height; //707.4285714285714
    final double ekranGenisligi = ekranBilgisi.size.width; //411.42857142857144
    return Scaffold(
        appBar: AppBar(title: const Text("Sepet", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: BlocBuilder<SepetSayfaCubit, List<SepetYemekler>>(
        builder: (context, sepetYemeklerListesi) {
          if(sepetYemeklerListesi.isNotEmpty){
            // **Toplam fiyatı hesapla**
            int toplamFiyat = sepetYemeklerListesi.fold(0, (toplam, urun) {
              return toplam + (urun.yemek_fiyat * urun.yemek_siparis_adet);
            });

            return Column(
              children: [
                // **Ürün Listesi (Kaydırılabilir)**
                Expanded(
                  child: ListView.builder(
                    itemCount: sepetYemeklerListesi.length,
                    itemBuilder: (context, indeks) {
                      var sepetYemek = sepetYemeklerListesi[indeks];
                      return Card(
                        child: Padding(
                          padding: EdgeInsets.only(right: ekranGenisligi/27.43, left: ekranGenisligi/27.43),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: ekranYuksekligi/5.9,
                                width: ekranGenisligi/3.43,
                                child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${sepetYemek.yemek_resim_adi}",),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(sepetYemek.yemek_adi, style:  TextStyle(fontSize: ekranYuksekligi/39.3, fontWeight: FontWeight.bold,),),
                                  Text("Fiyat: ₺${sepetYemek.yemek_fiyat}", style:  TextStyle(fontSize: ekranYuksekligi/47.16),),
                                  Text("Adet: ${sepetYemek.yemek_siparis_adet}", style:  TextStyle(fontSize: ekranYuksekligi/47.16),),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      context.read<SepetSayfaCubit>().sil(sepetYemek.sepet_yemek_id, sepetYemek.kullanici_adi,);
                                    },
                                    icon: const Icon(Icons.clear, color: Colors.black54),
                                  ),
                                  Text("₺${sepetYemek.yemek_fiyat * sepetYemek.yemek_siparis_adet}", style: TextStyle(fontSize: ekranYuksekligi/39.3, fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // **Alt Kısım (Sabit)**
                Container(
                  padding: EdgeInsets.all(ekranYuksekligi/47.16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Kapıda Ödeme", style:  TextStyle(fontSize: ekranYuksekligi/47.16, color: Colors.black38,)),
                      SizedBox(height: ekranYuksekligi/70.74),
                      Row(
                        children: [
                          Text("Teslimat Ücreti", style:  TextStyle(fontSize: ekranYuksekligi/47.16, color: Colors.black38,),),
                          const Spacer(),
                          Text("₺0", style: TextStyle(fontSize: ekranYuksekligi/47.16, color: Colors.black38,),),
                        ],
                      ),
                      SizedBox(height: ekranYuksekligi/70.74),
                      Row(
                        children: [
                          Text("Toplam:", style:  TextStyle(fontSize: ekranYuksekligi/28.3, fontWeight: FontWeight.bold, color: Colors.black,),),
                          const Spacer(),
                          Text("₺$toplamFiyat", style: TextStyle(fontSize: ekranYuksekligi/28.3, fontWeight: FontWeight.bold, color: Colors.black,),),
                        ],
                      ),
                      SizedBox(height: ekranYuksekligi/70.74),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Siparişiniz oluşturuldu!"),),);
                            context.read<SepetSayfaCubit>().sepetiBosalt(widget.kullanici_adi);
                            },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, padding: EdgeInsets.symmetric(vertical: ekranYuksekligi/47.16),),
                          child: Text("Siparişi Tamamla", style: TextStyle(fontSize: ekranYuksekligi/39.3, color: Colors.white),),),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }else{
            return Center(
              child: Text("Sepetinizde Ürün Bulunmamaktadır.", style: TextStyle(fontSize: ekranYuksekligi/39.3, color: Colors.black38),),
            ); //Eğer boşsa boş sayfa göstersin dedik
          }
        },
      ),
    );
  }
}

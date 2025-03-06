import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_uygulamasi/data/entitiy/yemekler.dart';
import 'package:yemek_uygulamasi/ui/cubit/anasayfa_cubit.dart';
import 'package:yemek_uygulamasi/ui/view/detay_sayfa.dart';
import 'package:yemek_uygulamasi/ui/view/kullanici_giris.dart';
import 'package:yemek_uygulamasi/ui/view/sepet_sayfa.dart';

class Anasayfa extends StatefulWidget {
  String kullanici_adi;


  Anasayfa({required this.kullanici_adi});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height; //707.4285714285714
    final double ekranGenisligi = ekranBilgisi.size.width; //411.42857142857144

    return Scaffold(
      appBar: AppBar(
        title: const Text("Yemekler", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SepetSayfa(kullanici_adi: widget.kullanici_adi)));
          }, icon: const Icon(Icons.shopping_basket_outlined, color: Colors.white,),),
          IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const KullaniciGiris()));
          }, icon: const Icon(Icons.logout, color: Colors.white,),),
        ],
      ),
      body: BlocBuilder<AnasayfaCubit, List<Yemekler>>(
        builder: (context, yemeklerListesi) {
          if(yemeklerListesi.isNotEmpty){
            return GridView.builder(
              itemCount: yemeklerListesi.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( // Bu yapı yan yana kaç adet gözükeceğini belirler. Bu yapı olmazsa olmaz.
                  crossAxisCount: 2, childAspectRatio: 1 / 1.8 // Boyutu ise child şeyi ile yaparız. Mesela genişlik 1 olsun yükseklik 1.8 olsun dedik. Orana göre ayarlar
              ),
              itemBuilder: (context, indeks) {
                var yemek = yemeklerListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(yemek: yemek, kullanici_adi: widget.kullanici_adi)));
                  },
                  child: Card( // Görünümü card olarak seçiyorruz. Öyle gözükmesini istediğimiz için.
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                        Text(yemek.yemek_adi, style: TextStyle(fontSize: ekranYuksekligi/35.37, fontWeight: FontWeight.bold),),
                        const Text("Ücretsiz Teslimat", style: TextStyle(color: Colors.grey),),
                        Padding(
                          padding: EdgeInsets.only(right: ekranGenisligi/51.43, left: ekranGenisligi/51.43),
                          child: Row(
                            children: [
                              Text("₺${yemek.yemek_fiyat}", style: TextStyle(fontSize: ekranYuksekligi/35.37, fontWeight: FontWeight.bold),),
                              const Spacer(),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
                                  ),
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(yemek: yemek, kullanici_adi: widget.kullanici_adi)));
                              }, child: Text("+", style: TextStyle(color: Colors.white, fontSize: ekranYuksekligi/35.37, fontWeight: FontWeight.bold),)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }else{
            return const Center(); //Eğer boşsa boş sayfa göstersin dedik
          }
        },
      ),
    );
  }
}

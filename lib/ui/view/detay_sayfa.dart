import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_uygulamasi/data/entitiy/yemekler.dart';
import 'package:yemek_uygulamasi/ui/cubit/detay_sayfa_cubit.dart';

class DetaySayfa extends StatefulWidget {
  Yemekler yemek;
  String kullanici_adi;

  DetaySayfa({super.key, required this.yemek, required this.kullanici_adi});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  int urunSayisi = 1;
  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height; //707.4285714285714
    final double ekranGenisligi = ekranBilgisi.size.width; //411.42857142857144
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.yemek.yemek_adi, style: const TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.indigo,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}"),
            Text("₺${widget.yemek.yemek_fiyat}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: ekranYuksekligi/28.3, color: Colors.deepPurple),),
            Text(widget.yemek.yemek_adi, style: TextStyle(fontWeight: FontWeight.bold, fontSize: ekranYuksekligi/23.58),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
                    ),
                    onPressed: (){
                      setState(() {
                        if(urunSayisi != 1){
                          urunSayisi -= 1;
                        }
                      });
                    },child: Text("-", style: TextStyle(color: Colors.white, fontSize: ekranYuksekligi/28.3,))),
                Padding(
                  padding: EdgeInsets.only(right: ekranGenisligi/13.71, left: ekranGenisligi/13.71),
                  child: Text(urunSayisi.toString(), style: TextStyle(fontSize: ekranYuksekligi/28.3, fontWeight: FontWeight.bold),),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
                    ),
                    onPressed: (){
                      setState(() {
                        urunSayisi += 1;
                      });
                    },child: Text("+", style: TextStyle(color: Colors.white, fontSize: ekranYuksekligi/28.3,),)),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: ekranYuksekligi/8.84),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("₺${int.parse(widget.yemek.yemek_fiyat) * urunSayisi}", style: TextStyle(fontSize: ekranYuksekligi/23.58, fontWeight: FontWeight.bold),),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
                      ),
                      onPressed: (){
                        context.read<DetaySayfaCubit>().sepeteEkle(
                          widget.yemek.yemek_adi,
                          widget.yemek.yemek_resim_adi,
                          widget.yemek.yemek_fiyat,
                          urunSayisi,
                          widget.kullanici_adi
                        );
                      }, child: Text("Sepete Ekle", style: TextStyle(color: Colors.white, fontSize: ekranYuksekligi/28.3,),)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

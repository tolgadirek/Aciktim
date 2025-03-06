import 'package:flutter/material.dart';
import 'package:yemek_uygulamasi/ui/view/anasayfa.dart';

class KullaniciGiris extends StatefulWidget {
  const KullaniciGiris({super.key});

  @override
  State<KullaniciGiris> createState() => _KullaniciGirisState();
}

class _KullaniciGirisState extends State<KullaniciGiris> {
  var tfKullaniciAdi = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height; //707.4285714285714
    final double ekranGenisligi = ekranBilgisi.size.width; //411.42857142857144
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kullanıcı Giriş", style: TextStyle(color: Colors.white),), backgroundColor: Colors.indigo,
        centerTitle: true,
      ),

      body: Center(
        child: Padding(
          padding: EdgeInsets.only(right: ekranGenisligi/8.23, left: ekranGenisligi/8.23),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(controller: tfKullaniciAdi, decoration: const InputDecoration(hintText: "Kullanıcı Adı Giriniz"),),
              SizedBox(height: ekranYuksekligi/14.15),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
                  ),
                  onPressed: (){
                if(tfKullaniciAdi.text != ""){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Anasayfa(kullanici_adi: tfKullaniciAdi.text)));
                }
              }, child: const Text("Giriş", style: TextStyle(color: Colors.white),)),
            ],
          ),
        ),
      ),
    );
  }
}

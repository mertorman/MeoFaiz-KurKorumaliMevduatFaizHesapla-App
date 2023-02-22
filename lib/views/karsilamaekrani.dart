import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:hive/hive.dart';
import 'package:mevduatfaiz_hesapla/views/anasayfa.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class KarsilamaEkrani extends StatelessWidget {
  const KarsilamaEkrani({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('');
    return Scaffold(
      body: IntroductionScreen(
        globalHeader: Center(
          child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                "MeoSoftware",
                textAlign: TextAlign.center,
                style: GoogleFonts.kaushanScript(
                  textStyle: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )),
        ),
        scrollPhysics: const BouncingScrollPhysics(),
        pages: [
          PageViewModel(
            title: 'İki işlem tek uygulamada!',
            //   body: 'İster "Kur Korumalı TL Vadeli Mevduat Hesabı" için, ister bankaların diğer mevduat hesapları için kazanç tahmininizi yapın.',
            image: Stack(children: [Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Center(child: SvgPicture.asset("images/karsilama1.svg")),
            ), Padding(
              padding: const EdgeInsets.only(right: 30,top: 85),
              child: Center(child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.asset("images/gif2.gif",height: 255,width: 120,))),
            )]),
            bodyWidget: Stack(
              children: 
                [Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "İster 'Kur Korumalı TL Vadeli Mevduat Hesabı' için, ister bankaların diğer mevduat hesapları için kazanç tahmininizi yapın.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
                    ),
                    SizedBox(height: 30,),
                    Text("Kur Korumalı Mevduat Hesabı tahmini için yukarıda gösterildiği gibi butonu açık konuma getirmeniz yeterlidir. Normal mevduat hesabı tahminleri içinde butonu kapalı konuma getiriniz.",textAlign: TextAlign.center,style: TextStyle(color: Colors.black),)
                  ],
                ),
              ],
            ),
            decoration: const PageDecoration(
              pageColor: Color(0xFF7990FD),
              imageFlex: 6,
              bodyFlex: 5,
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
              bodyTextStyle:
                  TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
            ),
          ),
          PageViewModel(
            title: 'Birçok banka ve güncel faiz oranları!',
            bodyWidget: Column(
              children: [
                Text(
                  "Bankaların güncel faiz oranları ile kazancınızı görerek diğer bankalar ile karşılaştırın!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                    "*Hesaplamalar sadece bilgi amaçlı hazırlanmış olup, bağlayıcı bir nitelik içermemektedir. Tahmin verilerine dayanarak yapılan yatırımlardan ve doğabilecek sorunlardan MeoSoftware sorumlu değildir.",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w400),),
                 
              ],
            ),
            image: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Center(child: SvgPicture.asset("images/karsilama2.svg")),
            ),
            decoration: const PageDecoration(
              imageFlex: 11,
              bodyFlex: 10,
              pageColor: Color(0xFF7990FD),
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
              bodyTextStyle:
                  TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
            ),
          ),
        ],
        onDone: () {
         box.put('introduction', false);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const Anasayfa();
              },
            ),
          );
        },
        skip: const Icon(Icons.skip_next),
        next: const Icon(Icons.forward),
        done: const Text("Anasayfa!",
            style: TextStyle(fontWeight: FontWeight.w600)),
        dotsContainerDecorator: BoxDecoration(color: Color(0xFF7990FD)),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Colors.white,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}

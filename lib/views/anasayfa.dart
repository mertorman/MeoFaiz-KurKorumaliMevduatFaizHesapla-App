// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mevduatfaiz_hesapla/services/admob.dart';
import 'package:mevduatfaiz_hesapla/services/dovizkur.dart';
import 'package:mevduatfaiz_hesapla/models/dovizmodel.dart';
import 'package:mevduatfaiz_hesapla/services/faizoranlari.dart';
import 'package:mevduatfaiz_hesapla/utils/hesaplama.dart';
import 'package:mevduatfaiz_hesapla/views/karsilamaekrani.dart';
import 'package:mevduatfaiz_hesapla/views/sonucsayfasi.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import '../widgets/bankalarwidget.dart';
import '../models/bankmodels.dart';
import 'package:mevduatfaiz_hesapla/utils/faizsec.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import '../widgets/loading_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_fonts/google_fonts.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  /*
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

  late BannerAd staticAd;
  static const AdRequest request = AdRequest();
  bool staticadLoaded = false;
  late BannerAd inlineAd;
  */

  Color renkacik = Colors.green.shade300;
  Color renkapali = Colors.red.shade300;
  Color doviztextrenk = Color(0XFF566573);
  bool dovizkapali = true;
  bool _yukleme = true;
  late String usdalis;
  late var dropdownitemorj;
  List<DropdownMenuItem<String>> dropdownitem = [
    'Vade Seçiniz (Gün)',
    '32',
    '46',
    '55',
    '92',
    '181'
  ].map<DropdownMenuItem<String>>((String deger) {
    return DropdownMenuItem<String>(
      value: deger,
      child: Center(
        child: Text(
          deger,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }).toList();
  List<DropdownMenuItem<String>> dropdownitem2 = [
    'Vade Seçiniz (Gün)',
    '92',
    '181',
    '272',
    '365'
  ].map<DropdownMenuItem<String>>((String deger) {
    return DropdownMenuItem<String>(
      value: deger,
      child: Center(
        child: Text(
          deger,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }).toList();
  static var now = DateTime.now();
  static var formatterDate = DateFormat('dd/MM/yyyy');
  String tarih = formatterDate.format(now);
  TextEditingController textKontrol = TextEditingController();
  late double anapara;
  late FaizSec faizSec;

  late List<DovizModel> kurlar;
  late List<bankModels> bankalar;
  late Map veri;
  static String dropdowndeger = "Vade Seçiniz (Gün)";
  late String kurtahmin;
  late String vadebaskurtahmin;
  String? dropdowndeger2;
  String? test;
  @override
  void initState() {
    ads.loadInterstitialAd();
    ads.loadStaticBannerAd();
    faizOranlari();
    dropdownitemorj = dropdownitem;
    super.initState();
  }

  @override
  void dispose() {
    ads.interstitialAd?.dispose();
    super.dispose();
  }

  AdmobAd ads = AdmobAd();

  faizOranlari() async {
    FaizOranlari faiz = FaizOranlari();
    await faiz.faizGetir();
    bankalar = faiz.bankalar;
    veri = faiz.veri;
    DovizApi doviz = DovizApi();
    await doviz.DovizGetir();
    kurlar = doviz.kur;
    kurtahmin = double.parse(kurlar[0].usdalis).toStringAsFixed(1);
    vadebaskurtahmin = (double.parse(kurtahmin) - 2).toStringAsFixed(1);
    usdalis = kurtahmin;
    faizSec = FaizSec(veri: veri, bankalar: bankalar);
    setState(() {
      _yukleme = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('');

    bool firstTimeState = box.get('introduction') ?? true;
    return firstTimeState
        ? const KarsilamaEkrani()
        : GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
                backgroundColor: Color(0xFFE9EBEE),
                resizeToAvoidBottomInset: false,
                body: _yukleme
                    ? Center(child: YuklemeEkrani())
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              clipBehavior: Clip.antiAlias,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height*0.315,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: const [
                                            Color(0xff272735),
                                            Color(0xFF42424C)
                                          ],
                                          begin: FractionalOffset(0.0, 0.4),
                                          end: Alignment.topRight),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(24),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Center(
                                    child: Container(
                                      child: AdWidget(
                                        ad: ads.staticAd! ,
                                      ),
                                      width: ads.staticAd!.size.width.toDouble(),
                                      height: ads.staticAd!.size.height.toDouble(),
                                      alignment: Alignment.topCenter,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 80,
                                  ),
                                  child: Container(
                                      height: MediaQuery.of(context).size.height*0.22,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: bankalar.length,
                                          itemBuilder: (context, index) {
                                            return bankcontainer(
                                                faizorantl: bankalar[index]
                                                    .anasayfatlkur,
                                                faizoranusd: bankalar[index]
                                                    .anasayfadolarkur,
                                                faizorandoviz: bankalar[index]
                                                    .anasayfadovizkur,
                                                logo: bankalar[index].resimurl,
                                                tarih: tarih);
                                          })),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  "Anapara ve vade seçimi yapınız",
                                  style: GoogleFonts.poppins(fontSize: 14.5),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.245,
                                decoration: BoxDecoration(
                                    color: Color(0xFFF3F4F4),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.indigo.shade300.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: Offset(3, 3),
                                      )
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            splashColor: Colors.indigo.shade100,
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  child: ExpansionTile(
                                                    maintainState: true,
                                                    title: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Türk Lirası",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 17),
                                                        ),
                                                        Text("TL",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 15))
                                                      ],
                                                    ),
                                                    leading: Image.asset(
                                                      "images/turkey.png",
                                                      width: 50,
                                                      height: 50,
                                                    ),
                                                    children: [
                                                      ListTile(
                                                        title: Text(
                                                            "Dolar (USD) (Yakında!)",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 17)),
                                                        leading: Image.asset(
                                                          "images/abd.png",
                                                          width: 50,
                                                          height: 50,
                                                        ),
                                                      ),
                                                      ListTile(
                                                        title: Text(
                                                            "Euro (EUR) (Yakında!)",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 17)),
                                                        leading: Image.asset(
                                                          "images/euroflag.png",
                                                          width: 50,
                                                          height: 50,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          validator: (value) {
                                            if (value != "" &&
                                                value!.length < 5) {
                                              return "Minimum 1000 TL giriniz.";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: textKontrol,
                                          inputFormatters: <TextInputFormatter>[
                                            LengthLimitingTextInputFormatter(9),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            MoneyInputFormatter(
                                                mantissaLength: 0,
                                                trailingSymbol: "₺",
                                                thousandSeparator:
                                                    ThousandSeparator.Period)
                                          ],
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                          decoration: InputDecoration(
                                            alignLabelWithHint: true,
                                            labelStyle: TextStyle(),
                                            labelText: "Türk Lirası",
                                            helperText: "",
                                            helperStyle: TextStyle(),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 20,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                            ),
                                            hintText:
                                                "Anapara miktarını giriniz",
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                flex: 2,
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton2(
                                                    isExpanded: true,
                                                    hint: Row(
                                                      children: const [
                                                        Icon(
                                                          Icons.list,
                                                          size: 17,
                                                          color:
                                                              Color(0xFFFFFF7A),
                                                        ),
                                                        SizedBox(
                                                          width: 4,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            'Vade Seçiniz (Gün)',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xFFFFFF7A),
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    items: dropdownitemorj,
                                                    value: dropdowndeger2,
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        dropdowndeger2 = value!;
                                                        dropdowndeger = value;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons
                                                          .arrow_forward_ios_outlined,
                                                    ),
                                                    iconSize: 15,
                                                    iconEnabledColor:
                                                        Color(0xFFFFFF7A),
                                                    iconDisabledColor:
                                                        Color(0xFF1182A4),
                                                    buttonHeight: 50,
                                                    buttonWidth: 200,
                                                    buttonPadding:
                                                        const EdgeInsets.only(
                                                            left: 14,
                                                            right: 14),
                                                    buttonDecoration:
                                                        BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14),
                                                      border: Border.all(
                                                        color: Colors.black26,
                                                      ),
                                                      color: Color(0xFF58A8BF),
                                                    ),
                                                    buttonElevation: 2,
                                                    itemHeight: 40,
                                                    itemPadding:
                                                        const EdgeInsets.only(
                                                            left: 14,
                                                            right: 14),
                                                    dropdownMaxHeight: 200,
                                                    dropdownWidth: 200,
                                                    dropdownPadding: null,
                                                    dropdownDecoration:
                                                        BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14),
                                                      color: Color(0xFF58A8BF),
                                                    ),
                                                    dropdownElevation: 8,
                                                    scrollbarRadius:
                                                        const Radius.circular(
                                                            40),
                                                    scrollbarThickness: 6,
                                                    scrollbarAlwaysShow: true,
                                                    offset: const Offset(0, 0),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    ads.interstitialAd?.show();
                                                    if (textKontrol
                                                        .text.isNotEmpty) {
                                                      anapara = double.parse(
                                                          textKontrol.text
                                                              .replaceAll(
                                                                  new RegExp(
                                                                      r'[^0-9]'),
                                                                  ''));

                                                      if (dropdowndeger !=
                                                              'Vade Seçiniz (Gün)' &&
                                                          1000 <= anapara) {
                                                        bool kontrol = false;

                                                        faizSec
                                                            .ziraatFaizSecenek(
                                                                dropdowndeger,
                                                                textKontrol,
                                                                dovizkapali);
                                                        faizSec.ingFaizSecenek(
                                                            dropdowndeger,
                                                            textKontrol,
                                                            dovizkapali);
                                                        faizSec
                                                            .enparaFaizSecenek(
                                                                dropdowndeger,
                                                                textKontrol,
                                                                dovizkapali);
                                                        faizSec.tebFaizSecenek(
                                                            dropdowndeger,
                                                            textKontrol,
                                                            dovizkapali);
                                                        faizSec.fibaFaizSecenek(
                                                            dropdowndeger,
                                                            textKontrol,
                                                            dovizkapali);
                                                        faizSec
                                                            .vakifBankFaizSecenek(
                                                                dropdowndeger,
                                                                textKontrol,
                                                                dovizkapali);
                                                        faizSec
                                                            .akBankFaizSecenek(
                                                                dropdowndeger,
                                                                textKontrol,
                                                                dovizkapali);
                                                        faizSec
                                                            .odeaBankFaizSecenek(
                                                                dropdowndeger,
                                                                textKontrol,
                                                                dovizkapali);
                                                        faizSec
                                                            .denizBankFaizSecenek(
                                                                dropdowndeger,
                                                                textKontrol,
                                                                dovizkapali);
                                                        var x = faizSec
                                                            .faizlerisirala();
                                                        if (dovizkapali) {
                                                          Hesapla hesap = Hesapla(
                                                              anapara: anapara,
                                                              vade: int.parse(
                                                                  dropdowndeger),
                                                              vergioran: 0.05,
                                                              bankalar:
                                                                  bankalar,
                                                              kurtahmin: "-",
                                                              usdalis: "-");
                                                          hesap.Hesap();
                                                        } else {
                                                          Hesapla hesap = Hesapla(
                                                              anapara: anapara,
                                                              vade: int.parse(
                                                                  dropdowndeger),
                                                              vergioran: 0.05,
                                                              bankalar:
                                                                  bankalar,
                                                              kurtahmin:
                                                                  kurtahmin,
                                                              usdalis:
                                                                  vadebaskurtahmin);
                                                          hesap.HesapDoviz();
                                                        }
                                                        kontrol = true;
                                                        if (kontrol) {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          SonucSayfasi(
                                                                            dovizkapali:
                                                                                dovizkapali,
                                                                            bankalar:
                                                                                bankalar,
                                                                            anapara:
                                                                                textKontrol.text,
                                                                            vade:
                                                                                dropdowndeger,
                                                                            siralanmisfaiz:
                                                                                x,
                                                                          )));
                                                        }
                                                      } else {
                                                        AlertController.show(
                                                            "Eksik Bilgi!",
                                                            "Lütfen vade seçimi yapınız.",
                                                            TypeAlert.warning);
                                                      }
                                                    } else {
                                                      AlertController.show(
                                                          "Eksik Bilgi!",
                                                          "Lütfen anapara ve vade seçimi yapınız.",
                                                          TypeAlert.warning);
                                                    }
                                                  },
                                                  child: Text("Hesapla!"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors.green,
                                                    onPrimary: Colors.white,
                                                    shadowColor:
                                                        Colors.greenAccent,
                                                    elevation: 3,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        18.0)),
                                                    minimumSize: Size(105, 50),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                         
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Container(
                                    height: MediaQuery.of(context).size.height*0.4,
                                    decoration: BoxDecoration(
                                        color: Color(0XffF3F4F4),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.indigo.shade300.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            offset: Offset(0, 3),
                                          )
                                        ]),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                               EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Kur Korumalı TL Mevduat\nHesabı Kazancı Hesapla",
                                                style: GoogleFonts.poppins(color: Colors.blueGrey.shade400,fontSize: 15,fontWeight: FontWeight.w600),
                                              ),
                                              Flexible(
                                                child: AnimatedToggleSwitch<
                                                    bool>.dual(
                                                  current: dovizkapali,
                                                  first: false,
                                                  second: true,
                                                  dif: 25,
                                                  height: 45,
                                                  onChanged: (b) {
                                                    setState(() {
                                                      dovizkapali = b;
                                                      if (dovizkapali) {
                                                        dropdowndeger2 =
                                                            "Vade Seçiniz (Gün)";
                                                        dropdowndeger =
                                                            "Vade Seçiniz (Gün)";
                                                        dropdownitemorj =
                                                            dropdownitem;
                                                        renkacik = Colors
                                                            .green.shade300;
                                                        renkapali =
                                                            Colors.red.shade300;
                                                        doviztextrenk =
                                                            Color(0XFF566573);
                                                      } else {
                                                        dropdowndeger2 =
                                                            "Vade Seçiniz (Gün)";
                                                        dropdowndeger =
                                                            "Vade Seçiniz (Gün)";
                                                        dropdownitemorj =
                                                            dropdownitem2;
                                                        renkacik = Colors.green;
                                                        renkapali = Colors.red;
                                                        doviztextrenk =
                                                            Color(0XFF2c3e50);
                                                      }
                                                    });
                                                  },
                                                  colorBuilder: (b) => b
                                                      ? Colors.red
                                                      : Colors.green,
                                                  iconBuilder:
                                                      (b, size, active) => b
                                                          ? Icon(Icons.block)
                                                          : Icon(Icons.check),
                                                  textBuilder:
                                                      (b, size, active) => b
                                                          ? Center(
                                                              child: Text(
                                                              'Kapalı',
                                                              style: GoogleFonts.poppins(),
                                                            ))
                                                          : Center(
                                                              child: Text(
                                                                  'Açık',
                                                                  style: GoogleFonts.poppins(),
                                                ),
                                              ),
                                          ))],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Vade başında/sonunda Dolar(USD) kuru tahmininiz?",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Vade Başında",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 45,
                                              child: FloatingActionButton(
                                                heroTag: "eksibtnbas",
                                                backgroundColor: renkapali,
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  if (!dovizkapali) {
                                                    setState(() {
                                                      double tahmin =
                                                          double.parse(
                                                              vadebaskurtahmin);
                                                      if (1 < tahmin) {
                                                        double a = double.parse(
                                                                vadebaskurtahmin) -
                                                            0.1;
                                                        vadebaskurtahmin = a
                                                            .toStringAsFixed(1);
                                                      }
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Text(
                                              vadebaskurtahmin,
                                              style: TextStyle(
                                                  color: doviztextrenk,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Container(
                                              height: 45,
                                              child: FloatingActionButton(
                                                heroTag: "artibtnbas",
                                                backgroundColor: renkacik,
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  if (!dovizkapali) {
                                                    double tahmin =
                                                        double.parse(
                                                            vadebaskurtahmin);
                                                    double kurtahmin2 =
                                                        double.parse(kurtahmin);
                                                    setState(() {
                                                      if (tahmin < kurtahmin2) {
                                                        double a = double.parse(
                                                                vadebaskurtahmin) +
                                                            0.1;
                                                        vadebaskurtahmin = a
                                                            .toStringAsFixed(1);
                                                      }
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Vade Sonunda",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 45,
                                              child: FloatingActionButton(
                                                heroTag: "eksibtn",
                                                backgroundColor: renkapali,
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  if (!dovizkapali) {
                                                    setState(() {
                                                      double tahmin =
                                                          double.parse(
                                                              kurtahmin);
                                                      if (1 < tahmin) {
                                                        double a = double.parse(
                                                                kurtahmin) -
                                                            0.1;
                                                        kurtahmin = a
                                                            .toStringAsFixed(1);
                                                      }
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Text(
                                              kurtahmin,
                                              style: TextStyle(
                                                  color: doviztextrenk,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Container(
                                              height: 45,
                                              child: FloatingActionButton(
                                                heroTag: "artibtn",
                                                backgroundColor: renkacik,
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  if (!dovizkapali) {
                                                    double usdmax =
                                                        double.parse(usdalis) +
                                                            10;
                                                    double tahmin =
                                                        double.parse(kurtahmin);
                                                    setState(() {
                                                      if (tahmin < usdmax) {
                                                        double a = double.parse(
                                                                kurtahmin) +
                                                            0.1;
                                                        kurtahmin = a
                                                            .toStringAsFixed(1);
                                                      }
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                         
                                          thickness: 0.5,
                                          endIndent: 0,
                                          color: Colors.black,
                                        ),
                                        Text(
                                          "$tarih Güncel Döviz Kurları",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Dolar(USD) => Alış: " +
                                              double.parse(kurlar[0].usdalis).toStringAsFixed(2) +
                                              "     Satış: " +
                                              double.parse(kurlar[0].usdsatis).toStringAsFixed(2),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(color: Colors.blueGrey,fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "Euro(EUR) => Alış: " +
                                              double.parse(kurlar[0].euroalis).toStringAsFixed(2) +
                                              "     Satış: " +
                                              double.parse(kurlar[0].eurosatis).toStringAsFixed(2),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(color: Colors.blueGrey,fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            Center(
                                child: Text(
                              "MeoSoftware",
                              style: GoogleFonts.kaushanScript(
                                textStyle: TextStyle(fontSize: 17),
                              ),
                            )),
                          ],
                        ),
                      )),
          );
  }
}

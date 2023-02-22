import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mevduatfaiz_hesapla/models/bankmodels.dart';
import 'package:in_app_review/in_app_review.dart';


class SonucSayfasi extends StatefulWidget {
  const SonucSayfasi(
      {Key? key,
      required this.bankalar,
      required this.anapara,
      required this.vade,
      required this.siralanmisfaiz,
      required this.dovizkapali,
     })
      : super(key: key);

  final String anapara, vade;
  final List<bankModels> bankalar;
  final Map<int, double> siralanmisfaiz;
  final bool dovizkapali;

  @override
  _SonucSayfasiState createState() => _SonucSayfasiState();
}

class _SonucSayfasiState extends State<SonucSayfasi> {
  int index2 = 0;
  final InAppReview inAppReview = InAppReview.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          title: Text(
          "Sonuçlar",
          style: GoogleFonts.kaushanScript(
                textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
        centerTitle: true,
        actions: [
         TextButton(onPressed: () {
           inAppReview.openStoreListing(appStoreId: 'com.meofaiz_mevduat');
         }, child: Row(
           children: [
             Text("Bize oy verin",style: TextStyle(color: Colors.white),),
             Icon(Icons.star,color: Colors.yellow)
           ],
         ))
        ],
      ),
      body: ListView.builder(
        addAutomaticKeepAlives: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Center(
                child: Text(
              "MeoSoftware",
              style: GoogleFonts.kaushanScript(
                textStyle: TextStyle(fontSize: 17),
              ),
            )
            );
          }
          /*
          if (index == 1) {
            return Center(
                child: Container(
              child: AdWidget(
                ad: this.widget.ad,
              ),
              width: this.widget.ad.size.width.toDouble(),
              height: this.widget.ad.size.height.toDouble(),
              alignment: Alignment.topCenter,
            ));
          }*/
          
          index = index - 1;
          if (this.widget.bankalar[index].faizoran != "-") {
            index = this.widget.siralanmisfaiz.keys.elementAt(index2);
            index2++;
          }
          return SonucWidget(
            dovizkapali: this.widget.dovizkapali,
            netkazanc: this.widget.bankalar[index].netkazanc,
            faizoran: this.widget.bankalar[index].faizoran,
            resimurl: this.widget.bankalar[index].resimurl,
            hesapadi: this.widget.bankalar[index].hesapadi,
            hesapadidoviz: this.widget.bankalar[index].hesapadidoviz,
            aciklama: this.widget.bankalar[index].aciklama,
            aciklamadoviz: this.widget.bankalar[index].aciklamadoviz,
            anapara: this.widget.anapara,
            vade: this.widget.vade,
            toplampara: this.widget.bankalar[index].toplampara,
            netkazanctextyazi: this.widget.bankalar[index].netkazanctextyazi,
            vadebasdolar: this.widget.bankalar[index].vadebasdolar,
            vadesondolar: this.widget.bankalar[index].vadesontahmindolar,
            kurfarki: this.widget.bankalar[index].kurfarki,
            faizgetirisi: this.widget.bankalar[index].faizgetirisi,
          );
        },
      ),
    );
  }
}

class SonucWidget extends StatefulWidget {
  SonucWidget({
    Key? key,
    required this.dovizkapali,
    required this.netkazanc,
    required this.faizoran,
    required this.resimurl,
    required this.hesapadi,
    required this.hesapadidoviz,
    required this.aciklama,
    required this.aciklamadoviz,
    required this.anapara,
    required this.vade,
    required this.toplampara,
    required this.netkazanctextyazi,
    required this.vadebasdolar,
    required this.vadesondolar,
    required this.kurfarki,
    required this.faizgetirisi,
  }) : super(key: key);

  String netkazanc,
      faizoran,
      resimurl,
      hesapadi,
      hesapadidoviz,
      aciklama,
      aciklamadoviz,
      anapara,
      vade,
      toplampara,
      netkazanctextyazi,
      vadebasdolar,
      vadesondolar,
      kurfarki,
      faizgetirisi;
  final bool dovizkapali;
  Color red = Colors.red;
  Color green = Colors.green;
  late Color renkurfarki;
  late Color renkfaizgetirisi;
  @override
  State<SonucWidget> createState() => _SonucWidgetState();
}

class _SonucWidgetState extends State<SonucWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!widget.dovizkapali) {
      widget.aciklama = widget.aciklamadoviz;
      widget.hesapadi = widget.hesapadidoviz;
    }
    if (!widget.dovizkapali && widget.faizoran != "-") {
      if (double.parse(widget.kurfarki) > double.parse(widget.faizgetirisi)) {
        widget.renkurfarki = widget.green;
        widget.renkfaizgetirisi = widget.red;
      } else {
        widget.renkurfarki = widget.red;
        widget.renkfaizgetirisi = widget.green;
      }
    } else {
      widget.renkurfarki = Colors.black;
      widget.renkfaizgetirisi = Colors.black;
    }

    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 3),
              )
            ]),
        child: ExpansionTileCard(
          subtitle: Column(
            children: [
              Divider(
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${widget.netkazanctextyazi}",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  Text(
                    "${widget.netkazanc}",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          title: Column(
            children: [
              Text(
                "${widget.hesapadi}",
                textAlign: TextAlign.center,
              ),
              Divider(
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Faiz: ",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "${widget.faizoran}",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          leading: Container(
            height: double.infinity,
            child: Image.asset(
              "${widget.resimurl}",
              alignment: Alignment.center,
              width: 130,
              height: double.infinity,
            ),
          ),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Column(
                  children: [
                    Divider(
                      thickness: 1,
                    ),
                    Text(
                      """${widget.aciklama}""",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Center(
              child: Text(
                "Mevduat Hesabı Bilgileri",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: <Widget>[
                    Text("Anapara",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('${widget.anapara}',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16)),
                  ],
                ),
                Column(
                  children: [
                    Text("Vade (Gün)",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('${widget.vade}',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16)),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Vade Sonu Net Bakiye",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text(
                      '${widget.toplampara} TL',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            Center(
              child: Text(
                "Kur Korumalı TL Vadeli Mevduat Hesabı Bilgileri",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: <Widget>[
                        Text("Vade Başı Dolar Kuru",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text('${widget.vadebasdolar}',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Vade Sonu Dolar Kuru",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text('${widget.vadesondolar}',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Kur Farkı",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Text(
                              '${widget.kurfarki} TL',
                              style: TextStyle(
                                  color: widget.renkurfarki,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Faiz Getirisi",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Text(
                              '${widget.faizgetirisi} TL',
                              style: TextStyle(
                                  color: widget.renkfaizgetirisi,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class bankModels {
 late String adi;
 late String hesapadi;
 late String hesapadidoviz;
 late String resimurl;
 late String anasayfatlkur;
 late String anasayfadovizkur;
 late String anasayfadolarkur;
 late String aciklama;
 late String aciklamadoviz;
 late String faizoran;
 late String netkazanc;
 late String toplampara;
 late String faizgetirisi;
 late String kurfarki;
 late String vadebasdolar;
 late String vadesontahmindolar;
 late String netkazanctextyazi;

  bankModels(
      {required this.adi,
      required this.hesapadi,
      required this.hesapadidoviz,
      required this.resimurl,
      required this.anasayfatlkur,
      required this.anasayfadovizkur,
      required this.anasayfadolarkur,
      required this.aciklama,
      required this.aciklamadoviz});

  bankModels.fromJson(Map<String, dynamic> json) {
    adi = json['adi'];
    hesapadi = json['hesapadi'];
    hesapadidoviz = json['hesapadidoviz'];
    resimurl = json['resimurl'];
    anasayfatlkur = json['anasayfatlkur'];
    anasayfadovizkur = json['anasayfadovizkur'];
    anasayfadolarkur = json['anasayfadolarkur'];
    aciklama = json['aciklama'];
    aciklamadoviz = json['aciklamadoviz'];
    faizoran="";
    netkazanc="";
    toplampara="";
    faizgetirisi="";
    kurfarki="";
    vadebasdolar="";
    vadesontahmindolar="";
    netkazanctextyazi="";

  }
}

class Bankalar {
  String adi;
  String hesapadi;
  String hesapadidoviz;
  String resimurl;
  String aciklama;
  String aciklamadoviz;
  String anasayfatlkur;
  String anasayfadovizkur;
  String anasayfadolarkur;
  String faizoran;
  String netkazanc;
  String toplampara;
  String netkazanctextyazi = "";
  String kurfarki;
  String faizgetirisi;
  String vadebasdolar;
  String vadesontahmindolar;

  Bankalar({
    required this.adi,
    required this.hesapadi,
    required this.hesapadidoviz,
    required this.resimurl,
    required this.aciklama,
    required this.aciklamadoviz,
    required this.anasayfatlkur,
    required this.anasayfadovizkur,
    required this.anasayfadolarkur,
    required this.faizoran,
    required this.netkazanc,
    required this.toplampara,
    required this.netkazanctextyazi,
    required this.kurfarki,
    required this.faizgetirisi,
    required this.vadebasdolar,
    required this.vadesontahmindolar,
  });
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mevduatfaiz_hesapla/models/bankmodels.dart';
import 'package:mevduatfaiz_hesapla/models/bankmodels.dart';
import 'package:mevduatfaiz_hesapla/services/faizoranlari.dart';

class FaizSec {
  FaizSec({required this.bankalar, required this.veri});
  List<bankModels> bankalar;
  Map veri;

  Map<int, double> faizlerisirala() {
    Map<int, double> siralanmisfaiz = {};
    for (int i = 0; i < bankalar.length; i++) {
      if (bankalar[i].faizoran != "-") {
        String stringfaiz =
            bankalar[i].faizoran.replaceAll(RegExp(r'^\D+|(?<=\d),(?=\d)'), '');
        double faiz = double.parse(stringfaiz);
        siralanmisfaiz[i] = faiz;
      }
    }
    
    var mapEntries = siralanmisfaiz.entries.toList()
      ..sort(((b, a) => a.value.compareTo(
          b.value))); //HashMap value değerini büyükten küçüğe sıralama
    siralanmisfaiz
      ..clear()
      ..addEntries(mapEntries);
    return siralanmisfaiz;
  }

  void ziraatFaizSecenek(String dropdowndeger,
      TextEditingController textKontrol, bool dovizkapali) {
    bankalar[0].netkazanctextyazi = "Net Kazanç: ";
    if (dovizkapali) {
      if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty) {
        String ziraatFaizSec = "tlmevfaiz$dropdowndeger";
        bankalar[0].faizoran = "%" + veri["Ziraat"][0][ziraatFaizSec];
      }
    } else {
      if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty) {
        String ziraatFaizSec = "doviztlmevfaiz$dropdowndeger";
        bankalar[0].faizoran = "%" + veri["Ziraat"][0][ziraatFaizSec];
      }
    }
  }

  void ingFaizSecenek(String dropdowndeger, TextEditingController textKontrol,
      bool dovizkapali) {
    double anapara =
        double.parse(textKontrol.text.replaceAll(new RegExp(r'[^0-9]'), ''));
    if (dovizkapali) {
      bankalar[1].netkazanctextyazi = "Net Kazanç: ";
      if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty &&
          anapara <= 2000000) {
        String? ingFaizSec;
        if (1000 <= anapara && anapara <= 4999) {
          ingFaizSec = "1-5tlmevfaiz$dropdowndeger";
          bankalar[1].faizoran = "%" + veri["ING Bank"][0][ingFaizSec];
        } else if (5000 <= anapara && anapara <= 9999) {
          ingFaizSec = "5-10tlmevfaiz$dropdowndeger";
          bankalar[1].faizoran = "%" + veri["ING Bank"][0][ingFaizSec];
        } else if (10000 <= anapara && anapara <= 74999) {
          ingFaizSec = "10-75tlmevfaiz$dropdowndeger";
          bankalar[1].faizoran = "%" + veri["ING Bank"][0][ingFaizSec];
        } else if (75000 <= anapara && anapara <= 249999) {
          ingFaizSec = "75-250tlmevfaiz$dropdowndeger";
          bankalar[1].faizoran = "%" + veri["ING Bank"][0][ingFaizSec];
        } else if (250000 <= anapara && anapara <= 499999) {
          ingFaizSec = "250-500tlmevfaiz$dropdowndeger";
          bankalar[1].faizoran = "%" + veri["ING Bank"][0][ingFaizSec];
        } else if (500000 <= anapara) {
          ingFaizSec = "500-tlmevfaiz$dropdowndeger";
          bankalar[1].faizoran = "%" + veri["ING Bank"][0][ingFaizSec];
        }
      } else {
        bankalar[1].faizoran = "-";
        bankalar[1].netkazanctextyazi = "";
        bankalar[1].netkazanc = "Maksimum üst limit\n2.000.000 TL'dir.";
      }
    } else {
      if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty &&
          5000 <= anapara) {
        String ingFaizSec = "doviztlmevfaiz$dropdowndeger";
        bankalar[1].netkazanctextyazi = "Net Kazanç: ";
        bankalar[1].faizoran = "%" + veri["ING Bank"][0][ingFaizSec];
      } else {
        bankalar[1].faizoran = "-";
        bankalar[1].netkazanctextyazi = "";
        bankalar[1].netkazanc = "Hesap açılış alt\nlimiti 5.000 TL'dir.";
      }
    }
  }

  void enparaFaizSecenek(String dropdowndeger,
      TextEditingController textKontrol, bool dovizkapali) {
    double anapara =
        double.parse(textKontrol.text.replaceAll(new RegExp(r'[^0-9]'), ''));
    if (dovizkapali) {
      bankalar[2].netkazanctextyazi = "Net Kazanç: ";
      if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty &&
          anapara < 2500000 && dropdowndeger !="55") {
        String? enparaFaizSec;
        if (1000 <= anapara && anapara <= 75000) {
          enparaFaizSec = "0-75tlmevfaiz$dropdowndeger";
          bankalar[2].faizoran = "%" + veri["Enpara"][0][enparaFaizSec];
        } else if ((75000 < anapara && anapara <= 250000)) {
          enparaFaizSec = "75-250tlmevfaiz$dropdowndeger";
          bankalar[2].faizoran = "%" + veri["Enpara"][0][enparaFaizSec];
        } else if ((250000 < anapara && anapara <= 750000)) {
          enparaFaizSec = "250-750tlmevfaiz$dropdowndeger";
          bankalar[2].faizoran = "%" + veri["Enpara"][0][enparaFaizSec];
        } else if ((750000 < anapara)) {
          enparaFaizSec = "750-tlmevfaiz$dropdowndeger";
          bankalar[2].faizoran = "%" + veri["Enpara"][0][enparaFaizSec];
        }
      } else if(dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty &&
          anapara < 2500000 && dropdowndeger =="55"){
        bankalar[2].faizoran = "-";
        bankalar[2].netkazanctextyazi = "";
        bankalar[2].netkazanc = "55 gün vade seçeneği\nbulunmamaktadır.";
      }else{
        bankalar[2].faizoran = "-";
        bankalar[2].netkazanctextyazi = "";
        bankalar[2].netkazanc = "Maksimum üst limit\n2.500.000 TL'dir.";
      }
    } else {
      if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty &&
          (dropdowndeger == "92" || dropdowndeger == "181")) {
        bankalar[2].netkazanctextyazi = "Net Kazanç: ";
        String? enparaFaizSec;
        double anapara = double.parse(
            textKontrol.text.replaceAll(new RegExp(r'[^0-9]'), ''));
        if (1000 <= anapara && anapara <= 75000) {
          enparaFaizSec = "0-75doviztlmevfaiz$dropdowndeger";
          bankalar[2].faizoran = "%" + veri["Enpara"][0][enparaFaizSec];
        } else if ((75000 < anapara && anapara <= 250000)) {
          enparaFaizSec = "75-250doviztlmevfaiz$dropdowndeger";
          bankalar[2].faizoran = "%" + veri["Enpara"][0][enparaFaizSec];
        } else if ((250000 < anapara && anapara <= 750000)) {
          enparaFaizSec = "250-750doviztlmevfaiz$dropdowndeger";
          bankalar[2].faizoran = "%" + veri["Enpara"][0][enparaFaizSec];
        } else if ((750000 < anapara)) {
          enparaFaizSec = "750-doviztlmevfaiz$dropdowndeger";
          bankalar[2].faizoran = "%" + veri["Enpara"][0][enparaFaizSec];
        }
      } else {
        bankalar[2].faizoran = "-";
        bankalar[2].netkazanctextyazi = "";
        bankalar[2].netkazanc = "92 ve 181 gün vade\nseçenekleri mevcuttur.";
      }
    }
  }

  void tebFaizSecenek(String dropdowndeger, TextEditingController textKontrol,
      bool dovizkapali) {
    double anapara =
        double.parse(textKontrol.text.replaceAll(new RegExp(r'[^0-9]'), ''));
    if (dovizkapali) {
      if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty &&
          3000 <= anapara &&
          anapara < 1000000) {
        bankalar[3].netkazanctextyazi = "Net Kazanç: ";
        String tebfaizSec = "tlmevfaiz$dropdowndeger";
        bankalar[3].faizoran = "%" + veri["CEPTETEB"][0][tebfaizSec];
      } else if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty &&
          1000000 < anapara) {
        bankalar[3].faizoran = "-";
        bankalar[3].netkazanctextyazi = "";
        bankalar[3].netkazanc = "Maksimum üst limit\n1.000.000 TL'dir.";
      } else if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty &&
          anapara < 3000) {
        bankalar[3].faizoran = "-";
        bankalar[3].netkazanctextyazi = "";
        bankalar[3].netkazanc = "Hesap açılış alt\nlimiti 3.000 TL'dir.";
      }
    } else {
      if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty &&
          (20000 <= anapara)) {
        bankalar[3].netkazanctextyazi = "Net Kazanç: ";
        String? tebFaizSec;

        if (20000 <= anapara && anapara <= 249999) {
          tebFaizSec = "20-250doviztlmevfaiz$dropdowndeger";
          bankalar[3].faizoran = "%" + veri["CEPTETEB"][0][tebFaizSec];
        } else if ((250000 <= anapara && anapara <= 499999)) {
          tebFaizSec = "250-500doviztlmevfaiz$dropdowndeger";
          bankalar[3].faizoran = "%" + veri["CEPTETEB"][0][tebFaizSec];
        } else if ((500000 <= anapara)) {
          tebFaizSec = "500-doviztlmevfaiz$dropdowndeger";
          bankalar[3].faizoran = "%" + veri["CEPTETEB"][0][tebFaizSec];
        }
      } else {
        bankalar[3].faizoran = "-";
        bankalar[3].netkazanctextyazi = "";
        bankalar[3].netkazanc = "Hesap açılış alt\nlimiti 20.000 TL'dir.";
      }
    }
  }

  void fibaFaizSecenek(String dropdowndeger, TextEditingController textKontrol,
      bool dovizkapali) {
    double anapara =
        double.parse(textKontrol.text.replaceAll(new RegExp(r'[^0-9]'), ''));
    if (dovizkapali) {
      if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty &&
          anapara < 1000000) {
        bankalar[4].netkazanctextyazi = "Net Kazanç: ";
        String? fibaFaizSec;
        if (1000 <= anapara && anapara <= 9999) {
          fibaFaizSec = "1-10tlmevfaiz$dropdowndeger";
          bankalar[4].faizoran = "%" + veri["Fiba Banka"][0][fibaFaizSec];
        } else if ((10000 <= anapara && anapara <= 24999)) {
          fibaFaizSec = "10-25tlmevfaiz$dropdowndeger";
          bankalar[4].faizoran = "%" + veri["Fiba Banka"][0][fibaFaizSec];
        } else if ((25000 <= anapara && anapara <= 49999)) {
          fibaFaizSec = "25-50tlmevfaiz$dropdowndeger";
          bankalar[4].faizoran = "%" + veri["Fiba Banka"][0][fibaFaizSec];
        } else if ((50000 <= anapara && anapara <= 99999)) {
          fibaFaizSec = "50-100tlmevfaiz$dropdowndeger";
          bankalar[4].faizoran = "%" + veri["Fiba Banka"][0][fibaFaizSec];
        } else if ((100000 <= anapara && anapara <= 249999)) {
          fibaFaizSec = "100-250tlmevfaiz$dropdowndeger";
          bankalar[4].faizoran = "%" + veri["Fiba Banka"][0][fibaFaizSec];
        } else if ((250000 <= anapara && anapara <= 499999)) {
          fibaFaizSec = "250-500tlmevfaiz$dropdowndeger";
          bankalar[4].faizoran = "%" + veri["Fiba Banka"][0][fibaFaizSec];
        } else if ((500000 <= anapara)) {
          fibaFaizSec = "500-tlmevfaiz$dropdowndeger";
          bankalar[4].faizoran = "%" + veri["Fiba Banka"][0][fibaFaizSec];
        }
      } else {
        bankalar[4].faizoran = "-";
        bankalar[4].netkazanctextyazi = "";
        bankalar[4].netkazanc = "Maksimum üst limit\n1.000.000 TL'dir.";
      }
    } else {
      if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty &&
          (10000 <= anapara)) {
        bankalar[4].netkazanctextyazi = "Net Kazanç: ";
        String? fibaFaizSec;

        if (10000 <= anapara && anapara <= 499999) {
          fibaFaizSec = "10-500doviztlmevfaiz$dropdowndeger";
          bankalar[4].faizoran = "%" + veri["Fiba Banka"][0][fibaFaizSec];
        } else if ((500000 <= anapara)) {
          fibaFaizSec = "500-doviztlmevfaiz$dropdowndeger";
          bankalar[4].faizoran = "%" + veri["CEPTETEB"][0][fibaFaizSec];
        }
      } else {
        bankalar[4].faizoran = "-";
        bankalar[4].netkazanctextyazi = "";
        bankalar[4].netkazanc = "Hesap açılış alt\nlimiti 10.000 TL'dir.";
      }
    }
  }

  void vakifBankFaizSecenek(String dropdowndeger,
      TextEditingController textKontrol, bool dovizkapali) {
    double anapara =
        double.parse(textKontrol.text.replaceAll(new RegExp(r'[^0-9]'), ''));
    if (dovizkapali) {
      if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty &&
          25000 <= anapara &&
          anapara <= 5000000 && dropdowndeger != "181") {
        bankalar[5].netkazanctextyazi = "Net Kazanç: ";
        String vakifFaizSec;
        if (25000 <= anapara && anapara <= 100000) {
          vakifFaizSec = "25-100tlmevfaiz$dropdowndeger";
          bankalar[5].faizoran = "%" + veri["VakifBank"][0][vakifFaizSec];
        } else if ((100001 <= anapara && anapara <= 500000)) {
          vakifFaizSec = "100-500tlmevfaiz$dropdowndeger";
          bankalar[5].faizoran = "%" + veri["VakifBank"][0][vakifFaizSec];
        }else if ((500001 <= anapara)) {
          vakifFaizSec = "500-tlmevfaiz$dropdowndeger";
          bankalar[5].faizoran = "%" + veri["VakifBank"][0][vakifFaizSec];
        }
      } else if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty &&
          5000000 < anapara &&
          dropdowndeger !="181") {
        bankalar[5].faizoran = "-";
        bankalar[5].netkazanctextyazi = "";
        bankalar[5].netkazanc = "Maksimum üst limit\n5.000.000 TL'dir.";
      }else if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty &&
          anapara < 25000 &&
          dropdowndeger !="181") {
        bankalar[5].faizoran = "-";
        bankalar[5].netkazanctextyazi = "";
        bankalar[5].netkazanc =
            "Kampanya hesap açılış\nalt limiti 25.000 TL’dir.";
      } else {
        bankalar[5].faizoran = "-";
        bankalar[5].netkazanctextyazi = "";
        bankalar[5].netkazanc = "181 gün vade seçeneği\nbulunmamaktadır.";
      }
    } else {
      if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty) {
        bankalar[5].netkazanctextyazi = "Tahmini\nNet Kazanç: ";
        String vakifFaizSec = "tahmindoviztlmevfaiz$dropdowndeger";
        bankalar[5].faizoran =
            "(Minimum) %" + veri["VakifBank"][0][vakifFaizSec];
      }
    }
  }

  void akBankFaizSecenek(String dropdowndeger,
      TextEditingController textKontrol, bool dovizkapali) {
    double anapara =
        double.parse(textKontrol.text.replaceAll(new RegExp(r'[^0-9]'), ''));
    if (dovizkapali) {
      if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty &&
          anapara <= 1000000) {
        bankalar[6].netkazanctextyazi = "Net Kazanç: ";
        String akFaizSec;
        if (1000 <= anapara && anapara <= 9999) {
          akFaizSec = "1-10tlmevfaiz$dropdowndeger";
          bankalar[6].faizoran = "%" + veri["Akbank"][0][akFaizSec];
        } else if ((10000 <= anapara && anapara <= 99999)) {
          akFaizSec = "10-100tlmevfaiz$dropdowndeger";
          bankalar[6].faizoran = "%" + veri["Akbank"][0][akFaizSec];
        } else if ((100000 <= anapara && anapara <= 249999)) {
          akFaizSec = "100-250tlmevfaiz$dropdowndeger";
          bankalar[6].faizoran = "%" + veri["Akbank"][0][akFaizSec];
        } else if ((250000 <= anapara && anapara <= 499999)) {
          akFaizSec = "250-500tlmevfaiz$dropdowndeger";
          bankalar[6].faizoran = "%" + veri["Akbank"][0][akFaizSec];
        } else {
          akFaizSec = "500-tlmevfaiz$dropdowndeger";
          bankalar[6].faizoran = "%" + veri["Akbank"][0][akFaizSec];
        }
      } else {
        bankalar[6].faizoran = "-";
        bankalar[6].netkazanctextyazi = "";
        bankalar[6].netkazanc = "Maksimum üst limit\n1.000.000 TL'dir.";
      }
    } else {
      if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty &&
          10000 <= anapara) {
        bankalar[6].netkazanctextyazi = "Net Kazanç: ";
        String akFaizSec;
        if (10000 <= anapara && anapara <= 249999) {
          akFaizSec = "10-250doviztlmevfaiz$dropdowndeger";
          bankalar[6].faizoran = "%" + veri["Akbank"][0][akFaizSec];
        } else if ((250000 <= anapara && anapara <= 499999)) {
          akFaizSec = "250-500doviztlmevfaiz$dropdowndeger";
          bankalar[6].faizoran = "%" + veri["Akbank"][0][akFaizSec];
        } else if ((500000 <= anapara)) {
          akFaizSec = "500-doviztlmevfaiz$dropdowndeger";
          bankalar[6].faizoran = "%" + veri["Akbank"][0][akFaizSec];
        }
      } else {
        bankalar[6].faizoran = "-";
        bankalar[6].netkazanctextyazi = "";
        bankalar[6].netkazanc = "Hesap açılış alt\nlimiti 10.000 TL'dir.";
      }
    }
  }

  void odeaBankFaizSecenek(String dropdowndeger,
      TextEditingController textKontrol, bool dovizkapali) {
    double anapara =
        double.parse(textKontrol.text.replaceAll(new RegExp(r'[^0-9]'), ''));
    if (dovizkapali) {
      if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty &&
          2000 <= anapara &&
          anapara <= 1000000 &&
          dropdowndeger != "181") {
        bankalar[7].netkazanctextyazi = "Net Kazanç: ";
        String odeafaizSec = "2-tlmevfaiz$dropdowndeger";
        bankalar[7].faizoran = "%" + veri["OdeaBank"][0][odeafaizSec];
      } else if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty &&
          1000000 < anapara &&
          dropdowndeger != "181") {
        bankalar[7].faizoran = "-";
        bankalar[7].netkazanctextyazi = "";
        bankalar[7].netkazanc = "Maksimum üst limit\n1.0000.00 TL'dir.";
      } else if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty &&
          anapara < 2000 &&
          dropdowndeger != "181") {
        bankalar[7].faizoran = "-";
        bankalar[7].netkazanctextyazi = "";
        bankalar[7].netkazanc = "Hesap açılış alt\nlimiti 2.000 TL'dir.";
      } else {
        bankalar[7].faizoran = "-";
        bankalar[7].netkazanctextyazi = "";
        bankalar[7].netkazanc = "181 gün vade seçeneği\nbulunmamaktadır.";
      }
    } else {
      if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty &&
          (10000 <= anapara)) {
        bankalar[7].netkazanctextyazi = "Net Kazanç: ";

        String odeaFaizSec = "doviztlmevfaiz$dropdowndeger";
        bankalar[7].faizoran = "%" + veri["OdeaBank"][0][odeaFaizSec];
      } else {
        bankalar[7].faizoran = "-";
        bankalar[7].netkazanctextyazi = "";
        bankalar[7].netkazanc = "Hesap açılış alt\nlimiti 10.000 TL'dir.";
      }
    }
  }

  void denizBankFaizSecenek(String dropdowndeger,
      TextEditingController textKontrol, bool dovizkapali) {
    double anapara =
        double.parse(textKontrol.text.replaceAll(new RegExp(r'[^0-9]'), ''));
    if (dovizkapali) {
      if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty &&
          5000 <= anapara &&
          anapara <= 1000000) {
        bankalar[8].netkazanctextyazi = "Net Kazanç: ";
        String? denizbankfaizSec;
        if (5000 <= anapara && anapara <= 24999) {
          denizbankfaizSec = "5-25tlmevfaiz$dropdowndeger";
          bankalar[8].faizoran = "%"+veri["DenizBank"][0][denizbankfaizSec];
        } else if ((25000 <= anapara && anapara <= 99999)) {
          denizbankfaizSec = "25-100tlmevfaiz$dropdowndeger";
          bankalar[8].faizoran = "%"+veri["DenizBank"][0][denizbankfaizSec];
        }else if ((100000 <= anapara && anapara <= 499999)) {
          denizbankfaizSec = "100-500tlmevfaiz$dropdowndeger";
          bankalar[8].faizoran = "%"+veri["DenizBank"][0][denizbankfaizSec];
        }else if ((500000 <= anapara)) {
          denizbankfaizSec = "500-tlmevfaiz$dropdowndeger";
          bankalar[8].faizoran = "%"+veri["DenizBank"][0][denizbankfaizSec];
        }
      } else if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty &&
          1000000 < anapara) {
        bankalar[8].faizoran = "-";
        bankalar[8].netkazanctextyazi = "";
        bankalar[8].netkazanc = "Maksimum üst limit\n1.0000.00 TL'dir.";
      } else {
        bankalar[8].faizoran = "-";
        bankalar[8].netkazanctextyazi = "";
        bankalar[8].netkazanc =
            "Kampanya hesap açılış\nalt limiti 5.000 TL’dir.";
      }
    } else {
      if (dropdowndeger != "Vade Seçiniz (Gün)" &&
          textKontrol.text.isNotEmpty) {
        bankalar[8].netkazanctextyazi = "Net Kazanç: ";

        String denizbankFaizSec;
        if (1000 <= anapara && anapara <= 249999) {
          denizbankFaizSec = "1-250doviztlmevfaiz$dropdowndeger";
          bankalar[8].faizoran = "%" + veri["DenizBank"][0][denizbankFaizSec];
        } else if ((250000 <= anapara && anapara <= 499999)) {
          denizbankFaizSec = "250-500doviztlmevfaiz$dropdowndeger";
          bankalar[8].faizoran = "%" + veri["DenizBank"][0][denizbankFaizSec];
        } else if ((500000 <= anapara)) {
          denizbankFaizSec = "500-doviztlmevfaiz$dropdowndeger";
          bankalar[8].faizoran = "%" + veri["DenizBank"][0][denizbankFaizSec];
        }
      }
    }
  }
}

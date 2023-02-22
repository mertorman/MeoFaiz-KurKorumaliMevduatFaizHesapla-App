import 'dart:math';

import 'package:intl/intl.dart';
import 'package:mevduatfaiz_hesapla/models/bankmodels.dart';

class Hesapla {
  final double anapara;
  final int vade;
  final double vergioran;
  List<bankModels> bankalar;
  final String usdalis;
  final String kurtahmin;

  Hesapla(
      {required this.anapara,
      required this.vade,
      required this.vergioran,
      required this.bankalar,
      required this.usdalis,
      required this.kurtahmin});

  void Hesap() {
    final currencyFormatter = NumberFormat('#,##0.00', 'ID');
    for (int i = 0; i < bankalar.length; i++) {
      if (bankalar[i].faizoran != "-") {
        double faizoran = double.parse(bankalar[i]
            .faizoran
            .replaceAll(RegExp(r'^\D+|(?<=\d),(?=\d)'), ''));

        double kazanc = (anapara * faizoran * vade) / 36500;
        double net = kazanc - (kazanc * vergioran);
        double toplam = anapara + net;
        String toplamkazanc = currencyFormatter.format(toplam);
        // String toplamkazanc = toplam.toStringAsFixed(2);
        String netkazanc = currencyFormatter.format(net) + " TL";
        // String netkazanc = net.toStringAsFixed(2) + " TL";
        bankalar[i].netkazanc = netkazanc;
        bankalar[i].toplampara = toplamkazanc;
        bankalar[i].faizgetirisi = "-";
        bankalar[i].kurfarki = "-";
        bankalar[i].vadebasdolar = "-";
        bankalar[i].vadesontahmindolar = "-";
      } else {
        bankalar[i].toplampara = "-";
        bankalar[i].faizgetirisi = "-";
        bankalar[i].kurfarki = "-";
        bankalar[i].vadebasdolar = "-";
        bankalar[i].vadesontahmindolar = "-";
      }
    }
  }

  void HesapDoviz() {
    final currencyFormatter = NumberFormat('#,##0.00', 'ID');
    double tahminkur = double.parse(kurtahmin);
    String usd = double.parse(usdalis).toStringAsFixed(1);
    double usd2 = double.parse(usd);
    double kuryuzdeartis1 = tahminkur - usd2;
    double kuryuzdeartis = kuryuzdeartis1 / usd2;
    for (int i = 0; i < bankalar.length; i++) {
      if (bankalar[i].faizoran != "-") {
        double faizoran = double.parse(bankalar[i]
            .faizoran
            .replaceAll(RegExp(r'^\D+|(?<=\d),(?=\d)'), ''));
        bankalar[i].vadebasdolar = usd2.toStringAsFixed(1);
        bankalar[i].vadesontahmindolar = kurtahmin;
        double kazanc = (anapara * faizoran * vade) / 36500;

        String vadelinet = kazanc.toStringAsFixed(2);
         
        double doviznetkazanc = (kuryuzdeartis * anapara);
        String doviznet = doviznetkazanc.toStringAsFixed(2);
        bankalar[i].faizgetirisi = vadelinet;

        if (doviznetkazanc >= kazanc && (tahminkur - usd2 > 0)) {
          bankalar[i].netkazanc = doviznet;
          double toplam = anapara + doviznetkazanc;
          String toplamkazanc = currencyFormatter.format(toplam);
          // String toplamkazanc = toplam.toStringAsFixed(2);
          bankalar[i].toplampara = toplamkazanc;
          bankalar[i].kurfarki = doviznet;
        } else if (doviznetkazanc < kazanc && (tahminkur - usd2 > 0)) {
          bankalar[i].netkazanc = vadelinet;
          double toplam = anapara + kazanc;
          String toplamkazanc = currencyFormatter.format(toplam);
          //String toplamkazanc = toplam.toStringAsFixed(2);
          bankalar[i].toplampara = toplamkazanc;
          bankalar[i].kurfarki = doviznet;
        } else {
          bankalar[i].netkazanc = vadelinet;
          double toplam = anapara + kazanc;
          String toplamkazanc = currencyFormatter.format(toplam);
          //String toplamkazanc = toplam.toStringAsFixed(2);
          bankalar[i].toplampara = toplamkazanc;
          bankalar[i].kurfarki = "0";
        }
      } else {
        bankalar[i].kurfarki = "-";
        bankalar[i].faizgetirisi = "-";
        bankalar[i].toplampara = "-";
        bankalar[i].vadebasdolar = "-";
        bankalar[i].vadesontahmindolar = "-";
      }
    }
  }
}

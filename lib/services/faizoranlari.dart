import 'dart:convert';
import 'dart:io';
// ignore: avoid_web_libraries_in_flutter
import 'package:http/http.dart';
import 'package:mevduatfaiz_hesapla/constant/application_constants.dart';
import '../models/bankmodels.dart';
import 'package:http/http.dart' as http;

class FaizOranlari {
  // List<Bankalar> bankalar = [];
  List<bankModels> bankalar = [];
  Map<String, dynamic> veri = {};
  Future<void> faizGetir() async {
    Response res = await http.get(Uri.parse(ApplicationConstant.faizURL));
    if (res.statusCode == HttpStatus.ok) {
      veri = jsonDecode(utf8.decode(res.bodyBytes));
      final _datas = veri["Bankalar"] as List;
      bankalar = _datas.map((e) => bankModels.fromJson(e)).toList();
  }
    /*
    veri = jsonDecode(utf8.decode(res.bodyBytes));
    veri["Bankalar"].forEach((element) {
      Bankalar model = Bankalar(
        adi: element["adi"],
        hesapadi: element["hesapadi"],
        hesapadidoviz: element["hesapadidoviz"],
        resimurl: element["resimurl"],
        aciklama: element["aciklama"],
        aciklamadoviz: element["aciklamadoviz"],
        anasayfatlkur: element["anasayfatlkur"],
        anasayfadovizkur: element["anasayfadovizkur"],
        anasayfadolarkur: element["anasayfadolarkur"],
        faizoran: "",
        netkazanc: "",
        toplampara: "",
        faizgetirisi: "",
        kurfarki: "",
        vadebasdolar: "",
        vadesontahmindolar: "",
        netkazanctextyazi: "",
      );
      //  bankalar.add(model);
    });
    */
  }
}

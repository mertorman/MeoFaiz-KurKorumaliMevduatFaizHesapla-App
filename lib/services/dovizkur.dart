import 'dart:convert';
import 'package:http/http.dart';
import 'package:mevduatfaiz_hesapla/constant/application_constants.dart';
import '../models/dovizmodel.dart';
import 'package:http/http.dart' as http;

class DovizApi {
  List<DovizModel> kur = [];
  Future<void> DovizGetir() async {
    Response res = await http.get(Uri.parse(ApplicationConstant.dovizURL));
    Map<String, dynamic> veri = jsonDecode(res.body);
    String usdsatis = veri["USD"]["satis"];
    usdsatis = usdsatis.replaceAll(RegExp(r"[^\d.]+"), "");

    DovizModel model = DovizModel(
        usdalis: veri["USD"]["alis"],
        usdsatis: usdsatis,
        usdegisim: veri["USD"]["degisim"],
        euroalis: veri["EUR"]["alis"],
        eurosatis: veri["EUR"]["satis"],
        eurodegisim: veri["EUR"]["degisim"]);
    kur.add(model);
  }
}

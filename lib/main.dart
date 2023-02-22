import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mevduatfaiz_hesapla/constant/application_constants.dart';
import 'package:mevduatfaiz_hesapla/views/anasayfa.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Hive.initFlutter(); //Karşılama ekranının sadece uygulamaya ilk girişte açılması için Hive kullanıyoruz.
  await Hive.openBox('');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: ApplicationConstant.color),
      builder: (context, child) {
        child = Stack(
          children: [child!, DropdownAlert()],
        );
        child = ResponsiveWrapper.builder(
          child,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
        );
        return child;
      },
      home: Anasayfa(),
    );
  }


}

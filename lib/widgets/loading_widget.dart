import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class YuklemeEkrani extends StatefulWidget {
  const YuklemeEkrani({Key? key}) : super(key: key);

  @override
  _YuklemeEkraniState createState() => _YuklemeEkraniState();
}

class _YuklemeEkraniState extends State<YuklemeEkrani> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF42424C),
      body: Column(
        children: [
          Expanded(
              child: Lottie.asset(
            "assets/loading7.json",
          ))
        ],
      ),
    );
  }
}

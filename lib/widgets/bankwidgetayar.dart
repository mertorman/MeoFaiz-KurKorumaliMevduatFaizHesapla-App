import 'package:flutter/material.dart';

class bankyazilar extends StatelessWidget {
  final String faizorantl, faizorandoviz,faizoranusd; //faizoraneuro;
  const bankyazilar({
    Key? key,
    required this.faizorantl,
    required this.faizorandoviz,
    required this.faizoranusd,
    //required this.faizoraneuro
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        children: [
          Row(
            children: [
              RichText(
                  text: TextSpan(children: [
              const  TextSpan(
                    text: "\u2022TL Hesabı Faiz Oranı: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 17)),
                TextSpan(
                    text: "$faizorantl",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 18)),
              ])),
            ],
          ),
          Row(
            children: [
              RichText(
                  text: TextSpan(children: [
              const  TextSpan(
                    text: "\u2022Kur Korumalı TL Hesabı\n Faiz Oranı: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 17)),
                TextSpan(
                    text: "$faizorandoviz",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 18)),
              ])),
            ],
          ),
          Row(
            children: [
              RichText(
                  text: TextSpan(children: [
             const   TextSpan(
                    text: "\u2022Dolar Hesabı Faiz Oranı: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 17)),
                TextSpan(
                    text: "$faizoranusd",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 18)),
              ])),
            ],
          ),
        ],
      ),
    );
  }
}

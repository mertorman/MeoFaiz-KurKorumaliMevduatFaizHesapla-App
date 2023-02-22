import 'package:flutter/material.dart';
import 'bankwidgetayar.dart';

class bankcontainer extends StatelessWidget {
  final String faizorantl, faizorandoviz, faizoranusd, logo, tarih;
  const bankcontainer(
      {Key? key,
      required this.faizorantl,
      required this.faizoranusd,
      required this.faizorandoviz,
      required this.logo,
      required this.tarih})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.22,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('images/header27.png'), fit: BoxFit.fill),
            // color: HexColor("#DDDDDD"),
            //  color: Color(0XFFF3F4F4),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500.withOpacity(0.15),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 3),
              )
            ]),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                heightFactor: 0,
                child: Image.asset(
                  "$logo",
                  height: 130,
                  width: 130,
                ),
              ),
            ),
            Center(
              child: Text(
                'Güncel Mevduat Faiz Verileri\n              $tarih ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            bankyazilar(
              faizorantl: faizorantl,
              faizorandoviz: faizorandoviz,
              // faizoraneuro: faizoraneuro,
              faizoranusd: faizoranusd,
            )
          ],
        ),
      ),
    );
  }
}

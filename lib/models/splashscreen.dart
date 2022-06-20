import 'package:flutter/material.dart';
import 'package:consulta_cnpj/consulta.dart';
import 'package:splashscreen/splashscreen.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SplashScreen(
          seconds: 5,
          navigateAfterSeconds: ConsultaCnpj(),
          backgroundColor: Colors.white,
          loaderColor: Colors.deepPurple,
        ),
        Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.asset(
              'assets/images/rocket.png',
              height: 130.0,
            ),
          ),
        )
      ],
    );
  }
}

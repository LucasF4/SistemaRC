import 'package:consulta_cnpj/consulta.dart';
import 'package:flutter/material.dart';
import 'settings/routes.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ConsultaCNPJ',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ConsultaCnpj(),
        routes: {
          GlobalRoutes.CONSULTA: (context) => ConsultaCnpj()
        });
  }
}

import 'package:consulta_cnpj/consulta.dart';
import 'package:flutter/material.dart';
import 'settings/routes.dart';

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
        initialRoute: GlobalRoutes.CONSULTA,
        routes: {GlobalRoutes.CONSULTA: (context) => ConsultaCnpj()});
  }
}

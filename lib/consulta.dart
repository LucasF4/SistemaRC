import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'package:consulta_cnpj/models/resultado.dart';

class ConsultaCnpj extends StatefulWidget {
  const ConsultaCnpj({Key? key}) : super(key: key);

  @override
  State<ConsultaCnpj> createState() => _ConsultaCnpjState();
}

class _ConsultaCnpjState extends State<ConsultaCnpj> {
  final _formKey = GlobalKey<FormState>();
  final _cnpj = TextEditingController();
  var textcnpj = '';

  Resultado resultadoClass = Resultado();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: resultadoClass.nome == null
            ? Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.rocket_launch_sharp, size: 100),
                          SizedBox(height: 80),
                          Text('Bem vindo!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24)),
                          SizedBox(height: 10),
                          Text(
                            'Realize a consulta informando ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text('o CNPJ no local indicado',
                              style: TextStyle(fontSize: 20)),
                          SizedBox(height: 50),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Informe o CNPJ';
                                          }
                                          return null;
                                        },
                                        controller: _cnpj,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          CnpjInputFormatter()
                                        ],
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Informe o CNPJ')),
                                  ))),
                          SizedBox(height: 20),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.0),
                              child: Container(
                                  width: w,
                                  height: 50,
                                  decoration: new BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: RawMaterialButton(
                                    child: Text('Consultar',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (_cnpj.text.length < 18) {
                                          return print('CNPJ inválido.');
                                        }
                                        _consultarCnpj();
                                      }
                                    },
                                  )))
                        ]),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: SafeArea(
                    child: Column(
                children: [
                  Container(
                      child: Column(children: [
                    Container(
                      height: h - 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/backgroundApp.png'),
                              fit: BoxFit.fill)),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '${resultadoClass.nome}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: w * 0.045),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          'FANTASIA: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: w * 0.035),
                                        ),
                                        Text(
                                          '${resultadoClass.fantasia}',
                                          style: TextStyle(fontSize: w * 0.035),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          'CNPJ: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: w * 0.039),
                                        ),
                                        Text(
                                          '${resultadoClass.cnpj}',
                                          style: TextStyle(fontSize: w * 0.039),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                            Divider(),
                            SizedBox(height: h * 0.101),
                            Text(
                              'SITUACAO',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(height: 10),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          'DATA DA SITUAÇÃO: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: w * 0.039),
                                        ),
                                        Text(
                                          '${resultadoClass.dataSituacao}',
                                          style: TextStyle(fontSize: w * 0.039),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    'SITUACAO: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: w * 0.039),
                                  ),
                                  Text(
                                    '${resultadoClass.situacao}',
                                    style: TextStyle(
                                        color:
                                            resultadoClass.situacao == 'ATIVA'
                                                ? Colors.green[300]
                                                : Colors.red,
                                        fontSize: w * 0.039,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'MOTIVO: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: w * 0.039),
                                ),
                                resultadoClass.motivoSituacao != ''
                                    ? Text(
                                        '${resultadoClass.motivoSituacao}',
                                        style: TextStyle(fontSize: w * 0.039),
                                      )
                                    : Text(
                                        'NENHUM MOTIVO DESCRITO',
                                        style: TextStyle(fontSize: w * 0.039),
                                      )
                              ],
                            ),
                            SizedBox(
                              height: h * 0.14,
                            ),
                          ],
                        ),
                      ),
                    )
                  ])),
                  Container(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                        width: w,
                        height: 50,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.deepPurple),
                        child: RawMaterialButton(
                          child: Text(
                            'Consultar outro CNPJ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          onPressed: () {
                            setState(() {
                              resultadoClass.nome = null;
                              _cnpj.clear();
                            });
                          },
                        )),
                  ))
                ],
              ))));
  }

  Future _consultarCnpj() async {
    var cnpjReplacement =
        _cnpj.text.replaceAll('.', '').replaceAll('/', '').replaceAll('-', '');
    print(cnpjReplacement);

    var url =
        Uri.parse('https://www.receitaws.com.br/v1/cnpj/$cnpjReplacement');
    try {
      var response = await http.get(url);
      print('Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        var content = json.decode(response.body);
        print(content['nome']);
        print(content);

        Map<String, dynamic> dados = json.decode(response.body);

        setState(() {
          resultadoClass.cnpj = _cnpj.text;
          resultadoClass.nome = dados['nome'];
          resultadoClass.cep = dados['cep'];
          resultadoClass.situacao = dados['situacao'];
          resultadoClass.fantasia = dados['fantasia'];
          resultadoClass.bairro = dados['bairro'];
          resultadoClass.logradouro = dados['logradouro'];
          resultadoClass.numero = dados['numero'];
          resultadoClass.municipio = dados['municipio'];
          resultadoClass.uf = dados['uf'];
          resultadoClass.dataSituacao = dados['data_situacao'];
          resultadoClass.email = dados['email'];
          resultadoClass.telefone = dados['telefone'];
          resultadoClass.motivoSituacao = dados['motivo_situacao'];
        });
      } else if (response.statusCode == 429) {
        print("Ocorreu um erro");
        Fluttertoast.showToast(
            msg: 'Aguarde 1 minuto para fazer uma nova consulta.');
      } else {
        print("Problemas com a conexão");
        print(response.statusCode);
        Fluttertoast.showToast(msg: 'Algo deu errado!');
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "Verifique a sua conexão com a internet.");
    }
  }
}

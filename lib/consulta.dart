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

//32267292000110

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
                                          return print('CNPJ inv??lido.');
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
                            /* 
                    Divider(),
                    SizedBox(height: 30,),
                    Text('INFORMACOES',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),),
                    SizedBox(height: 15,), */
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  /* Container(
                          child: Row(
                            children: [
                              Text('CEP: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: w * 0.039
                              ),),
                              Text('${resultadoClass.cep}',
                              style: TextStyle(fontSize: w * 0.039),),
                            ],
                          )
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text('BAIRRO: ',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: w * 0.039),),
                              Text('${resultadoClass.bairro}',
                              style: TextStyle(
                                fontSize: w * 0.039
                              ),)
                            ],
                          )
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Text('LOGRADOURO: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: w * 0.039
                              ),),
                              Text('${resultadoClass.logradouro}',
                              style: TextStyle(fontSize:w * 0.039),),
                            ],
                          ),
                        ),
                      ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Text('N??: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: w * 0.039
                              ),),
                              Text('${resultadoClass.numero}',
                              style: TextStyle(fontSize:w * 0.039),),
                            ],
                          ),
                        ),
                      ]
                    ),
                    Container(
                          child: Row(
                            children: [
                              Text('MUNICIPIO: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: w * 0.039
                              ),),
                              Text('${resultadoClass.municipio}',
                              style: TextStyle(fontSize:w * 0.039),),
                            ],
                          ),
                        ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Text('UF: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: w * 0.039
                              ),),
                              Text('${resultadoClass.uf}',
                              style: TextStyle(fontSize:w * 0.039),),
                            ],
                          ),
                        ), */
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
                                          'DATA DA SITUA????O: ',
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
                            /* Text('CONTATOS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),),
                    SizedBox(height: 10,),
                    Container(
                       child: Row(
                        children: [
                          Text('E-MAIL: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: w * 0.039
                          ),),
                          Text('${resultadoClass.email}',
                          style: TextStyle(fontSize:w * 0.039),),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text('Phone: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: w * 0.039
                          ),),
                          Text('${resultadoClass.telefone}',
                          style: TextStyle(fontSize:w * 0.039),),
                        ]
                      )
                    ),
                    SizedBox(height: h * 0.15), */
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

  /* Center(
        child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: FutureBuilder<List<Resultado>>(
              future: resultado2,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                      Resultado resultado = snapshot.data![index];
                      return ListTile(
                        title: Text(resultado.nome!),
                      );
                    },
                  );
                }else if(snapshot.hasError){
                  return Text(snapshot.error.toString());
                }
                return const CircularProgressIndicator();
              },
            )
          )
        )
        )
      ) */

  /* return Material(
      child: Form(
        key: _formKey,
        child: Container(
        padding: EdgeInsets.symmetric(horizontal: w * 0.03),
        height: h * 0.9,
        width: w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0013),
              child: TextFormField(
                controller: _cnpj,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Informe um CPNJ';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CnpjInputFormatter()
                ], 
                decoration: InputDecoration(
                hintText: 'Insira o CNPJ'
              ),)
            ),
            Text('CNPJ Inserido: $textcnpj'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RawMaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  elevation: 18,
                  padding: EdgeInsets.all(18),
                  child: const Text('Consultar',
                  style: TextStyle(
                    color: Colors.white
                  ),),
                  fillColor: Colors.blue,
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      if(_cnpj.text.length < 18){
                        print('erro');
                        setState((){
                          textcnpj = 'Formato CNPJ Inv??lido';
                        });
                        return;
                      }
                      
                      _loginUser();
                      
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
      )
    ); */

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
        /* showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Ops..."),
                content: Text("Aguarde 1 minuto, para fazer uma nova consulta"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Okay"))
                ],
              );
            }); */
        Fluttertoast.showToast(
            msg: 'Aguarde 1 minuto para fazer uma nova consulta.');
      } else {
        print("Problemas com a conex??o");
        print(response.statusCode);
        Fluttertoast.showToast(msg: 'Algo deu errado!');
      }
      //print('Body: ${response.body}');
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "Verifique a sua conex??o com a internet.");
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:http/http.dart' as http;

import 'package:consulta_cnpj/models/resultado.dart';

class ConsultaCnpj extends StatefulWidget {
  const ConsultaCnpj({ Key? key }) : super(key: key);

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
      body: resultadoClass.fantasia == null ?
      Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.rocket_launch_sharp,
                    size: 100
                  ),
                  SizedBox(height: 80),
                  Text(
                    'Bem vindo!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                    )
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Realize a consulta informando o CNPJ no',
                    style: TextStyle(
                     fontSize: 20
                    ),
                  ),
                  Text('local indicado',
                  style: TextStyle(
                    fontSize: 20
                  )),
                  SizedBox(height: 50),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Informe o CNPJ';
                          }
                          return null;
                        },
                        controller: _cnpj,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CnpjInputFormatter()
                        ],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Informe o CNPJ'
                      )
                    ),
                    )
                  )
                  ),
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
                        child: Text(
                          'Consultar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          )
                        ),
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            if(_cnpj.text.length < 18){
                              return print('CNPJ inválido.');
                            }
                            _consultarCnpj();
                          }
                        },
                      )
                    )
                  )
                ]
              ),
                ),
              ),
            )
            :
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${resultadoClass.fantasia}'),
                  TextButton(child: Text('Retornar'),
                  onPressed: () => {
                    setState((){
                      resultadoClass.fantasia = null;
                    })
                  },)
                ])
            )
          );
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
                          textcnpj = 'Formato CNPJ Inválido';
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

    var cnpjReplacement = _cnpj.text.replaceAll('.', '').replaceAll('/', '').replaceAll('-', '');
    print(cnpjReplacement);

    var url = Uri.parse('https://www.receitaws.com.br/v1/cnpj/$cnpjReplacement');
    var response = await http.get(url);
    print('Status: ${response.statusCode}');
    //print('Body: ${response.body}');

    var content = json.decode(response.body);
    print(content['fantasia']);

    Map<String, dynamic> dados = json.decode(response.body);

    setState((){
      resultadoClass.fantasia = dados['fantasia'];
      print(resultadoClass.fantasia);
    });
    
  }
}
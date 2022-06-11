import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';

class ConsultaCnpj extends StatefulWidget {
  const ConsultaCnpj({ Key? key }) : super(key: key);

  @override
  State<ConsultaCnpj> createState() => _ConsultaCnpjState();
}

class _ConsultaCnpjState extends State<ConsultaCnpj> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Material(
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
            Row(
              children: [
                RawMaterialButton(
                  fillColor: Colors.blue,
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
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
    );
  }

  void _loginUser(){
    
  }
}
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerCep = TextEditingController();

  String _endereco = "";

  _recuperarCep() async {
    String cep = _controllerCep.text;
    String url = "https://viacep.com.br/ws/${cep}/json/";
    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);

    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    String uf = retorno["uf"];
    String ddd = retorno["ddd"];

    setState(() {
      _endereco =
          "Logradouro: ${logradouro} \nComplemento: ${complemento} \nBairro: ${bairro}  \nLocalidade: ${localidade}" +
              "\nUF: ${uf} \nCEP: ${cep} \nDDD: ${ddd}";
    });

    print(_controllerCep);

    print(
        "Resposta Logradouro: ${logradouro} complemento: ${complemento} bairro: ${bairro} ");

    _controllerCep.clear();

    //print("resposta: " + response.statusCode.toString() );
    print("resposta: " + response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("App API Via Cep®"), backgroundColor: Colors.green),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Informe o CEP"),
                controller: _controllerCep),
            Padding(
              padding: EdgeInsets.all(20),
              child: RaisedButton(
                padding: EdgeInsets.all(15),
                child: Text("Clique aqui"),
                onPressed: _recuperarCep,
              ),
            ),
            Text(_endereco)
          ],
        ),
      ),
    );
  }
}

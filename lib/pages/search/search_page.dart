import 'package:search/services/search_service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:search/services/search_ruc.dart';
import 'package:search/services/search_tipo.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
  }

  List<dynamic> searchResults = [];
  searchDjango(value) async {
    SearchService.searchDjangoApi(value).then((responseBody) {
      List<dynamic> data = jsonDecode(responseBody);
      setState(() {
        data.forEach((value) {
          searchResults.add(value);
        });
      });
    });
  }

  searchDjango2(value) async {
    SearchRuc.searchDjangoApi2(value).then((responseBody) {
      List<dynamic> data = jsonDecode(responseBody);
      setState(() {
        data.forEach((value) {
          searchResults.add(value);
        });
      });
    });
  }

  searchDjango3(value) async {
    SearchTipo.searchDjangoApi3(value).then((responseBody) {
      List<dynamic> data = jsonDecode(responseBody);
      setState(() {
        data.forEach((value) {
          searchResults.add(value);
        });
      });
    });
  }

  String _value;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF151026),
          title: Text('Buscador'),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: DropdownButton(
                  style: new TextStyle(color: Colors.blueGrey[900]),
                  value: _value,
                  items: [
                    DropdownMenuItem(
                      child: Text("ONG"),
                      value: "ong",
                    ),
                    DropdownMenuItem(
                      child: Text("Asociacion"),
                      value: "Asociacion",
                    ),
                    DropdownMenuItem(
                        child: Text("Movimiento"), value: "Movimiento"),
                  ],
                  onChanged: (String value) {
                    setState(() {
                      searchResults.clear();
                      searchDjango3(value);
                      _value = value;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (value) {
                  searchResults.clear();
                  searchDjango(value);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey[100],
                  contentPadding: EdgeInsets.only(left: 25.0),
                  hintText: 'Busca aquí por Nombre de Institución',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: null,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (value) {
                  searchResults.clear();
                  searchDjango2(value);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey[100],
                  contentPadding: EdgeInsets.only(left: 25.0),
                  hintText: 'Busca aquí por RUC de Institución',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: null,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: searchResults.length,
              itemBuilder: (BuildContext context, int index) {
                return buildResultCard(searchResults[index]);
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget buildResultCard(data) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: <Widget>[
        Ink(
          color: Colors.blueGrey[200],
          child: ListTile(
            title: Text(data['nombreInsti']),
            subtitle: Text(data['sigla']),
            onTap: () => print('ListTile'),
          ),
        ),
        Ink(
          color: Colors.blueGrey[200],
          child: ListTile(
            title: Text(data['representante']),
            subtitle: Text(data['domicilio']),
            onTap: () => print('ListTile'),
          ),
        ),
        Ink(
          color: Colors.blueGrey[200],
          child: ListTile(
            title: Text(data['email']),
            subtitle: Text(data['ruc']),
            onTap: () => print('ListTile'),
          ),
        ),
        Divider(color: Colors.black),
      ],
    ),
  );
}

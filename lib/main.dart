import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StarWars Api',
      debugShowCheckedModeBanner: false,
      home: StarWarsData(),
    );
  }
}

class StarWarsData extends StatefulWidget {
  @override
  _StarWarsDataState createState() => _StarWarsDataState();
}

class _StarWarsDataState extends State<StarWarsData> {
  final String url = 'https://swapi.co/api/starships/';
  List data;

  Future<String> getSWData() async {
    var res = await http.get(url, headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["results"];
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Star Wars Starships."),
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Name: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          data[index]['name'],
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      data[index]['model'],
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getSWData();
  }
}

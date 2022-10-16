import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class InicioCliente extends StatelessWidget {
  const InicioCliente({super.key});
  

  Future<List<Eventos>> event() async {
    String url = "https://ticketonline.shop/Android/mostar.php";
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Eventos> even = items.map<Eventos>((json){
      return Eventos.fromJson(json);
      }).toList();
      print(response.statusCode);
    }
    print("error");
    throw Exception('Failed to load data from Server.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
        backgroundColor: Color.fromARGB(255, 247, 182, 6),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder<List<Eventos>>(
          future: event(),
          builder: ((context, snapshot) {
            if(!snapshot.hasData){
              return Center(child: Text("Error"));
            }
            return Center(child: Text("correcto"));
            /*return ListView(
              children: snapshot.data!.map((data) => Card(
          elevation: 50,
          shadowColor: Colors.black,
          color: Colors.greenAccent[100],
          child: SizedBox(
            width: 300,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green[500],
                    radius: 108,
                    child: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://media.geeksforgeeks.org/wp-content/uploads/20210101144014/gfglogo.png"), //NetworkImage
                      radius: 100,
                    ), //CircleAvatar
                  ), //CircleAvatar
                  const SizedBox(
                    height: 10,
                  ), //SizedBox
                  Text(
                    'GeeksforGeeks',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.green[900],
                      fontWeight: FontWeight.w500,
                    ), //Textstyle
                  ), //Text
                  const SizedBox(
                    height: 10,
                  ), //SizedBox
                  const Text(
                    'texto',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.green,
                    ), //Textstyle
                  ), //Text
                  const SizedBox(
                    height: 10,
                  ), //SizedBox
                  ElevatedButton(
                      onPressed: () => 'Null',
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: const [
                            Icon(Icons.touch_app),
                            Text('Visit')
                          ],
                        ),
                      ),
                    ),
                  ]
              ), //Column
            ), //Padding
          ), //SizedBox
        )
        ).toList(),
            );*/
          }),
        )
      ), 
    );
  }
}
class Eventos {
 int? IdEvento;
 String? Nombre_Evento;
 String? Lugar;
 String? Fecha;
 String? Hora;
 int? IdAdmin;
 
  Eventos({
    this.IdEvento,
    this.Nombre_Evento,
    this.Lugar,
    this.Fecha,
    this.Hora,
    this.IdAdmin,
  });
 
  factory Eventos.fromJson(Map<String, dynamic> json) {
    return Eventos(
      IdEvento: json['IdEvento'],
      Nombre_Evento: json['Nombre_Evento'],
      Lugar: json['Lugar'],
      Fecha: json['Fecha'],
      Hora: json['Hora'],
      IdAdmin: json['IdAdmin']
    );
  }
}
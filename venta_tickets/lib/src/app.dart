import 'package:flutter/material.dart';
import 'package:venta_tickets/src/screens/inicio.dart';
import 'package:venta_tickets/src/screens/inicio_cliente.dart';
import 'package:venta_tickets/src/screens/inicio_sesion.dart';
import 'package:venta_tickets/src/screens/registro.dart';


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "Cliente",
      routes: {
        "/": (BuildContext context) => InicioSesion(),
        "Inicio": (BuildContext context) => Inicio(),
        "Registro": (BuildContext context) => Registro(),
        "Cliente": (BuildContext context) => InicioCliente(),
      },
    );
  }
}
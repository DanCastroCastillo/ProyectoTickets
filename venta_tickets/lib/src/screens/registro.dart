import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:http/http.dart' as http;

class Registro extends StatelessWidget {
  Registro({super.key});

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

 
  final nombre = TextEditingController();
  final apellido = TextEditingController();
  final ci = TextEditingController();
  final fecha_nac = TextEditingController();
  final correo = TextEditingController();
  final pass = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/src/assets/images/fondois.jpeg"
                  ),
                fit: BoxFit.cover),
              ),
            ),
            Center(
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: const Color.fromRGBO(0, 0, 0, 0.7),
                margin: const EdgeInsets.only(left: 20, right: 20, top: 60),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 70),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text("Registrate!", style: TextStyle(color: Color.fromRGBO(255, 167, 0, 1), fontSize: 30)),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: nombre,
                          decoration: InputDecoration(labelText: "Nombre:", border: InputBorder.none, enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: const BorderSide(color: Colors.white)),filled: true, fillColor: Colors.white),
                          onSaved: (value){
                            nombre.text = value!;
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "Este campo es obligatorio";
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: apellido,
                          decoration: InputDecoration(labelText: "Apellido: ", border: InputBorder.none, enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: const BorderSide(color: Colors.white)),filled: true, fillColor: Colors.white),
                          onSaved: (value){
                            apellido.text = value!;
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "Este campo es obligatorio";
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: ci,
                          decoration: InputDecoration(labelText: "CI: ", border: InputBorder.none, enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: const BorderSide(color: Colors.white)),filled: true, fillColor: Colors.white),
                          onSaved: (value){
                            ci.text = value!;
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "Este campo es obligatorio";
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: correo,
                          decoration: InputDecoration(labelText: "Correo: ", border: InputBorder.none, enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: const BorderSide(color: Colors.white)),filled: true, fillColor: Colors.white),
                          onSaved: (value){
                            correo.text = value!;
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "Este campo es obligatorio";
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: pass,
                          decoration: InputDecoration(labelText: "Contraseña: ", border: InputBorder.none, enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: const BorderSide(color: Colors.white)),filled: true, fillColor: Colors.white), obscureText: true,
                          onSaved: (value){
                            pass.text = value!;
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "Este campo es obligatorio";
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(255, 167, 0, 0.19), textStyle: const TextStyle(fontFamily: 'Montserrat', fontSize: 15), foregroundColor: const Color.fromRGBO(255, 167, 0, 1), padding: const EdgeInsets.symmetric(vertical: 17)),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            validarEmail(correo.text,pass.text, context);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Registrarse"),
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Future<List> SingIn(context) async {
    String url = "https://www.ticketonline.shop/Android/registro.php";
    final response = await http.post(Uri.parse(url), body: {
      "nombre": nombre.text,
      "apellido": apellido.text,
      "ci": ci.text,
      "fecha": fecha_nac.text,
      "correo": correo.text,
      "clave": pass.text,
    });
  Map<String, dynamic> map = json.decode(response.body);
  List<dynamic> data = map["estado"];

  if(data[0]["est"] =='0'){
    Flushbar(
      message: "Usuario creado correctamente",
      duration: const Duration(seconds: 3),
    ).show(context);
    Navigator.pushReplacementNamed(context, '/');
  }
  else {
    if(data[0]["est"] =='1'){
    Flushbar(
      message: "Error al crear la cuenta",
      duration: const Duration(seconds: 3),
    ).show(context);
  }else{
    if(data[0]["est"] =='2'){
    Flushbar(
      message: "Cuenta ya existente",
      duration: const Duration(seconds: 3),
    ).show(context);
  }
  }
  }
  return data;
  }

  void validarEmail(String correo,String password, context){
  int cantidad;
  bool pass;
  final bool isvalid = EmailValidator.validate(correo);
  if(!isvalid){
    Flushbar(
      message: "Formato de correo incorrecto",
      duration: const Duration(seconds: 3),
    ).show(context);
  }
  cantidad = password.length;
  if(cantidad >= 5 && cantidad < 15)
  {
    pass = true;
  }
  else{
    pass = false;
    Flushbar(
      message: "La contraseña debe tener al menos 5 caracteres y menos de 15",
      duration: const Duration(seconds: 3),
    ).show(context);
  }
  if(isvalid && pass){
    SingIn(context);
  }
  }

}
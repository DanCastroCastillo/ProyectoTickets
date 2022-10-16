import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;


class InicioSesion extends StatelessWidget {
  InicioSesion({super.key});

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  
  String userName = "";
  String password = "";

  String mensaje= "";
 
  final userctrl = TextEditingController();
  final passctrl = TextEditingController();

  
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
                margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 80),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text("Iniciar Sesion", style: TextStyle(color: Color.fromRGBO(255, 167, 0, 1), fontSize: 30)),
                        const SizedBox(height: 40),
                        TextFormField(
                          controller: userctrl,
                          decoration: InputDecoration(labelText: "Correo:", border: InputBorder.none, enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: const BorderSide(color: Colors.white)),filled: true, fillColor: Colors.white),
                          onSaved: (value){
                            userName = value!;
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "Este campo es obligatorio";
                            }
                          },
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
                          controller: passctrl,
                          decoration: InputDecoration(labelText: "Contraseña", border: InputBorder.none, enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: const BorderSide(color: Colors.white)),filled: true, fillColor: Colors.white), obscureText: true,
                          onSaved: (value){
                            password = value!;
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "Este campo es obligatorio";
                            }
                          },
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(255, 167, 0, 0.19), textStyle: const TextStyle(fontFamily: 'Montserrat', fontSize: 15), foregroundColor: const Color.fromRGBO(255, 167, 0, 1), padding: const EdgeInsets.symmetric(vertical: 17)),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {  
                            validarEmail(userctrl.text, passctrl.text, context);    
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Iniciar Sesión"),
                          ],
                        )),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  <Widget>[
                            const Text("¿No estas registrado?", style: TextStyle(color: Colors.white),),
                            TextButton(onPressed: (() {
                            Navigator.of(context).pushNamed('Registro');
                            }), child: const Text("Registrarse", style: TextStyle(color: Color.fromRGBO(255, 167, 0, 1)),)),
                          ],
                        ),
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
  Future<List> login(context) async {
    String url = "https://www.ticketonline.shop/Android/login.php";
    final response = await http.post(Uri.parse(url), body: {
      "user": userctrl.text,
      "pass": passctrl.text,
    });
  Map<String, dynamic> map = json.decode(response.body);
  List<dynamic> data = map["datos"];
  if(data.length == 0){
      mensaje = "Contraseña o usuario incorrecto";
  }else {
    if(data[0]["roll"] == '1'){
      Navigator.pushReplacementNamed(context, 'Inicio');
    }
    if(data[0]["roll"] == '0'){
      Navigator.pushReplacementNamed(context, 'Cliente');
    }
  }
  return data;
  }

  void validarEmail(String correo,String passowrd, context){
  int cantidad;
  bool pass;
  final bool isvalid = EmailValidator.validate(correo);
  if(!isvalid){
    Flushbar(
      message: "Formato de correo incorrecto",
      duration: const Duration(seconds: 3),
    ).show(context);
  }
  cantidad = passowrd.length;
  if(cantidad >= 5 && cantidad < 15)
  {
    pass = true;
  }
  else{
    pass = false;
    Flushbar(
      message: "Error de credenciales",
      duration: const Duration(seconds: 3),
    ).show(context);
  }
  if(isvalid && pass){
    login(context);
  }
  }
}

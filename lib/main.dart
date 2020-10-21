import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() => runApp(MyApp());
class MyApp extends StatelessWidget {

  Future<String> consultar() async{
    print("Ha respondido :-)");
    var respuesta = await http.get('https://jsonplaceholder.typicode.com/posts/1');
    // sample info available in response
    int statusCode = respuesta.statusCode;
    Map<String, String> headers = respuesta.headers;
    String contentType = headers['content-type'];
    String js = respuesta.body;
    print(statusCode.toString()+"\n"+ headers.toString()+"\n"+ js.toString());
    print(respuesta.toString());

    print("Ha respondido :-)");
    return (js);
  }
 //meter un comp stateful que soporte un texto, set estate y repintas
  MyApp(){
    print("constructor");
    var s = consultar().then((x){
      print(x);
    });
    print(s.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}

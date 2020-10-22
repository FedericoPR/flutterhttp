import'package:flutter/material.dart';
import'package:http/http.dart'as http;

Future<String> consultar() async{

  print("Lanzar la peticion");
  var respuesta = await http.get('https://jsonplaceholder.typicode.com/posts/1');

  // sample info available in response
  int statusCode = respuesta.statusCode;
  Map<String, String> headers = respuesta.headers;
  String contentType = headers['content-type'];
  String js = respuesta.body;print(statusCode.toString()+"\n"+ headers.toString()+"\n"+ js.toString());
  print(respuesta.toString());

  return js;

}

void main(){
  consultar().then( (x){
    print( "===============================\n LA RESPUESTA ES "+x);
  });
  runApp(MyApp());}


// UI -----------------------------------------
class MyApp extends StatefulWidget{

  @override
  State<MyApp> createState() {
    print("Constructor MyApp");
    return new MyAppState();//el estado ---> otra clase
  }
}

class MyAppState extends State<MyApp> {

  String _ms=" Loading... ";

  MyAppState(){
    print("Costructor del State");
    consultar().then(
      (x){
        print(" ======== \n LOTENGO!" + x);
        setState(() {
          _ms = x;
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      home: Scaffold(
       appBar: AppBar(
       title: Text('Sateful widget'),
        ),
        body: Center(
          child: Text(_ms),
        ),
     ),
    );
  }
}

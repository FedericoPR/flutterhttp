import'package:flutter/material.dart';
import'package:http/http.dart'as http;



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
  String texto = null;
  var cambiar = false;
  final myController = TextEditingController();

  Future<String> consultar() async{

    print("Lanzar la peticion");
    var respuesta = await http.get(texto);

    // sample info available in response
    int statusCode = respuesta.statusCode;
    Map<String, String> headers = respuesta.headers;
    String contentType = headers['content-type'];
    String js = respuesta.body;print(statusCode.toString()+"\n"+ headers.toString()+"\n"+ js.toString());
    print(respuesta.toString());

    return js;

  }
  /*
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
  */

  void click() {
    texto = myController.text.toString();
    consultar().then((x) {//x valor 0 o 1 en String
      setState(() {
        if(x=="0")
          cambiar = false;
        else
          cambiar =true;
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
          child:
            Row(
              children: [
                Container(
                  child:
                  Row(
                    children: [
                      if(cambiar)
                        Icon(Icons.check_circle)
                      else
                        Icon(Icons.remove_circle_outlined)
                    ],
                  ),
                ),
                Container(
                  child:
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Text',
                    ),
                    controller: myController,
                ),
                ),
                Container(
                  child:
                  RaisedButton(
                    disabledColor: Colors.amber,
                    child: Text("Check"),
                    splashColor: Colors.amber,
                    color: Colors.blueAccent,
                    onPressed: ()  {
                      print("Check");
                    },
                  )
                  ,
                )
              ],
            )
        ),
     ),
    );
  }
}

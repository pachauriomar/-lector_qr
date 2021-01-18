import 'package:flutter/material.dart';
import 'package:lector_qr/qr_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Inicio());
  }
}

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  String codigoQR = 'Aún no se ha escaneado un código...';
  bool estadoQR = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.qr_code),
          title: Text('Lector QR - Códigos Junior'),
          titleSpacing: 0,
        ),
        body: Stack(
          children: [
            Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Card(
                      elevation: 10.0,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: SingleChildScrollView(
                          child: Text(
                            codigoQR,
                            style: TextStyle(
                                fontSize: 18,
                                color: (!estadoQR)
                                    ? Colors.black26
                                    : Colors.black),
                          ),
                        ),
                      ),
                    ),
                    RaisedButton(
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      onPressed: () => _navegarAlEscanner(context),
                      child: Text(
                        'ESCANEAR QR',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 7.0),
                      ),
                    ),
                  ],
                )),
          ],
        ));
  }

/**
 * Esta función permite navegar a la pantalla del scanner y esperar el resultado para mostrarlo
 */
  _navegarAlEscanner(BuildContext context) async {
    this.codigoQR = 'Aún no se ha escaneado un código...';
    this.estadoQR = false;
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QRPAGE()),
    );
    setState(() {
      if (result != null) {
        this.codigoQR = result;
        this.estadoQR = true;
      }
    });
  }
}

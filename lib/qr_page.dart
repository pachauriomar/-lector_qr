import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';

class QRPAGE extends StatefulWidget {
  @override
  _QrBarcodeState createState() => new _QrBarcodeState();
}

class _QrBarcodeState extends State<QRPAGE> {
  bool _camState = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Escanear QR'),
      ),
      body: Stack(children: <Widget>[
        _escanner(context),
      ]),
    );
  }

  @override
  void initState() {
    super.initState();
    _scanCode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  _qrCallback(String code) {
    setState(() {
      _camState = false;
    });
    Timer(Duration(milliseconds: 1500), () => Navigator.pop(context, code));
  }

  Widget _escanner(BuildContext context) {
    return Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              height: MediaQuery.of(context).size.height - 150,
              child: _camState
                  ? QRBarScannerCamera(
                      onError: (context, error) => Text(
                        error.toString(),
                        style: TextStyle(color: Colors.red),
                      ),
                      qrCodeCallback: (code) {
                        _qrCallback(code);
                      },
                    )
                  : Center(
                      child: SizedBox(
                          width: 80.0,
                          height: 80.0,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.red[100],
                            strokeWidth: 10.0,
                          )),
                    ),
            ),
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.amber,
                ),
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(bottom: 8),
                child: Center(
                  child: Text(
                    'Ubique el codigo QR frente a la cámara',
                    style: TextStyle(
                        fontWeight: FontWeight.w900, letterSpacing: 1),
                  ),
                ))
          ],
        ));
  }
}

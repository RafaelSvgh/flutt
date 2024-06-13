import 'package:flutter/material.dart';

class PerfilPagePromotor extends StatelessWidget {
  final List<String> usuario;
  const PerfilPagePromotor({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Mi Perfil',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.indigoAccent,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Column(
          children: [
            Container(
              height: 240,
              margin: const EdgeInsets.only(top: 50.0),
              alignment: Alignment.center,
              child: const ClipOval(
                  child: Icon(
                Icons.person_pin,
                size: 150,
                color: Colors.blue,
              )),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Promotor',
                style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(left: 25.0, top: 30.0),
              child: Text('Mis puntos: ${usuario[5].toString()}',
                  style: const TextStyle(
                      fontSize: 19.0, fontWeight: FontWeight.w500)),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(left: 25.0),
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                usuario[1],
                style: const TextStyle(fontSize: 17.0),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(left: 25.0),
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                usuario[2],
                style: const TextStyle(fontSize: 17.0),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(left: 25.0, top: 30.0),
              child: Text(usuario[7].toString(),
                  style:
                      TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400)),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(left: 25.0, top: 30.0),
              child: Text(usuario[6],
                  style:
                      TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400)),
            )
          ],
        ));
  }
}

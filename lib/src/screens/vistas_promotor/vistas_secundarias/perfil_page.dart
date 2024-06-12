import 'package:flutter/material.dart';

class PerfilPagePromotor extends StatelessWidget {
  const PerfilPagePromotor({super.key});

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
              child: ClipOval(
                child: Image.network(
                    "https://pbs.twimg.com/media/E6Rc-cmXIAgVcma.jpg"),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(left: 25.0),
              child: const Text(
                'Administrador',
                style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(left: 25.0),
              padding: const EdgeInsets.only(top: 20.0),
              child: const Text(
                'admin@gmail.com',
                style: TextStyle(fontSize: 17.0),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(left: 25.0, top: 30.0),
              child: const Text('Me encanta ayudar a las personas.',
                  style:
                      TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400)),
            )
          ],
        ));
  }
}

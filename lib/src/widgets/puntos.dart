
import 'package:flutter/cupertino.dart';

void puntosPromotor(BuildContext context, String puntos){
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Felicidades'),
      content: Text('Ganaste $puntos puntos de promotor'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 270,
                margin: const EdgeInsets.only(bottom: 15.0),
                child: Image.network(
                    "https://lordicon.com/icons/wired/flat/1103-confetti.gif"),
              ),
              const Text('Perfecto')
            ],
          ),
        ),
      ],
    ),
  );
}
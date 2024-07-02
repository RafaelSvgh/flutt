import 'package:flutter/material.dart';

Widget contenedorCompra(String monto, String num, String fecha) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 7.0),
    width: double.infinity,
    height: 110.0,
    padding: const EdgeInsets.all(15.0),
    decoration: BoxDecoration(
        color: Colors.grey.shade300, borderRadius: BorderRadius.circular(15.0)),
    child: Row(
      children: [
        Icon(
          Icons.shopify_sharp,
          size: 75.0,
          color: Colors.black54,
        ),
        SizedBox(
          width: 20.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Text(
                  '# $num',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 30.0,
                ),
                Text(
                  'Fecha: $fecha',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Monto: $monto Bs',
                  style: const TextStyle(fontSize: 17.0),
                ),
                SizedBox(
                  width: 75.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50.0)),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 30,
                      )),
                )
              ],
            )
          ],
        )
      ],
    ),
  );
}

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutt/src/models/familia.dart';
import 'package:flutter/material.dart';

class FamiliasPage extends StatefulWidget {
  const FamiliasPage({super.key});

  @override
  State<FamiliasPage> createState() => _FamiliasPageState();
}

class _FamiliasPageState extends State<FamiliasPage> {
  Familias? familias;
  @override
  void initState() {
    super.initState();
    getFamilias();
  }

  Future<void> getFamilias() async {
    try {
      final response = await Dio().get('http://3.88.182.80/api/familias');
      setState(() {
        familias = Familias.fromJsonList(response.data);
      });
      // ignore: empty_catches
    } catch (error) {}
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Column(
              children: (familias?.items ?? []).map((familia) {
            return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
                child: ListTile(
                  title: Text(
                    familia.nombre,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  onTap: () {},
                ));
          }).toList()),
          Expanded(child: Container()),
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text(
                'Agregar',
                style: TextStyle(fontSize: 18.0),
              )),
          const SizedBox(
            height: 25.0,
          )
        ],
      ),
    );
  }
}

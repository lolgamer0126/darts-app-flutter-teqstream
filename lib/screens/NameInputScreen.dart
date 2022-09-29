import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../controller/MainController.dart';
import 'EnterRoundCount.dart';

class NameInput extends StatelessWidget {
  const NameInput({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    final Controller c = Get.put(Controller());
    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text("Тоглогчийн тоо: ${c.count}")),
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount: c.count.toInt(),
                  itemBuilder: (context, index) {
                    return _row(index);
                  },
                ),
              ),
              const SizedBox(height: 1.0),
              // Obx(() => Text(c.result.value)),
              SizedBox(
                  width: 300,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => EnterRoundCount())));
                    },
                    style: const ButtonStyle(),
                    child: const Text(
                      'Болсон',
                      style: TextStyle(fontSize: 40, fontFamily: 'fira'),
                    ),
                  )),
            ],
          ),
        ));
  }

  _row(int key) {
    return Row(
      children: [
        Text('Тоглогч: ${key + 1}'),
        const SizedBox(width: 30.0),
        Expanded(child: TextFormField(
          onChanged: (val) {
            _onUpdate(key, val);
          },
        )),
      ],
    );
  }

  _onUpdate(int key, String val) {
    final Controller c = Get.put(Controller());
    int foundKey = -1;
    for (var map in c.values) {
      if (map['id'] == key) {
        foundKey = key;
        break;
      }
    }
    if (-1 != foundKey) {
      c.values.removeWhere((element) => element['id'] == foundKey);
    }
    Map<String, dynamic> json = {
      'id': key,
      'value': {'name': val, 'score': 0}
    };
    c.values.add(json);
    c.result.value = prettyPrint(c.values);
  }

  String prettyPrint(jsonObject) {
    var encoder = const JsonEncoder.withIndent('    ');
    return encoder.convert(jsonObject);
  }
}

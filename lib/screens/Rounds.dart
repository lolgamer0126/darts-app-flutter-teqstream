import 'dart:convert';

import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import '../controller/MainController.dart';
import 'LeaderBoard.dart';

class Rounds extends StatelessWidget {
  final Controller c = Get.put(Controller());
  Rounds({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(
              "Round: ${c.roundIterate}, Player: ${c.values[c.playerIterate]['value']['name']}, Оноо: ${c.values[c.playerIterate]['value']['score']}")),
        ),
        body: Column(
          children: [
            TextField(
              decoration:
                  const InputDecoration(labelText: "Авсан оноогоо оруулна уу"),
              keyboardType: TextInputType.number,
              onChanged: ((value) => {c.score = int.parse(value)}),
            ),
            const SizedBox(
              height: 100,
            ),
            SizedBox(
                width: 300,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    String prettyPrint(jsonObject) {
                      var encoder = const JsonEncoder.withIndent('    ');
                      return encoder.convert(jsonObject);
                    }

                    if (c.roundIterate < c.roundCount.value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => Rounds())));
                    } else {
                      if (c.playerIterate == c.values.length - 1) {
                        c.calculateWinner();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => LeaderBoard())));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Rounds())));
                      }
                    }
                    c.values[c.playerIterate]['value']['score'] =
                        c.values[c.playerIterate]['value']['score'] + c.score;
                    c.result.value = prettyPrint(c.values);
                    c.playerIterate++;
                    if (c.playerIterate == c.values.length) {
                      c.roundIterate++;
                      c.playerIterate = 0;
                    }
                  },
                  style: const ButtonStyle(),
                  child: const Text(
                    'Болсон',
                    style: TextStyle(fontSize: 40, fontFamily: 'fira'),
                  ),
                )),
            // Text(c.result.value)
          ],
        ));
  }
}

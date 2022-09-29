import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import '../controller/MainController.dart';

class LeaderBoard extends StatelessWidget {
  LeaderBoard({Key? key}) : super(key: key);
  final Controller c = Get.put(Controller());
  // void initState() {
  //   c.calculateWinner();
  // }

  String prettyPrint(jsonObject) {
    var encoder = const JsonEncoder.withIndent('    ');
    return encoder.convert(jsonObject);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ялагч бол!!!!!!!'),
      ),
      body: Obx(() => TextLiquidFill(
            text: c.winner.value,
            waveColor: Colors.blueAccent,
            boxBackgroundColor: const Color.fromARGB(255, 226, 224, 224),
            textStyle: const TextStyle(
              fontSize: 80.0,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}

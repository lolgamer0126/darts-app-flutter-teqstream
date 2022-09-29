import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/NameInputScreen.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../controller/MainController.dart';
import '../main.dart';

class HomeScreen extends StatelessWidget {
  final Controller c = Get.put(Controller());
  static const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  static const colorizeTextStyle = TextStyle(
    fontSize: 35.0,
    fontFamily: 'Horizon',
  );

  HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText('Тоглогчдын тоо:',
                  textStyle: colorizeTextStyle, colors: colorizeColors)
            ],
          ),
          Obx(() => TextLiquidFill(
                text: "${c.count}",
                waveColor: Colors.blueAccent,
                boxBackgroundColor: const Color.fromARGB(255, 226, 224, 224),
                textStyle: const TextStyle(
                  fontSize: 80.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: c.increment,
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(30)),
                child: const Icon(
                  Icons.add,
                  size: 80,
                ),
              ),
              ElevatedButton(
                onPressed: c.decrament,
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(30)),
                child: const Icon(
                  Icons.remove,
                  size: 80,
                ),
              ),
            ],
          ),
          SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const NameInput())));
                },
                style: const ButtonStyle(),
                child: const Text(
                  'Болсон',
                  style: TextStyle(fontSize: 40, fontFamily: 'fira'),
                ),
              )),
        ],
      ),
    );
  }
}

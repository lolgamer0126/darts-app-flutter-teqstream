import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../controller/MainController.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'Rounds.dart';

class EnterRoundCount extends StatelessWidget {
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

  EnterRoundCount({Key? key}) : super(key: key);
  @override
  Widget build(context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText('Үеийн тоо:',
                  textStyle: colorizeTextStyle, colors: colorizeColors)
            ],
          ),
          Obx(() => TextLiquidFill(
                text: "${c.roundCount}",
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
                onPressed: c.incrementRound,
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(30)),
                child: const Icon(
                  Icons.add,
                  size: 80,
                ),
              ),
              ElevatedButton(
                onPressed: c.decramentRound,
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => Rounds())));
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

import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

void main() => runApp(const MyApp());

class Controller extends GetxController {
  var count = 0.obs;
  increment() => count++;
  RxString result = ''.obs;
  RxString winner = ''.obs;
  decrament() => {
        if (count > 0) {count--}
      };
  // ignore: unused_field
  List<Map<String, dynamic>> values = [];
  var roundCount = 0.obs;
  incrementRound() => roundCount++;
  decramentRound() => {
        if (roundCount > 0) {roundCount--}
      };

  //round items
  var roundIterate = 1.obs;
  var score = 0;
  var playerIterate = 0;
  calculateWinner() {
    var max = 0;
    for (var map in values) {
      if (map['value']['score'] > max) {
        max = map['value']['score'];
        winner.value = map['value']['name'];
      }
      // print(map['values']['score']);
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

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

// Second page that takes dynamic input
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

class Home extends StatelessWidget {
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

  Home({Key? key}) : super(key: key);
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

//Rounds will continue here

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

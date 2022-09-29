import 'package:get/get.dart';

class Controller extends GetxController {
  var count = 0.obs;
  RxString result = ''.obs;
  RxString winner = ''.obs;
  // ignore: unused_field
  List<Map<String, dynamic>> values = [];
  var roundCount = 0.obs;
  //round items
  var roundIterate = 1.obs;
  var score = 0;
  var playerIterate = 0;

  increment() => count++;
  decrament() => {
        if (count > 0) {count--}
      };
  incrementRound() => roundCount++;
  decramentRound() => {
        if (roundCount > 0) {roundCount--}
      };
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

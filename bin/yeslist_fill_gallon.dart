import 'dart:convert';

import 'package:yeslist_fill_gallon/yeslist_fill_gallon.dart';

void main(List<String> arguments) {
  var bottlesToFill = <Bottle>[
    Bottle(1),
    Bottle(6),
    Bottle(4.5),
    Bottle(1.5),
    Bottle(2.5)
  ];

  var s = Stopwatch()..start();

  var gallon = Gallon(7, fillSource: bottlesToFill)
    ..startFillAnalysis()
    ..whereIsOptimal()
    ..fill();

  print('optimal case(s): ' + gallon.optimalFillOptions.toString());
  print('viable cases: ' + gallon.fillOptions.toString());

  print('\nget filled: ' + gallon.filled.toString() + '\n');

  print(gallon.toJson());
  print(bottlesToFill[0].toJson());
  print(bottlesToFill[2].toJson());

  print('executed in ${s.elapsed}');

  s.stop();
}

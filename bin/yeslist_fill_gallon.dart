import 'package:yeslist_fill_gallon/yeslist_fill_gallon.dart';

void main(List<String> arguments) {
  var bottlesToFill = <Bottle>[Bottle(1), Bottle(3), Bottle(4.5), Bottle(1.5)];

  var s = Stopwatch()..start();

  var gallon = Gallon(5, fillSource: bottlesToFill)
    ..startFillAnalysis()
    ..whereIsOptimal()
    ..fill();

  print('optimal case(s): ' + gallon.optimalFillOptions.toString());
  print('viable cases: ' + gallon.fillOptions.toString());

  print('\nget filled: ' + gallon.filled.toString() + '\n');

  print('executed in ${s.elapsed}');

  s.stop();
}

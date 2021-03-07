import 'dart:async';
import 'dart:io';

import 'package:yeslist_fill_gallon/yeslist_fill_gallon.dart';

import '../lib/fill_gallon.dart';

Future<void> main(List<String> arguments) async {
  if (arguments.isEmpty) {
    var gallon = createRecipient(
      'Create a gallon: \n\n',
      Gallon(0),
    );

    var bottles = <Bottle>[];

    stdout.writeln();

    var bottle, more;

    do {
      bottle =
          createRecipient('Create a bottle: \n\n', Bottle(0), autofill: true);

      bottles.add(bottle);

      stdout.write('Create more bottle [Y/N] ? ');
      more = stdin.readLineSync().toLowerCase();

      if (more == 'y')
        continue;
      else if (more.isEmpty || more == 'n') break;
    } while (true);

    gallon.fillSource = bottles;

    gallon = run(gallon);

    stdout.write('\n' + 'Gallon: ');
    print(gallon.toJson());

    stdout.write('\n' + 'Bottle(s): \n');
    gallon.fillSource.forEach((element) {
      stdout.write('\t');
      print(element.toJson());
    });
  } else if (arguments[0] == '--help') {
    print('A command line utility for calculating the gallon fill.' + '\n\t');
    print('Usage: ');
    print('\t' + 'dart run fill_gallon.dart [options]');
    print('\t' + 'fill_gallon [options]' + '\n');

    print('Example: \n\t fill_gallon \n\t fill_gallon 1 or 2');
    print('\n' + 'With viable cases: fill_gallon 1 true');
  } else if (arguments[0] == '1' || arguments[0] == '2') {
    example(
        viable: (arguments.length > 1 && arguments[1] == 'true') ? true : false,
        ex: int.parse(arguments[0]));
  } else {
    print('Invalid argument, see --help option.');
  }
}

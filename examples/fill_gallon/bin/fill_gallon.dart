import '../lib/fill_gallon.dart';

Future<void> main(List<String> arguments) async {
  if (arguments.isEmpty) return;

  if (arguments[0] == '--help') {
    print('A command line utility for calculating the gallon fill.' + '\n\t');
    print('Usage: ');
    print('\t' + 'dart run fill_gallon.dart [example]');
    print('\t' + 'fill_gallon [example]' + '\n');

    print('Example: \n\t fill_gallon \n\t fill_gallon 1 or 2');
  } else if (arguments[0] == '1' || arguments[0] == '2') {
    example(int.parse(arguments[0]));
  } else {
    print('Invalid argument, see --help option.');
  }

  //if (!stdout.hasTerminal) exit(0);

  //stdout.write('Gallon capacity: ');

  //var controller = new StreamController.broadcast();
  //stdin.listen(controller.add);
  //return controller.stream;
}

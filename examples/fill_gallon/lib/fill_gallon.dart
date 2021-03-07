import 'dart:io';
import 'package:yeslist_fill_gallon/yeslist_fill_gallon.dart';

void example({bool viable = false, int ex = 2}) {
  var bottlesToFill, gallon, str;

  if (ex == 1) {
    bottlesToFill = <Bottle>[
      Bottle(1),
      Bottle(3),
      Bottle(4.5),
      Bottle(1.5),
      Bottle(3.5)
    ];

    gallon = Gallon(7, fillSource: bottlesToFill);

    str =
        'Example 1: 7L gallon, between 5 bottles: [1L, 3L, 4.5L, 1.5L, 3.5L] answer: [1L, 4.5L, 1.5L], left over 0L;';
  } else if (ex == 2) {
    bottlesToFill = <Bottle>[
      Bottle(1),
      Bottle(3),
      Bottle(4.5),
      Bottle(1.5),
    ];

    gallon = Gallon(5, fillSource: bottlesToFill);

    str =
        'Example 2: 5L gallon, between 4 bottles: [1L, 3L, 4.5L, 1.5L] answer: [1L, 4.5L], left over 0.5L;';
  } else {
    print('>>> ' + 'Example not found !');
    return;
  }

  gallon = run(gallon, str: str, viable: viable);
}

void writeFillOption(Gallon gallon, int i, [bool totalCapacity = true]) {
  stdout.write('[');
  gallon.fillOptions[i].asMap().forEach((ix, value) {
    stdout.write((totalCapacity)
        ? gallon.fillSource[value].label
        : gallon.fillSource[value].volume.toString() + 'l');
    if (ix == gallon.fillOptions[i].length - 1) {
      stdout.write(']');
    } else {
      stdout.write(' ');
    }
  });
}

IRecipient run(Gallon gallon, {bool viable = false, String str = ''}) {
  stdout.writeln();

  centerText(stdout.terminalColumns, 'Yes List Challenge');

  stdout.writeln();

  if (!str.isEmpty) print('\n' + str + '\n');

  var s = Stopwatch()..start();

  gallon
    ..startFillAnalysis()
    ..whereIsOptimal();

  stdout.write('optimal case(s): ' + '\n');

  gallon.optimalFillOptions.forEach((element) {
    stdout.writeln();
    stdout.write('\t');

    gallon.fill(element);

    writeFillOption(gallon, element);
    stdout.write(' ');

    writeFillOption(gallon, element, false);
    stdout.write(' = ' + gallon.restSumList[element].toString() + 'L');
  });

  stdout.write('\n\n');

  if (viable) {
    print('viable cases: ');

    gallon.fillOptions.asMap().forEach((index, value) {
      var i = index;

      if (stdout.terminalColumns > 80) {
        if (i % 3 == 0) {
          stdout.write('\n\t');
          i += 3;
        }
      } else {
        stdout.write('\n\t');
      }

      writeFillOption(gallon, index);

      if (index < gallon.fillOptions.length - 1) {
        stdout.write(', ');
      }
    });
    stdout.write('\n\n');
  }

  print('executed in ${s.elapsed}');

  s.stop();

  return gallon;
}

double doubleInput(String line, double i) {
  if (line.isEmpty) return i;

  var input = double.tryParse(line);

  if (input != null && input > (i - 1)) {
    return input;
  } else {
    print('>>> Insert a positive number <<<');
    return -1;
  }
}

IRecipient createRecipient(String header, IRecipient recipient,
    {bool autofill = false}) {
  var data;

  var input = [
    ['Insert max capacity [1]: ', 1.0],
  ];

  if (!autofill) input.add(['Insert filled volume [0]: ', 0.0]);

  var j = 0;

  stdout.write(header);

  do {
    stdout.write(input[j][0]);

    data = doubleInput(stdin.readLineSync(), input[j][1]);

    if (j > 0 && data > input[j - 1][1]) {
      print('>>> Filled cannot bigger than max capacity <<<');
      continue;
    }

    if (data < 0.0) continue;

    if (j == 0) {
      recipient.capacity = data;
    } else if (j == 1) {
      if (data > 0) recipient.filled = data;
    }

    recipient.label = recipient.capacity.toString();

    if (autofill) recipient.filled = recipient.capacity;

    j++;
  } while (j < input.length);

  return recipient;
}

void centerText(int width, String text, [bool withHr = true]) {
  width = (width > 120) ? 120 : width;
  var len;
  var tempText = text;
  var rec = false;

  if (tempText.length > width) {
    rec = true;
    tempText = text.substring(0, (withHr) ? width - 8 : width);
    text = text.substring((withHr) ? width - 8 : width - 10);
  }

  len = (width - tempText.length) / 2;

  var hr = List.generate(tempText.length + 8, (index) => 61);
  var space =
      List.generate((withHr) ? len.ceil() - 4 : len.ceil(), (index) => 32);

  if (withHr) stdout.write(String.fromCharCodes(space));
  if (withHr) stdout.write(String.fromCharCodes(hr));
  stdout.writeln();
  stdout.write(String.fromCharCodes(space));
  if (withHr) stdout.write('|   ');
  stdout.write(tempText);
  if (withHr) stdout.write('   |');
  if (withHr) stdout.writeln();
  if (withHr) stdout.write(String.fromCharCodes(space));
  if (withHr) stdout.write(String.fromCharCodes(hr));

  if (rec) stdout.writeln();

  if (rec) {
    centerText(width, text, withHr);
    stdout.writeln();
  }
  ;
}

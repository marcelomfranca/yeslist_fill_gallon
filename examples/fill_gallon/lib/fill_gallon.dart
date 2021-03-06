import 'dart:io';
import 'package:yeslist_fill_gallon/yeslist_fill_gallon.dart';

void example({bool viable = true, int ex = 2}) {
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

  centerText(stdout.terminalColumns, 'Yes List Challenge');

  stdout.writeln();

  //centerText(stdout.terminalColumns, str, false);
  print('\n' + str);

  stdout.writeln();

  var s = Stopwatch()..start();

  gallon
    ..startFillAnalysis()
    ..whereIsOptimal();

  stdout.write('optimal case(s): ' + '\n');

  gallon.optimalFillOptions.forEach((element) {
    stdout.writeln();
    stdout.write('\t');

    gallon.fill(element);

    writeFillOption(gallon, bottlesToFill, element);
    stdout.write(' ');

    writeFillOption(gallon, bottlesToFill, element, false);
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

      writeFillOption(gallon, bottlesToFill, index);

      if (index < gallon.fillOptions.length - 1) {
        stdout.write(', ');
      }
    });
    stdout.write('\n\n');
  }

  print('executed in ${s.elapsed}');

  s.stop();
}

void writeFillOption(Gallon gallon, List<Bottle> bottlesToFill, int i,
    [bool totalCapacity = true]) {
  stdout.write('[');
  gallon.fillOptions[i].asMap().forEach((ix, value) {
    stdout.write((totalCapacity)
        ? bottlesToFill[value].label
        : bottlesToFill[value].volume.toString() + 'l');
    if (ix == gallon.fillOptions[i].length - 1) {
      stdout.write(']');
    } else {
      stdout.write(' ');
    }
  });
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

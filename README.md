# Yes List Fill Gallon Library

  This is a dart library created for the Yes List Challenge, see the examples in examples folder.

## Requirements

  To run the source code project please see: https://dart.dev/get-dart

## Example

```
void example() {
  var bottlesToFill = <Bottle>[
     Bottle(1),
     Bottle(3),
     Bottle(4.5),
     Bottle(1.5),
     Bottle(3.5)
  ];

  var gallon = Gallon(7, fillSource: bottlesToFill);

  gallon
    ..startFillAnalysis()
    ..whereIsOptimal();

  stdout.write('\n' + 'Gallon: ');
    print(gallon.toJson());

  stdout.write('\n' + 'Bottle(s): \n');
  gallon.fillSource.forEach((element) {
      stdout.write('\t');
      print(element.toJson());
    });
}
```

# Yes List Challenge

Filling a gallon of water.

  Given a set of water bottles, with different volumes of water, and a gallon of water.

  Create an algorithm, in the language you find best, to choose the bottles to be used to fill the gallon, according to:

  - The gallon must be completely filled with the volume of the bottles;

  - Try to completely empty the chosen bottles;

  - When it is not possible to empty all chosen bottles, leave as little leftover as possible;

Use as few bottles as possible;

  Example 1: 7L gallon, between 5 bottles: [1L, 3L, 4.5L, 1.5L, 3.5L] answer: [1L, 4.5L, 1.5L], left over 0L;
  
  Example 2: 5L gallon, between 4 bottles: [1L, 3L, 4.5L, 1.5L] answer: [1L, 4.5L]; left over 0.5L;

The challenge should allow the user to inform the bottles and the amount of water in the gallon, and then respond with the following result: Bottles used, their volumes and the surplus if any!

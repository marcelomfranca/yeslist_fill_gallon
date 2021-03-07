# Fill Gallon

A sample command-line application using yeslist_fill_gallon library.

## Requirements

  To run the source code project please see: https://dart.dev/get-dart

## Run

from source code:

```
dart run ./bin/fill_gallon.dart
```

from windows:

```
./bin/fill_gallon.exe 
```

from linux:

```
./bin/fill_gallon
```

## Example

Example 1: 7L gallon, between 5 bottles: [1L, 3L, 4.5L, 1.5L, 3.5L] answer: [1L, 4.5L, 1.5L], left over 0L;

```
fill_gallon 1
```

Example 2: 5L gallon, between 4 bottles: [1L, 3L, 4.5L, 1.5L] answer: [1L, 4.5L]; left over 0.5L;

```
fill_gallon 2
```

see '--help' option

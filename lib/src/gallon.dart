import 'dart:io';
import 'dart:math';

import 'recipient.dart';

class Gallon implements IRecipient {
  Gallon(this.capacity,
      {this.fillSource, this.label, this.liquidColor = 'cyan'}) {
    label ??= capacity.toString() + 'l';
  }

  List<double> restSumList = [];
  List<List<int>> fillOptions = [];
  List<int> optimalFillOptions = [];

  @override
  double capacity;
  @override
  bool isEmpty = true;
  @override
  bool isFullFilled = false;

  double _filled = 0.0;
  @override
  double get volume => _filled;
  @override
  void set filled(value) {
    _filled = value;
  }

  @override
  String liquidColor;
  @override
  String label;

  @override
  var fillSource;

  void startFillAnalysis([int k, List<bool> t]) {
    if (fillSource == null || fillSource.isEmpty) {
      throw ArgumentError('No bottle(s) to fill !');
    }

    restSumList = <double>[];
    fillOptions = <List<int>>[];
    optimalFillOptions = <int>[];
    k ??= 0;
    _filled ??= 0.0;
    t ??= List.filled(fillSource.length, null);

    _fillAnalysis(k, t);
  }

  void _fillAnalysis(int k, List<bool> t) {
    if (fillSource == null || fillSource.isEmpty) {
      throw ArgumentError('No bottle(s) to fill !');
    }

    restSumList ??= <double>[];
    fillOptions ??= <List<int>>[];

    var n = fillSource.length;

    if (k == n) {
      var subset = <int>[];
      var sum = 0.0;

      for (var i = 0; i < n; i++) {
        if (t[i] == true) {
          if (fillSource[i].capacity.isNegative ||
              fillSource[i].volume.isNegative) {
            throw FormatException(
                'It\'s not possible exist a bottle with negative volume !');
          }
          subset.add(i);
          sum += fillSource[i].volume;
        }
      }

      if (sum >= (capacity - volume)) {
        fillOptions.add(subset);
        restSumList.add((sum - (capacity - volume)));
      }
    } else {
      t[k] = true;

      _fillAnalysis(k + 1, t);
      t[k] = false; // backtraking

      _fillAnalysis(k + 1, t);
    }
  }

  void whereIsOptimal([double optimal, int startIndex]) {
    if (fillOptions == null || restSumList == null)
      throw Exception('Run fill analysis first !');

    if (fillOptions.isEmpty) {
      print('\n' + 'Fill options not found by criteria !');
      exit(0);
    }

    optimalFillOptions ??= <int>[];

    startIndex ??= 0;
    optimal ??= restSumList.reduce(min);
    var i = -1, sl = -1, osl = -1;

    do {
      i = restSumList.indexWhere((n) {
        return n == optimal;
      }, startIndex);

      if (i < 0) break;

      startIndex = i + 1;
      sl = fillOptions[i].length;

      if ((osl < 0) || sl < osl) {
        optimalFillOptions = [i];
        osl = sl;
      } else if (sl == osl) {
        optimalFillOptions.add(i);
      }
    } while (i < restSumList.length);
  }

  @override
  void fill(int set) {
    if (optimalFillOptions.isEmpty || fillOptions.isEmpty) return;

    if (isFullFilled) empty();
    //  return print('The gallon is full, empty first to refill !');

    //var fillOption = (optimal) ? optimalFillOptions[set] : fillOptions[set];
    var sum;

    fillOptions[set].forEach((el) {
      sum = _filled + fillSource[el].volume;

      if (sum > capacity) {
        fillSource[el].empty(fillSource[el].volume - (sum - capacity));
        _filled = capacity;
      } else {
        fillSource[el].empty();
        _filled = sum;
      }

      //print(fillSource[el].toJson());
    });

    isEmpty = (volume == 0.0);
    isFullFilled = (capacity == volume);
  }

  @override
  void empty([double value]) {
    value ??= volume;

    if (value > capacity || value > volume)
      throw Exception(
          "The value to empty is higher than possible ! Esvaziando...");

    _filled = volume - value;

    isEmpty = (volume == 0.0);
    isFullFilled = (capacity == volume);
  }

  @override
  void draw() {}

  @override
  Map<String, dynamic> toJson() => {
        'capacity': capacity,
        'filled': volume,
        'isFullFilled': isFullFilled,
        'isEmpty': isEmpty,
        'liquidColor': liquidColor,
        'label': label
      };
}

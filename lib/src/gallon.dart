import 'dart:math';

import 'recipient.dart';

class Gallon implements IRecipient {
  Gallon(this.capacity, {this.fillSource});

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
  double get filled => _filled;

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
              fillSource[i].filled.isNegative) {
            throw FormatException(
                'It\'s not possible exist a bottle with negative volume !');
          }
          subset.add(i);
          sum += fillSource[i].filled;
        }
      }

      if (sum >= (capacity - filled)) {
        fillOptions.add(subset);
        restSumList.add((sum - (capacity - filled)));
      }
    } else {
      t[k] = true;

      _fillAnalysis(k + 1, t);
      t[k] = false; // backtraking

      _fillAnalysis(k + 1, t);
    }
  }

  void whereIsOptimal([double optimal, int startIndex]) {
    if (fillOptions == null || restSumList == null) {
      throw Exception('Run fill analysis first !');
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

  // TODO refill choose optimal from fillOptions
  @override
  void fill([int optimalOption]) {
    if (optimalFillOptions.isEmpty) return;

    optimalOption ??= 0;
    isEmpty = false;

    fillOptions[optimalFillOptions[optimalOption]].forEach((el) {
      var sum;
      sum = _filled + fillSource[el].filled;

      if (sum > capacity) {
        fillSource[el].deflate(fillSource[el].filled - (sum - capacity));
        _filled = capacity;
      } else {
        fillSource[el].deflate();
        _filled = sum;
      }
    });

    isFullFilled = (capacity == filled);
  }

  @override
  void deflate([double value]) {}

  @override
  void draw() {}
}

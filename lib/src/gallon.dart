import 'dart:math';

import 'recipient.dart';

class Gallon implements IRecipient {
  Gallon(this.capacity, {this.fillSource});

  List<double> restSumList = [];
  List<List<double>> fillOptions = [];
  List<List<double>> optimalFillOptions = [];

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
      throw Exception('No bottle(s) to fill !');
    }

    restSumList = <double>[];
    fillOptions = <List<double>>[];
    k ??= 0;
    _filled ??= 0.0;
    t ??= List<bool>(fillSource.length);

    _fillAnalysis(k, t);
  }

  void _fillAnalysis(int k, List<bool> t) {
    if (fillSource == null || fillSource.isEmpty) {
      throw Exception('No bottle(s) to fill !');
    }

    restSumList ??= <double>[];
    fillOptions ??= <List<double>>[];

    var n = fillSource.length;

    if (k == n) {
      var subset = <double>[];
      var sum = 0.0;

      for (var i = 0; i < n; i++) {
        if (t[i] == true) {
          if (fillSource[i].capacity.isNegative) {
            throw FormatException(
                'It\'s not possible exist a bottle with negative volume !');
          }
          subset.add(fillSource[i].capacity);
          sum += fillSource[i].capacity;
        }
      }

      if (sum >= capacity) {
        fillOptions.add(subset);
        restSumList.add((sum - capacity));
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
      throw ArgumentError('Run fill analysis first !');
    }

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
        optimalFillOptions = [fillOptions[i]];
        osl = sl;
      } else if (sl == osl) {
        optimalFillOptions.add(fillOptions[i]);
      }
    } while (i < restSumList.length);
  }

  @override
  void fill([int optimalOption]) {
    if (optimalFillOptions.isEmpty) return;

    optimalOption ??= 0;
    var i = 0;

    isEmpty = false;

    _filled = optimalFillOptions[optimalOption].fold(0, (prev, element) {
      var sum = prev + element;

      if (sum > capacity) {
        optimalFillOptions[optimalOption][i] = sum - capacity;
        isFullFilled = true;
        return capacity;
      }

      optimalFillOptions[optimalOption][i] = 0.0;
      i++;

      return sum;
    });
  }

  @override
  void draw() {}
}

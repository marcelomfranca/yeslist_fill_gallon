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
    } else {
      t[k] = true;

      _fillAnalysis(k + 1, t);
      t[k] = false; // backtraking

      _fillAnalysis(k + 1, t);
    }
  }

  void whereIsOptimal([double optimal, int startIndex]) {}

  @override
  void fill([int optimalOption]) {
    if (fillOptions == null || restSumList == null) {
      throw ArgumentError('Run fill analysis first !');
    }
  }

  @override
  void draw() {}
}

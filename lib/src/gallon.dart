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

  void startFillAnalysis([int k, List<bool> t]) {}

  void whereIsOptimal([double optimal, int startIndex]) {}

  @override
  void fill([int optimalOption]) {}

  @override
  void draw() {}
}

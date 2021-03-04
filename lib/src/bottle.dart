import 'recipient.dart';

class Bottle implements IRecipient {
  Bottle(this.capacity, {this.liquidColor, this.label, bool autoFill = true}) {
    label ??= capacity.toString() + 'l';
    if (autoFill) {
      _filled = capacity;
      isFullFilled = true;
      isEmpty = false;
    }
  }

  @override
  double capacity;
  @override
  bool isEmpty = true;
  @override
  bool isFullFilled = false;
  @override
  var fillSource;

  double _filled = 0.0;
  @override
  double get filled => _filled;

  String liquidColor = 'cyan';
  String label = '';

  @override
  void fill() {}

  @override
  void draw() {}
}

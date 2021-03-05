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
  void deflate([double value]) {
    value ??= filled;

    _filled = (value > filled) ? 0.0 : filled - value;

    if (filled == 0) {
      isEmpty = true;
      isFullFilled = false;
    }

    if (value > filled) {
      throw Exception(
          "The value to deflate is higher than possible ! Esvaziando...");
    }
  }

  @override
  void draw() {}
}

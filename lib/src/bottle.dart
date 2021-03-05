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
  void empty([double value]) {
    value ??= filled;

    _filled = (value > filled) ? 0.0 : filled - value;

    isEmpty = (filled == 0.0);
    isFullFilled = (capacity == filled);

    if (value > filled) {
      throw Exception(
          "The value to deflate is higher than possible ! Esvaziando...");
    }
  }

  @override
  void draw() {}
}

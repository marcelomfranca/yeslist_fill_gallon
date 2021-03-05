import 'recipient.dart';

class Bottle implements IRecipient {
  Bottle(this.capacity,
      {this.liquidColor = 'cyan', this.label, bool autoFill = true}) {
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

  String liquidColor;
  String label;

  @override
  void fill() {}

  @override
  void empty([double value]) {
    value ??= filled;

    if (value > capacity || value > filled)
      return print(
          "The value to empty is higher than possible ! Esvaziando...");

    _filled = filled - value;

    isEmpty = (filled == 0.0);
    isFullFilled = (capacity == filled);
  }

  @override
  void draw() {}

  @override
  Map<String, dynamic> toJson() => {
        'capacity': capacity,
        'filled': filled,
        'isEmpty': isEmpty,
        'isFullFilled': isFullFilled,
        'liquidColor': liquidColor,
        'label': label
      };
}

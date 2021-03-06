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
  double get volume => _filled;

  String liquidColor;
  String label;

  @override
  void fill(int set) {}

  @override
  void empty([double value]) {
    value ??= volume;

    if (value > capacity || value > volume)
      return print(
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

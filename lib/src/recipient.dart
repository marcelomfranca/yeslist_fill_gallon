abstract class IRecipient {
  double capacity;
  bool isEmpty;
  bool isFullFilled;
  var fillSource;

  double get filled;

  void fill() {}
  void empty([double value]) {}
  void draw() {}
}

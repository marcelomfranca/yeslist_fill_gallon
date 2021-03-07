abstract class IRecipient {
  double capacity;
  bool isEmpty;
  bool isFullFilled;
  String liquidColor;
  String label;
  var fillSource;

  double get volume;
  void set filled(value);

  void fill(int set) {}
  void empty([double value]) {}
  void draw() {}
  Map<String, dynamic> toJson() {}
}

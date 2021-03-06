abstract class IRecipient {
  double capacity;
  bool isEmpty;
  bool isFullFilled;
  var fillSource;

  double get volume;

  void fill(int set) {}
  void empty([double value]) {}
  void draw() {}
  Map<String, dynamic> toJson() {}
}

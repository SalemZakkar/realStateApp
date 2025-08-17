class City {
  String name;
  String id;

  City({required this.name, required this.id});

  @override
  bool operator ==(Object other) {
    return other is City && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

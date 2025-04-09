class Place {
  final String name;
  final String level2Address;

  Place({
    required this.name,
    required this.level2Address,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Place &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          level2Address == other.level2Address;

  @override
  int get hashCode => name.hashCode ^ level2Address.hashCode;
}

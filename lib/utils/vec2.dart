class Vec2 {
  final double x;
  final double y;

  const Vec2(this.x, this.y);

  Vec2 zero() {
    return Vec2(0, 0);
  }

  void add(Vec2 other) {
    x + other.x;
    y + other.y;
  }

  @override
  String toString() {
    return "x: $x, y: $y";
  }
}

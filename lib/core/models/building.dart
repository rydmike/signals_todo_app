import 'package:flutter/foundation.dart';
import 'package:signals/signals_flutter.dart';

final building = signal(
  const Building(name: 'MyHome', description: 'Private house', area: 240),
);

@immutable
class Building {
  const Building({
    required this.name,
    required this.description,
    this.ventOn = false,
    this.area = 0.0,
    this.roomHeight = 2.4,
  });

  final String name;
  final String description;
  final bool ventOn;
  final double area;
  final double roomHeight;

  double get volume => area * roomHeight;
  // get volume => signal(area * roomHeight);

  Building copyWith({
    String? name,
    String? description,
    bool? ventOn,
    double? area,
    double? roomHeight,
  }) {
    return Building(
      name: name ?? this.name,
      description: description ?? this.description,
      ventOn: ventOn ?? this.ventOn,
      area: area ?? this.area,
      roomHeight: roomHeight ?? this.roomHeight,
    );
  }

  @override
  String toString() {
    return 'Todo{name: $name, description: $description, ventOn: $ventOn}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Building &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          description == other.description &&
          ventOn == other.ventOn &&
          area == other.area &&
          roomHeight == other.roomHeight;

  @override
  int get hashCode =>
      name.hashCode ^
      description.hashCode ^
      ventOn.hashCode ^
      area.hashCode ^
      roomHeight.hashCode;
}

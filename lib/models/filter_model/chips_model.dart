import 'package:flutter/material.dart';

class FilterChipData {
  final String label;
  final Color color;
  final int id;
  final bool isSelected;

  const FilterChipData({
    required this.label,
    required this.color,
    required this.id,
    this.isSelected = false,
  });

  FilterChipData copy({
    String? label,
    Color? color,
    int? id,
    bool? isSelected,
  }) =>
      FilterChipData(
        label: label ?? this.label,
        id: id ?? this.id,
        color: color ?? this.color,
        isSelected: isSelected ?? this.isSelected,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterChipData &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          color == other.color &&
          id == other.id &&
          isSelected == other.isSelected;

  @override
  int get hashCode =>
      label.hashCode ^ color.hashCode ^ isSelected.hashCode ^ id.hashCode;
}

class FilterChipAttributeData {
  final String image;
  final Color color;
  final int id;
  final bool isSelected;

  const FilterChipAttributeData({
    required this.image,
    required this.color,
    required this.id,
    this.isSelected = false,
  });

  FilterChipAttributeData copy({
    String? image,
    Color? color,
    int? id,
    bool? isSelected,
  }) =>
      FilterChipAttributeData(
        image: image ?? this.image,
        id: id ?? this.id,
        color: color ?? this.color,
        isSelected: isSelected ?? this.isSelected,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterChipAttributeData &&
          runtimeType == other.runtimeType &&
          image == other.image &&
          color == other.color &&
          id == other.id &&
          isSelected == other.isSelected;

  @override
  int get hashCode =>
      image.hashCode ^ color.hashCode ^ isSelected.hashCode ^ id.hashCode;
}

import 'package:flutter/material.dart';

class SelectItemModel {
  final dynamic value;
  final dynamic addedValue;
  final String title;
  final String? subtitle;
  final Widget? trailing;

  SelectItemModel({
    this.value,
    this.addedValue,
    required this.title,
    this.subtitle,
    this.trailing,
  });
}

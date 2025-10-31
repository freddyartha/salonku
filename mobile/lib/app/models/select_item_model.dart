import 'package:flutter/material.dart';

class SelectItemModel {
  final dynamic value;
  final String title;
  final String? subtitle;
  final Widget? trailing;

  SelectItemModel({
    this.value,
    required this.title,
    this.subtitle,
    this.trailing,
  });
}

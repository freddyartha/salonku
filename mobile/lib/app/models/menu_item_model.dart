import 'package:flutter/material.dart';

class MenuItemModel {
  final int? id;
  final String? title;
  final String? subtitle;
  final IconData? icon;
  final String? imageLocation;
  final GestureTapCallback? onTab;
  final GlobalKey? globalKey;
  final dynamic value;

  MenuItemModel({
    this.id,
    this.title,
    this.subtitle,
    this.icon,
    this.imageLocation,
    this.onTab,
    this.globalKey,
    this.value,
  });
}

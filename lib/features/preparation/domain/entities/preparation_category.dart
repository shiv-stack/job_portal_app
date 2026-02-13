import 'package:flutter/material.dart';

class PreparationCategory {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String route;

  const PreparationCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.route,
  });
}

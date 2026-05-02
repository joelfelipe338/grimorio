import 'package:flutter/material.dart';

class AppColors {
  // Base
  static const bg = Color(0xFF1a1210);
  static const surface = Color(0xFF2a1f1a);
  static const surfaceLight = Color(0xFF3a2e26);
  static const surfaceHighlight = Color(0xFF4a3d33);

  // Accents
  static const gold = Color(0xFFd4a856);
  static const goldLight = Color(0xFFe8c878);
  static const goldDim = Color(0xFF8a7040);
  static const copper = Color(0xFFb87333);

  // Text
  static const textPrimary = Color(0xFFf0e6d3);
  static const textSecondary = Color(0xFFc4b59a);
  static const textDim = Color(0xFF8a7e6e);

  // Borders
  static const border = Color(0xFF4a3d33);
  static const borderGold = Color(0xFF6e5c30);

  // Status
  static const error = Color(0xFFe74c3c);
  static const success = Color(0xFF27ae60);
}

const schoolColors = <String, Color>{
  'Abjuração': Color(0xFF4a90d9),
  'Adivinhação': Color(0xFF9b59b6),
  'Conjuração': Color(0xFF27ae60),
  'Encantamento': Color(0xFFe74c8b),
  'Evocação': Color(0xFFe67e22),
  'Ilusão': Color(0xFF1abc9c),
  'Necromancia': Color(0xFF7f8c8d),
  'Transmutação': Color(0xFFf1c40f),
};

const traditionColors = <String, Color>{
  'arcana': Color(0xFF5b7dcc),
  'divina': Color(0xFFe8c84a),
  'ocultista': Color(0xFF9b59b6),
  'primal': Color(0xFF27ae60),
};

const schoolIcons = <String, String>{
  'Abjuração': '🛡️',
  'Adivinhação': '👁️',
  'Conjuração': '✨',
  'Encantamento': '💫',
  'Evocação': '🔥',
  'Ilusão': '🌀',
  'Necromancia': '💀',
  'Transmutação': '🔄',
};

const traditionIcons = <String, String>{
  'arcana': '📘',
  'divina': '📙',
  'ocultista': '📕',
  'primal': '📗',
};

Color getLevelColor(int level) {
  if (level <= 3) return const Color(0xFF27ae60);
  if (level <= 6) return const Color(0xFFe8c84a);
  return const Color(0xFFe74c3c);
}

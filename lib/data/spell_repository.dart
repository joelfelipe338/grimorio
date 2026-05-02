import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/spell.dart';

class SpellRepository {
  static List<Spell>? _cache;

  static Future<List<Spell>> loadSpells() async {
    if (_cache != null) return _cache!;
    final jsonStr = await rootBundle.loadString('assets/data/spells.json');
    final List<dynamic> jsonList = json.decode(jsonStr) as List<dynamic>;
    _cache = jsonList
        .map((e) => Spell.fromJson(e as Map<String, dynamic>))
        .toList();
    return _cache!;
  }
}

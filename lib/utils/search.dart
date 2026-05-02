import '../models/spell.dart';

String removeDiacritics(String str) {
  const diacritics =
      'ÀÁÂÃÄÅàáâãäåÈÉÊËèéêëÌÍÎÏìíîïÒÓÔÕÖòóôõöÙÚÛÜùúûüÇçÑñÝýÿ';
  const replacements =
      'AAAAAAaaaaaaEEEEeeeeIIIIiiiiOOOOOoooooUUUUuuuuCcNnYyy';
  var result = str;
  for (var i = 0; i < diacritics.length; i++) {
    result = result.replaceAll(diacritics[i], replacements[i]);
  }
  return result.toLowerCase();
}

List<Spell> filterSpells(
  List<Spell> all,
  String query,
  Set<int> levels,
  Set<String> traditions,
  Set<String> schools,
  Set<String> types,
) {
  var results = all;

  if (query.trim().isNotEmpty) {
    final q = removeDiacritics(query.trim());
    results = results.where((s) {
      final searchable = [
        s.name,
        s.school,
        s.description,
        ...s.traits,
        ...s.traditions,
      ].join(' ');
      return removeDiacritics(searchable).contains(q);
    }).toList();
  }

  if (levels.isNotEmpty) {
    results = results.where((s) => levels.contains(s.level)).toList();
  }

  if (traditions.isNotEmpty) {
    results =
        results.where((s) => s.traditions.any(traditions.contains)).toList();
  }

  if (schools.isNotEmpty) {
    results = results.where((s) => schools.contains(s.school)).toList();
  }

  if (types.isNotEmpty) {
    results = results.where((s) => types.contains(s.type)).toList();
  }

  return results;
}

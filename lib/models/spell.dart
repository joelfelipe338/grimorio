class Spell {
  final String id;
  final String name;
  final int level;
  final String type;
  final String school;
  final String rarity;
  final List<String> traits;
  final List<String> traditions;
  final String execution;
  final String trigger;
  final String requirements;
  final String range;
  final String area;
  final String targets;
  final String duration;
  final String save;
  final String description;
  final String results;
  final String heightened;
  final String cost;
  final String secondaryCasters;
  final String primaryCheck;
  final String secondaryChecks;
  final String domain;
  final List<List<List<String>>> tables;

  const Spell({
    required this.id,
    required this.name,
    required this.level,
    required this.type,
    required this.school,
    required this.rarity,
    required this.traits,
    required this.traditions,
    required this.execution,
    required this.trigger,
    required this.requirements,
    required this.range,
    required this.area,
    required this.targets,
    required this.duration,
    required this.save,
    required this.description,
    required this.results,
    required this.heightened,
    required this.cost,
    required this.secondaryCasters,
    required this.primaryCheck,
    required this.secondaryChecks,
    required this.domain,
    required this.tables,
  });

  factory Spell.fromJson(Map<String, dynamic> json) {
    return Spell(
      id: json['id'] as String,
      name: json['name'] as String,
      level: json['level'] as int,
      type: json['type'] as String,
      school: json['school'] as String,
      rarity: json['rarity'] as String,
      traits: List<String>.from(json['traits'] as List),
      traditions: List<String>.from(json['traditions'] as List),
      execution: json['execution'] as String,
      trigger: (json['trigger'] as String?) ?? '',
      requirements: (json['requirements'] as String?) ?? '',
      range: json['range'] as String,
      area: json['area'] as String,
      targets: json['targets'] as String,
      duration: json['duration'] as String,
      save: json['save'] as String,
      description: json['description'] as String,
      results: json['results'] as String,
      heightened: json['heightened'] as String,
      cost: (json['cost'] as String?) ?? '',
      secondaryCasters: (json['secondary_casters'] as String?) ?? '',
      primaryCheck: (json['primary_check'] as String?) ?? '',
      secondaryChecks: (json['secondary_checks'] as String?) ?? '',
      domain: (json['domain'] as String?) ?? '',
      tables: ((json['tables'] as List?) ?? const [])
          .map((t) => (t as List)
              .map((row) =>
                  (row as List).map((c) => (c ?? '').toString()).toList())
              .toList())
          .toList(),
    );
  }
}

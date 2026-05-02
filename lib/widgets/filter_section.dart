import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class FilterSection extends StatelessWidget {
  final Set<int> selectedLevels;
  final Set<String> selectedTraditions;
  final Set<String> selectedSchools;
  final Set<String> selectedTypes;
  final String? expandedFilter;
  final ValueChanged<String?> onExpandedChanged;
  final ValueChanged<int> onLevelToggle;
  final ValueChanged<String> onTraditionToggle;
  final ValueChanged<String> onSchoolToggle;
  final ValueChanged<String> onTypeToggle;
  final VoidCallback onClearAll;

  const FilterSection({
    super.key,
    required this.selectedLevels,
    required this.selectedTraditions,
    required this.selectedSchools,
    required this.selectedTypes,
    required this.expandedFilter,
    required this.onExpandedChanged,
    required this.onLevelToggle,
    required this.onTraditionToggle,
    required this.onSchoolToggle,
    required this.onTypeToggle,
    required this.onClearAll,
  });

  bool get _hasFilters =>
      selectedLevels.isNotEmpty ||
      selectedTraditions.isNotEmpty ||
      selectedSchools.isNotEmpty ||
      selectedTypes.isNotEmpty;

  static const List<({String label, String value})> _typeOptions = [
    (label: 'Magia', value: 'MAGIA'),
    (label: 'Truque', value: 'TRUQUE MÁGICO'),
    (label: 'Foco', value: 'MAGIA DE FOCO'),
    (label: 'Ritual', value: 'RITUAL'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Toggle row
        SizedBox(
          height: 44,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _FilterToggle(
                label:
                    '⚔️ Nível${selectedLevels.isNotEmpty ? ' (${selectedLevels.length})' : ''}',
                active: expandedFilter == 'level',
                onTap: () => onExpandedChanged(
                    expandedFilter == 'level' ? null : 'level'),
              ),
              const SizedBox(width: 8),
              _FilterToggle(
                label:
                    '📖 Tradição${selectedTraditions.isNotEmpty ? ' (${selectedTraditions.length})' : ''}',
                active: expandedFilter == 'tradition',
                onTap: () => onExpandedChanged(
                    expandedFilter == 'tradition' ? null : 'tradition'),
              ),
              const SizedBox(width: 8),
              _FilterToggle(
                label:
                    '🏛️ Escola${selectedSchools.isNotEmpty ? ' (${selectedSchools.length})' : ''}',
                active: expandedFilter == 'school',
                onTap: () => onExpandedChanged(
                    expandedFilter == 'school' ? null : 'school'),
              ),
              const SizedBox(width: 8),
              _FilterToggle(
                label:
                    '✨ Tipo${selectedTypes.isNotEmpty ? ' (${selectedTypes.length})' : ''}',
                active: expandedFilter == 'type',
                onTap: () => onExpandedChanged(
                    expandedFilter == 'type' ? null : 'type'),
              ),
              if (_hasFilters) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onClearAll,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: AppColors.error.withValues(alpha: 0.5)),
                    ),
                    child: const Text(
                      'Limpar ✕',
                      style: TextStyle(color: AppColors.error, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),

        // Expanded chips
        if (expandedFilter == 'level')
          _ChipRow(
            children: List.generate(10, (i) {
              final level = i + 1;
              final color = getLevelColor(level);
              return _FilterChip(
                label: '$level',
                selected: selectedLevels.contains(level),
                color: color,
                onTap: () => onLevelToggle(level),
              );
            }),
          ),

        if (expandedFilter == 'tradition')
          _ChipRow(
            children: ['arcana', 'divina', 'ocultista', 'primal'].map((t) {
              final color = traditionColors[t] ?? AppColors.textDim;
              return _FilterChip(
                label: t[0].toUpperCase() + t.substring(1),
                selected: selectedTraditions.contains(t),
                color: color,
                onTap: () => onTraditionToggle(t),
              );
            }).toList(),
          ),

        if (expandedFilter == 'school')
          _ChipRow(
            children: [
              'Abjuração',
              'Adivinhação',
              'Conjuração',
              'Encantamento',
              'Evocação',
              'Ilusão',
              'Necromancia',
              'Transmutação'
            ].map((s) {
              final color = schoolColors[s] ?? AppColors.textDim;
              return _FilterChip(
                label: s,
                selected: selectedSchools.contains(s),
                color: color,
                onTap: () => onSchoolToggle(s),
              );
            }).toList(),
          ),

        if (expandedFilter == 'type')
          _ChipRow(
            children: _typeOptions.map((opt) {
              return _FilterChip(
                label: opt.label,
                selected: selectedTypes.contains(opt.value),
                color: AppColors.gold,
                onTap: () => onTypeToggle(opt.value),
              );
            }).toList(),
          ),
      ],
    );
  }
}

class _FilterToggle extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _FilterToggle({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: active
              ? AppColors.gold.withValues(alpha: 0.2)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(color: active ? AppColors.gold : AppColors.border),
        ),
        child: Text(
          label,
          style: GoogleFonts.crimsonText(
            color: active ? AppColors.gold : AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _ChipRow extends StatelessWidget {
  final List<Widget> children;
  const _ChipRow({required this.children});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            children[i],
          ],
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? color.withValues(alpha: 0.3)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(color: selected ? color : AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected)
              Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            Text(
              label,
              style: GoogleFonts.crimsonText(
                color: selected ? color : AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

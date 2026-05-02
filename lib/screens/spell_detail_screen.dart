import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/spell.dart';
import '../theme/app_theme.dart';
import '../widgets/info_row.dart';

class SpellDetailScreen extends StatelessWidget {
  final Spell spell;

  const SpellDetailScreen({super.key, required this.spell});

  @override
  Widget build(BuildContext context) {
    final sc = schoolColors[spell.school] ?? AppColors.gold;
    final lc = getLevelColor(spell.level);
    final icon = schoolIcons[spell.school] ?? '✨';

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Back button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Text(
                    '← Voltar',
                    style: GoogleFonts.crimsonText(
                      color: AppColors.gold,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // Header card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border, width: 1),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(width: 4, color: sc),
                      Expanded(
                        child: Column(
                  children: [
                    // Ornamental bar
                    Container(height: 3, color: sc),

                    // Icon
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 12),
                      child: Text(
                        icon,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),

                    // Name
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        spell.name,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cinzel(
                          color: AppColors.textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Level + School badges
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: lc.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: lc, width: 1.5),
                          ),
                          child: Text(
                            switch (spell.type) {
                              'TRUQUE MÁGICO' => 'Truque ${spell.level}',
                              'MAGIA DE FOCO' => 'Foco ${spell.level}',
                              'RITUAL' => 'Ritual ${spell.level}',
                              _ => 'Nível ${spell.level}',
                            },
                            style: GoogleFonts.cinzel(
                              color: lc,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (spell.school.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: sc.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                  color: sc.withValues(alpha: 0.5), width: 1.5),
                            ),
                            child: Text(
                              spell.school,
                              style: GoogleFonts.cinzel(
                                color: sc,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Traditions
                    if (spell.traditions.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 8,
                          runSpacing: 8,
                          children: spell.traditions.map((t) {
                            final tc =
                                traditionColors[t] ?? AppColors.textDim;
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: tc.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: tc.withValues(alpha: 0.5)),
                              ),
                              child: Text(
                                t[0].toUpperCase() + t.substring(1),
                                style: GoogleFonts.crimsonText(
                                  color: tc,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                    // Traits
                    if (spell.traits.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 12),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 8,
                          runSpacing: 8,
                          children: spell.traits.map((tr) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.gold.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color:
                                        AppColors.goldDim.withValues(alpha: 0.4)),
                              ),
                              child: Text(
                                tr,
                                style: GoogleFonts.crimsonText(
                                  color: AppColors.goldLight,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                    // Rarity
                    if (spell.rarity != 'comum')
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                              color: spell.rarity == 'raro'
                                  ? const Color(0xFF3498db).withValues(alpha: 0.2)
                                  : const Color(0xFFe67e22).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: spell.rarity == 'raro'
                                      ? const Color(0xFF3498db)
                                      : const Color(0xFFe67e22)),
                            ),
                            child: Text(
                              spell.rarity.toUpperCase(),
                              style: GoogleFonts.cinzel(
                                color: spell.rarity == 'raro'
                                    ? const Color(0xFF3498db)
                                    : const Color(0xFFe67e22),
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
                    ],
                  ),
                ),
              ),

              // Info sections
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    InfoRow(
                        icon: '⚡', label: 'Execução', value: spell.execution),
                    const SizedBox(height: 8),
                    InfoRow(
                        icon: '🔔', label: 'Acionamento', value: spell.trigger),
                    const SizedBox(height: 8),
                    InfoRow(
                        icon: '📋', label: 'Requerimentos', value: spell.requirements),
                    const SizedBox(height: 8),
                    InfoRow(
                        icon: '📏', label: 'Distância', value: spell.range),
                    const SizedBox(height: 8),
                    InfoRow(icon: '🎯', label: 'Área', value: spell.area),
                    const SizedBox(height: 8),
                    InfoRow(icon: '👤', label: 'Alvos', value: spell.targets),
                    const SizedBox(height: 8),
                    InfoRow(
                        icon: '⏱️', label: 'Duração', value: spell.duration),
                    const SizedBox(height: 8),
                    InfoRow(
                        icon: '🛡️', label: 'Salvamento', value: spell.save),
                    const SizedBox(height: 8),
                    InfoRow(icon: '💰', label: 'Custo', value: spell.cost),
                    const SizedBox(height: 8),
                    InfoRow(
                        icon: '👥',
                        label: 'Conjuradores Secundários',
                        value: spell.secondaryCasters),
                    const SizedBox(height: 8),
                    InfoRow(
                        icon: '🎲',
                        label: 'Teste Primário',
                        value: spell.primaryCheck),
                    const SizedBox(height: 8),
                    InfoRow(
                        icon: '🎯',
                        label: 'Testes Secundários',
                        value: spell.secondaryChecks),
                    const SizedBox(height: 8),
                    InfoRow(
                        icon: '⛪', label: 'Domínio', value: spell.domain),
                  ],
                ),
              ),

              // Description
              if (spell.description.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _HighlightedSectionCard(
                    icon: '📜',
                    label: 'Descrição',
                    text: _breakSentences(spell.description),
                  ),
                ),

              // Results
              if (spell.results.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _ResultsCard(results: spell.results),
                ),

              // Heightened
              if (spell.heightened.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _HeightenedCard(heightened: spell.heightened),
                ),

              // Tables (last)
              for (final table in spell.tables)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _SpellTableCard(rows: table),
                ),

            ],
          ),
        ),
      ),
    );
  }
}

class _SpellTableCard extends StatelessWidget {
  final List<List<String>> rows;

  const _SpellTableCard({required this.rows});

  @override
  Widget build(BuildContext context) {
    if (rows.length < 2) return const SizedBox.shrink();
    const accent = AppColors.copper;
    final header = rows.first;
    final body = rows.skip(1).toList();
    final colCount = header.length;

    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.borderGold, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                const Text('📊', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Text(
                  'TABELA',
                  style: GoogleFonts.cinzel(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Table(
              border: TableBorder.all(
                color: accent.withValues(alpha: 0.25),
                width: 0.5,
              ),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                for (var c = 0; c < colCount; c++) c: const FlexColumnWidth(),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.25),
                  ),
                  children: [
                    for (var c = 0; c < colCount; c++)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Text(
                          header[c].replaceAll('\n', ' '),
                          style: GoogleFonts.cinzel(
                            color: accent,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                  ],
                ),
                for (var i = 0; i < body.length; i++)
                  TableRow(
                    decoration: BoxDecoration(
                      color: i.isEven
                          ? accent.withValues(alpha: 0.04)
                          : accent.withValues(alpha: 0.10),
                    ),
                    children: [
                      for (var c = 0; c < colCount; c++)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: Text(
                            c < body[i].length
                                ? body[i][c].replaceAll('\n', ' ')
                                : '',
                            style: GoogleFonts.crimsonText(
                              color: AppColors.textPrimary,
                              fontSize: 13,
                              height: 1.35,
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HighlightedSectionCard extends StatelessWidget {
  final String icon;
  final String label;
  final String text;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? labelColor;
  final Color? textColor;

  const _HighlightedSectionCard({
    required this.icon,
    required this.label,
    required this.text,
    this.backgroundColor,
    this.borderColor,
    this.labelColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor ?? AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.borderGold, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                Text(icon, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Text(
                  label.toUpperCase(),
                  style: GoogleFonts.cinzel(
                    color: labelColor ?? AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text.rich(_highlightedText(
            text,
            baseColor: textColor ?? AppColors.textPrimary,
            fontSize: 14,
            height: 1.71,
          )),
        ],
      ),
    );
  }
}

// Insert a line break after every sentence-ending period (". " → ".\n")
// and two line breaks before every bullet "•".
String _breakSentences(String text) => text
    .replaceAll('. ', '.\n')
    .replaceAll(RegExp(r'\s*•\s*'), '\n\n• ')
    .replaceAll(RegExp(r'^\n+'), '');

// Highlights dice rolls (1d10+4, 2d6) and bonuses (+2, -1, –1) in text
final _dicePattern = RegExp(r'\d+d\d+(?:\s*[+\-–]\s*\d+)?|[+\-–]\d+');

TextSpan _highlightedText(String text, {
  required Color baseColor,
  double fontSize = 14,
  double height = 1.6,
}) {
  final matches = _dicePattern.allMatches(text).toList();
  if (matches.isEmpty) {
    return TextSpan(
      text: text,
      style: GoogleFonts.crimsonText(color: baseColor, fontSize: fontSize, height: height),
    );
  }

  final spans = <InlineSpan>[];
  var lastEnd = 0;
  for (final m in matches) {
    if (m.start > lastEnd) {
      spans.add(TextSpan(
        text: text.substring(lastEnd, m.start),
        style: GoogleFonts.crimsonText(color: baseColor, fontSize: fontSize, height: height),
      ));
    }
    spans.add(WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: AppColors.gold.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.goldDim.withValues(alpha: 0.5), width: 0.5),
        ),
        child: Text(
          m.group(0)!,
          style: GoogleFonts.cinzel(
            color: AppColors.goldLight,
            fontSize: fontSize - 2,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ));
    lastEnd = m.end;
  }
  if (lastEnd < text.length) {
    spans.add(TextSpan(
      text: text.substring(lastEnd),
      style: GoogleFonts.crimsonText(color: baseColor, fontSize: fontSize, height: height),
    ));
  }
  return TextSpan(children: spans);
}

class _ResultsCard extends StatelessWidget {
  final String results;

  const _ResultsCard({required this.results});

  static const _icons = {
    'Sucesso Crítico': '⭐',
    'Sucesso': '✅',
    'Falha': '❌',
    'Falha Crítica': '💀',
  };

  static const _colors = {
    'Sucesso Crítico': Color(0xFF2ecc71),
    'Sucesso': Color(0xFF27ae60),
    'Falha': Color(0xFFe67e22),
    'Falha Crítica': Color(0xFFe74c3c),
  };

  List<MapEntry<String, String>> _parse() {
    final text = results;
    // Use regex to find labels, prioritizing longer matches (Crítico variants)
    final pattern = RegExp(r'(Sucesso Crítico|Falha Crítica|Sucesso|Falha)');
    final matches = pattern.allMatches(text).toList();

    if (matches.isEmpty) {
      return [MapEntry('', text)];
    }

    final entries = <MapEntry<String, String>>[];
    for (var i = 0; i < matches.length; i++) {
      final label = matches[i].group(0)!;
      final contentStart = matches[i].end;
      final contentEnd = i + 1 < matches.length ? matches[i + 1].start : text.length;
      entries.add(MapEntry(label, text.substring(contentStart, contentEnd).trim()));
    }
    return entries;
  }

  @override
  Widget build(BuildContext context) {
    final entries = _parse();

    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.copper.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.borderGold, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                const Text('🎲', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Text(
                  'RESULTADOS',
                  style: GoogleFonts.cinzel(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < entries.length; i++) ...[
            if (i > 0) const SizedBox(height: 8),
            if (entries[i].key.isNotEmpty)
              _ResultEntry(
                label: entries[i].key,
                text: entries[i].value,
                icon: _icons[entries[i].key] ?? '🎲',
                color: _colors[entries[i].key] ?? AppColors.textSecondary,
              )
            else
              Text.rich(_highlightedText(
                entries[i].value,
                baseColor: AppColors.textPrimary,
                fontSize: 14,
                height: 1.71,
              )),
          ],
        ],
      ),
    );
  }
}

class _ResultEntry extends StatelessWidget {
  final String label;
  final String text;
  final String icon;
  final Color color;

  const _ResultEntry({
    required this.label,
    required this.text,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 6),
              Text(
                label.toUpperCase(),
                style: GoogleFonts.cinzel(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text.rich(_highlightedText(
            text,
            baseColor: AppColors.textPrimary,
            fontSize: 14,
            height: 1.6,
          )),
        ],
      ),
    );
  }
}


class _HeightenedCard extends StatelessWidget {
  final String heightened;

  const _HeightenedCard({required this.heightened});

  List<MapEntry<String, String>> _parse() {
    final pattern = RegExp(r'Elevad[ao]\s*\([^)]+\)');
    final matches = pattern.allMatches(heightened).toList();

    if (matches.isEmpty) {
      return [MapEntry('', heightened)];
    }

    final entries = <MapEntry<String, String>>[];
    for (var i = 0; i < matches.length; i++) {
      final label = matches[i].group(0)!;
      final contentStart = matches[i].end;
      final contentEnd =
          i + 1 < matches.length ? matches[i + 1].start : heightened.length;
      entries.add(MapEntry(label, heightened.substring(contentStart, contentEnd).trim()));
    }
    return entries;
  }

  @override
  Widget build(BuildContext context) {
    final entries = _parse();

    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.gold.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.goldDim.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.borderGold, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                const Text('⬆️', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Text(
                  'ELEVADA',
                  style: GoogleFonts.cinzel(
                    color: AppColors.gold,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < entries.length; i++) ...[
            if (i > 0) const SizedBox(height: 8),
            if (entries[i].key.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.goldDim.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('⬆️', style: TextStyle(fontSize: 14)),
                        const SizedBox(width: 6),
                        Text(
                          entries[i].key.toUpperCase(),
                          style: GoogleFonts.cinzel(
                            color: AppColors.gold,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text.rich(_highlightedText(
                      _breakSentences(entries[i].value),
                      baseColor: AppColors.goldLight,
                      fontSize: 14,
                      height: 1.6,
                    )),
                  ],
                ),
              )
            else
              Text.rich(_highlightedText(
                _breakSentences(entries[i].value),
                baseColor: AppColors.goldLight,
                fontSize: 14,
                height: 1.71,
              )),
          ],
        ],
      ),
    );
  }
}

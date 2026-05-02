import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/spell.dart';
import '../theme/app_theme.dart';

class SpellCard extends StatelessWidget {
  final Spell spell;
  final VoidCallback onTap;

  const SpellCard({super.key, required this.spell, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final sc = schoolColors[spell.school] ?? AppColors.textDim;
    final lc = getLevelColor(spell.level);
    final icon = schoolIcons[spell.school] ?? '✨';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border, width: 1),
                ),
                padding: const EdgeInsets.only(left: 20, top: 16, right: 16, bottom: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header: name + level
                    Row(
                      children: [
                        Text(icon, style: const TextStyle(fontSize: 16)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            spell.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.cinzel(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: lc.withValues(alpha: 0.25),
                            shape: BoxShape.circle,
                            border: Border.all(color: lc, width: 1.5),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${spell.level}',
                            style: GoogleFonts.cinzel(
                              color: lc,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Meta tags
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: [
                        if (spell.school.isNotEmpty)
                          _Tag(
                              label: spell.school,
                              color: sc),
                        ...spell.traditions.map((t) => _Tag(
                              label: t,
                              color: traditionColors[t] ?? AppColors.textDim,
                            )),
                        if (spell.rarity != 'comum')
                          _Tag(
                            label: spell.rarity,
                            color: spell.rarity == 'raro'
                                ? const Color(0xFF3498db)
                                : const Color(0xFFe67e22),
                            bold: true,
                          ),
                      ],
                    ),

                    // Traits
                    if (spell.traits.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: [
                          ...spell.traits.take(4).map((tr) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 1),
                                decoration: BoxDecoration(
                                  color: AppColors.gold.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color:
                                          AppColors.goldDim.withValues(alpha: 0.4),
                                      width: 0.5),
                                ),
                                child: Text(
                                  tr,
                                  style: const TextStyle(
                                    color: AppColors.goldDim,
                                    fontSize: 10,
                                  ),
                                ),
                              )),
                          if (spell.traits.length > 4)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 1),
                              decoration: BoxDecoration(
                                color: AppColors.gold.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color:
                                        AppColors.goldDim.withValues(alpha: 0.4),
                                    width: 0.5),
                              ),
                              child: Text(
                                '+${spell.traits.length - 4}',
                                style: const TextStyle(
                                  color: AppColors.goldDim,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],

                    // Description
                    if (spell.description.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        spell.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.crimsonText(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ],

                    // Bottom: execution + range
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.only(top: 8),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              color: AppColors.border, width: 0.5),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (spell.execution.isNotEmpty)
                            Flexible(
                              child: Text(
                                spell.execution,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.crimsonText(
                                  color: AppColors.textDim,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          if (spell.range.isNotEmpty)
                            Text(
                              '📏 ${spell.range}',
                              style: GoogleFonts.crimsonText(
                                color: AppColors.textDim,
                                fontSize: 10,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Left color bar
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 4,
                  decoration: BoxDecoration(
                    color: sc,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                ),
              ),
              // Corner ornament
              Positioned(
                top: -20,
                right: -20,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: sc.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;
  final bool bold;

  const _Tag({required this.label, required this.color, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: GoogleFonts.crimsonText(
          color: color,
          fontSize: 10,
          fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
        ),
      ),
    );
  }
}

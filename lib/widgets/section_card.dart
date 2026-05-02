import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class SectionCard extends StatelessWidget {
  final String icon;
  final String label;
  final String text;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? labelColor;
  final Color? textColor;

  const SectionCard({
    super.key,
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
    if (text.isEmpty) return const SizedBox.shrink();
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
                bottom:
                    BorderSide(color: AppColors.borderGold, width: 0.5),
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
          Text(
            text,
            style: GoogleFonts.crimsonText(
              color: textColor ?? AppColors.textPrimary,
              fontSize: 14,
              height: 1.71,
            ),
          ),
        ],
      ),
    );
  }
}

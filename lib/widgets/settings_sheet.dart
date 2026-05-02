import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../utils/app_settings.dart';

void showAppSettings(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: ValueListenableBuilder<double>(
            valueListenable: AppSettings.fontScale,
            builder: (context, scale, _) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.borderGold,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'CONFIGURAÇÕES',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cinzel(
                      color: AppColors.gold,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tamanho do texto',
                        style: GoogleFonts.crimsonText(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${(scale * 100).round()}%',
                        style: GoogleFonts.cinzel(
                          color: AppColors.goldLight,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _ScaleButton(
                        icon: Icons.remove,
                        onTap: () {
                          final next = (scale - AppSettings.step).clamp(
                              AppSettings.minScale, AppSettings.maxScale);
                          AppSettings.fontScale.value =
                              double.parse(next.toStringAsFixed(2));
                        },
                      ),
                      Expanded(
                        child: Slider(
                          value: scale,
                          min: AppSettings.minScale,
                          max: AppSettings.maxScale,
                          divisions: ((AppSettings.maxScale -
                                      AppSettings.minScale) /
                                  AppSettings.step)
                              .round(),
                          activeColor: AppColors.gold,
                          inactiveColor: AppColors.borderGold,
                          onChanged: (v) {
                            AppSettings.fontScale.value =
                                double.parse(v.toStringAsFixed(2));
                          },
                        ),
                      ),
                      _ScaleButton(
                        icon: Icons.add,
                        onTap: () {
                          final next = (scale + AppSettings.step).clamp(
                              AppSettings.minScale, AppSettings.maxScale);
                          AppSettings.fontScale.value =
                              double.parse(next.toStringAsFixed(2));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        AppSettings.fontScale.value = 1.0;
                      },
                      child: Text(
                        'Restaurar padrão',
                        style: GoogleFonts.crimsonText(
                          color: AppColors.goldDim,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}

class _ScaleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _ScaleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 24,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.gold.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.goldDim.withValues(alpha: 0.5)),
        ),
        child: Icon(icon, color: AppColors.goldLight, size: 18),
      ),
    );
  }
}

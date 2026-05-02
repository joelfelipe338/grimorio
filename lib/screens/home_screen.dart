import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/settings_sheet.dart';
import 'spell_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Stack(
          children: [
            // Decorative radial glow background
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0, -0.6),
                      radius: 1.1,
                      colors: [
                        AppColors.gold.withValues(alpha: 0.10),
                        AppColors.bg.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Top action bar (settings)
            Positioned(
              top: 8,
              right: 12,
              child: _CornerIcon(
                icon: Icons.settings,
                tooltip: 'Configurações',
                onTap: () => showAppSettings(context),
              ),
            ),

            // Main scroll content
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  const _Emblem(),
                  const SizedBox(height: 24),

                  Text(
                    'Grimorio',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cinzel(
                      color: AppColors.gold,
                      fontSize: 44,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'PATHFINDER 2E',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.crimsonText(
                      color: AppColors.goldDim,
                      fontSize: 12,
                      letterSpacing: 6,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const _OrnamentDivider(),
                  const SizedBox(height: 18),

                  Text(
                    'Escolha sua jornada',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.crimsonText(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Featured (active) card
                  _FeatureCard(
                    icon: '📖',
                    title: 'Magias',
                    subtitle:
                        'Compêndio completo de feitiços, focos e cantrips',
                    accent: AppColors.gold,
                    featured: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SpellListScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),

                  // Coming soon section
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                              height: 1, color: AppColors.borderGold)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'EM BREVE',
                          style: GoogleFonts.cinzel(
                            color: AppColors.goldDim,
                            fontSize: 11,
                            letterSpacing: 4,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                              height: 1, color: AppColors.borderGold)),
                    ],
                  ),
                  const SizedBox(height: 18),

                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.95,
                    children: const [
                      _ComingSoonCard(icon: '🐉', title: 'Bestiário'),
                      _ComingSoonCard(icon: '⚔️', title: 'Equipamentos'),
                      _ComingSoonCard(icon: '🧙', title: 'Personagens'),
                      _ComingSoonCard(icon: '🎲', title: 'Rolagens'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Decorative emblem at the top of the home screen
// ============================================================================
class _Emblem extends StatelessWidget {
  const _Emblem();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 96,
        height: 96,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              AppColors.surfaceLight,
              AppColors.surface,
            ],
          ),
          border: Border.all(color: AppColors.borderGold, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.gold.withValues(alpha: 0.25),
              blurRadius: 24,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.goldDim, width: 1),
          ),
          child: const Center(
            child: Text('✦', style: TextStyle(fontSize: 36, color: AppColors.gold)),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// Ornamental divider with diamonds on the sides
// ============================================================================
class _OrnamentDivider extends StatelessWidget {
  const _OrnamentDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(height: 1, color: AppColors.borderGold),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('◆',
              style: TextStyle(color: AppColors.gold, fontSize: 14)),
        ),
        Expanded(
          child: Container(height: 1, color: AppColors.borderGold),
        ),
      ],
    );
  }
}

// ============================================================================
// Featured (active) feature card
// ============================================================================
class _FeatureCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final Color accent;
  final bool featured;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.onTap,
    this.featured = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        splashColor: accent.withValues(alpha: 0.15),
        highlightColor: accent.withValues(alpha: 0.06),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.surfaceLight,
                AppColors.surface,
              ],
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: featured ? accent : AppColors.border,
              width: featured ? 1.5 : 1,
            ),
            boxShadow: featured
                ? [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.18),
                      blurRadius: 18,
                      spreadRadius: 0,
                    ),
                  ]
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: accent.withValues(alpha: 0.4), width: 1),
                  ),
                  child: Center(
                    child: Text(icon, style: const TextStyle(fontSize: 30)),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.cinzel(
                          color: AppColors.textPrimary,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: GoogleFonts.crimsonText(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Icon(Icons.chevron_right,
                    color: accent.withValues(alpha: 0.85), size: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// Disabled "coming soon" card
// ============================================================================
class _ComingSoonCard extends StatelessWidget {
  final String icon;
  final String title;

  const _ComingSoonCard({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.6),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Opacity(
                  opacity: 0.55,
                  child: Text(icon, style: const TextStyle(fontSize: 36)),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: GoogleFonts.cinzel(
                    color: AppColors.textDim,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Icon(
              Icons.lock_outline,
              size: 14,
              color: AppColors.textDim.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Top corner action icon (settings)
// ============================================================================
class _CornerIcon extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _CornerIcon({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: IconButton(
        icon: Icon(icon, color: AppColors.gold, size: 20),
        tooltip: tooltip,
        onPressed: onTap,
      ),
    );
  }
}

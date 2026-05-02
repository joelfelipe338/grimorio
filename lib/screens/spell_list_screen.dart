import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/spell_repository.dart';
import '../models/spell.dart';
import '../theme/app_theme.dart';
import '../utils/app_settings.dart';
import '../utils/search.dart';
import '../widgets/filter_section.dart';
import '../widgets/search_bar.dart';
import '../widgets/spell_card.dart';
import 'spell_detail_screen.dart';

class SpellListScreen extends StatefulWidget {
  const SpellListScreen({super.key});

  @override
  State<SpellListScreen> createState() => _SpellListScreenState();
}

class _SpellListScreenState extends State<SpellListScreen> {
  late Future<List<Spell>> _loadFuture;
  String _query = '';
  final Set<int> _selectedLevels = {};
  final Set<String> _selectedTraditions = {};
  final Set<String> _selectedSchools = {};
  final Set<String> _selectedTypes = {};
  String? _expandedFilter;

  @override
  void initState() {
    super.initState();
    _loadFuture = SpellRepository.loadSpells();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: FutureBuilder<List<Spell>>(
          future: _loadFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  'Carregando grimorio...',
                  style: TextStyle(
                    color: AppColors.goldDim,
                    fontSize: 18,
                  ),
                ),
              );
            }

            final allSpells = snapshot.data!;
            final results = filterSpells(
              allSpells,
              _query,
              _selectedLevels,
              _selectedTraditions,
              _selectedSchools,
              _selectedTypes,
            );

            return Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 16, bottom: 12),
                  child: Column(
                    children: [
                      Text(
                        'Grimorio',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cinzel(
                          color: AppColors.gold,
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'PATHFINDER 2E',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.crimsonText(
                          color: AppColors.goldDim,
                          fontSize: 12,
                          letterSpacing: 6,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 1,
                        margin: const EdgeInsets.symmetric(horizontal: 32),
                        color: AppColors.borderGold,
                      ),
                    ],
                  ),
                ),

                // Search + Settings
                Row(
                  children: [
                    Expanded(
                      child: GrimorioSearchBar(
                        query: _query,
                        resultCount: results.length,
                        onChanged: (v) => setState(() => _query = v),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16, left: 4),
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: AppColors.border, width: 1.5),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.settings,
                              color: AppColors.gold, size: 22),
                          tooltip: 'Configurações',
                          onPressed: () => _showSettings(context),
                        ),
                      ),
                    ),
                  ],
                ),

                // Filters
                FilterSection(
                  selectedLevels: _selectedLevels,
                  selectedTraditions: _selectedTraditions,
                  selectedSchools: _selectedSchools,
                  selectedTypes: _selectedTypes,
                  expandedFilter: _expandedFilter,
                  onExpandedChanged: (v) =>
                      setState(() => _expandedFilter = v),
                  onLevelToggle: (l) => setState(() {
                    _selectedLevels.contains(l)
                        ? _selectedLevels.remove(l)
                        : _selectedLevels.add(l);
                  }),
                  onTraditionToggle: (t) => setState(() {
                    _selectedTraditions.contains(t)
                        ? _selectedTraditions.remove(t)
                        : _selectedTraditions.add(t);
                  }),
                  onSchoolToggle: (s) => setState(() {
                    _selectedSchools.contains(s)
                        ? _selectedSchools.remove(s)
                        : _selectedSchools.add(s);
                  }),
                  onTypeToggle: (t) => setState(() {
                    _selectedTypes.contains(t)
                        ? _selectedTypes.remove(t)
                        : _selectedTypes.add(t);
                  }),
                  onClearAll: () => setState(() {
                    _selectedLevels.clear();
                    _selectedTraditions.clear();
                    _selectedSchools.clear();
                    _selectedTypes.clear();
                  }),
                ),

                // Spell list
                Expanded(
                  child: results.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('🔮',
                                  style: TextStyle(fontSize: 48)),
                              const SizedBox(height: 16),
                              Text(
                                'Nenhuma magia encontrada',
                                style: GoogleFonts.cinzel(
                                  color: AppColors.textSecondary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tente alterar os filtros ou termo de busca',
                                style: GoogleFonts.crimsonText(
                                  color: AppColors.textDim,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: results.length,
                          padding: const EdgeInsets.only(bottom: 40),
                          itemBuilder: (context, index) {
                            final spell = results[index];
                            return SpellCard(
                              spell: spell,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        SpellDetailScreen(spell: spell),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showSettings(BuildContext context) {
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
                            final next = (scale - AppSettings.step)
                                .clamp(AppSettings.minScale,
                                    AppSettings.maxScale);
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
                            final next = (scale + AppSettings.step)
                                .clamp(AppSettings.minScale,
                                    AppSettings.maxScale);
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

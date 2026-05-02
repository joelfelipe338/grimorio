import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/spell_repository.dart';
import '../models/spell.dart';
import '../theme/app_theme.dart';
import '../utils/search.dart';
import '../widgets/filter_section.dart';
import '../widgets/search_bar.dart';
import '../widgets/settings_sheet.dart';
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
                      left: 12, right: 12, top: 8, bottom: 12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _HeaderIcon(
                            icon: Icons.arrow_back,
                            tooltip: 'Voltar',
                            onTap: () => Navigator.pop(context),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Magias',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cinzel(
                                    color: AppColors.gold,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 3,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'PATHFINDER 2E',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.crimsonText(
                                    color: AppColors.goldDim,
                                    fontSize: 11,
                                    letterSpacing: 5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 44),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 1,
                        margin: const EdgeInsets.symmetric(horizontal: 24),
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
                          onPressed: () => showAppSettings(context),
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

}

class _HeaderIcon extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _HeaderIcon({
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
        color: AppColors.surface,
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class GrimorioSearchBar extends StatefulWidget {
  final String query;
  final ValueChanged<String> onChanged;
  final int resultCount;

  const GrimorioSearchBar({
    super.key,
    required this.query,
    required this.onChanged,
    required this.resultCount,
  });

  @override
  State<GrimorioSearchBar> createState() => _GrimorioSearchBarState();
}

class _GrimorioSearchBarState extends State<GrimorioSearchBar> {
  final _focusNode = FocusNode();
  final _controller = TextEditingController();
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.query;
    _focusNode.addListener(() {
      setState(() => _focused = _focusNode.hasFocus);
    });
  }

  @override
  void didUpdateWidget(GrimorioSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.query != _controller.text) {
      _controller.text = widget.query;
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Container(
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _focused ? AppColors.gold : AppColors.border,
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 12, right: 8),
                  child: Text('🔍', style: TextStyle(fontSize: 18)),
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    onChanged: widget.onChanged,
                    style: GoogleFonts.crimsonText(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Buscar magias...',
                      hintStyle: GoogleFonts.crimsonText(
                        color: AppColors.textDim,
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    autocorrect: false,
                    textInputAction: TextInputAction.search,
                  ),
                ),
                if (widget.query.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      _controller.clear();
                      widget.onChanged('');
                    },
                    child: Container(
                      width: 28,
                      height: 28,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        '✕',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (widget.query.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                '${widget.resultCount} ${widget.resultCount == 1 ? 'magia encontrada' : 'magias encontradas'}',
                style: const TextStyle(
                  color: AppColors.goldDim,
                  fontSize: 10,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

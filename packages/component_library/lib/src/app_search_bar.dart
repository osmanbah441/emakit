import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    super.key,
    required this.onSearchchanged,
    this.onFilterTap,
  });
  final Function(String) onSearchchanged;
  final VoidCallback? onFilterTap;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  bool _isVoiceListening = false;

  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _searchTerm = _searchController.text.toLowerCase();
    });

    widget.onSearchchanged.call(_searchTerm);
  }

  void _handleVoiceSearch(String result) {
    _searchController.text = result;
  }

  void _clearSearch() {
    _searchController.clear();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      elevation: WidgetStateProperty.all(0),
      hintText: _isVoiceListening ? 'Listening...' : 'Search for items...',
      controller: _searchController,
      leading: Icon(Icons.search),
      trailing: [
        if (_searchController.text.isNotEmpty)
          IconButton(icon: const Icon(Icons.clear), onPressed: _clearSearch),

        VoiceInputButton(
          onResult: _handleVoiceSearch,
          onListeningChanged: (isListening) {
            setState(() {
              _isVoiceListening = isListening;
            });
          },
        ),

        IconButton(
          onPressed: widget.onFilterTap,
          icon: Icon(Icons.filter_list),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final ValueChanged<String>? onSubmitted;
  final bool enabled;
  final String hintText;

  const SearchBarWidget({
    super.key,
    this.onSubmitted,
    this.enabled = true,
    this.hintText = 'Search for a place',
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late final SearchController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = SearchController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      searchController: _searchController,
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          controller: controller,
          padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16.0),
          ),
          onTap: widget.enabled ? () => controller.openView() : null,
          onChanged: widget.enabled ? (_) => controller.openView() : null,
          onSubmitted: widget.onSubmitted,
          leading: const Icon(Icons.search),
          hintText: widget.hintText,
          enabled: widget.enabled,
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return List<ListTile>.generate(5, (int index) {
          final String item = 'item $index';
          return ListTile(
            title: Text(item),
            onTap: () {
              if (widget.onSubmitted != null) {
                widget.onSubmitted!(item);
              }
              controller.closeView(item);
            },
          );
        });
      },
    );
  }
}

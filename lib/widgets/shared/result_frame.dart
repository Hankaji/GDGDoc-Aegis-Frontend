import 'package:flutter/material.dart';

class ResultsBar extends StatelessWidget {
  final int? resultCount;
  final bool isLoading;
  final String? query;
  final VoidCallback? onClear;

  const ResultsBar({
    super.key,
    this.resultCount,
    required this.isLoading,
    this.query,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return Row(
        children: [
          const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)),
          const SizedBox(width: 12),
          Text(
            'Searching for "$query"...',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      );
    }

    if (resultCount == null) {
      return const SizedBox(); // Empty state
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _getResultsText(resultCount!),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        if (onClear != null)
          TextButton(
            onPressed: onClear,
            child: Text(
              'Clear',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
      ],
    );
}

  String _getResultsText(int count) {
    if (count == 0) return 'No results found';
    if (count == 1) return '1 result';
    return '$count results';
  }
}

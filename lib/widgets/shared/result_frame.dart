import 'package:flutter/material.dart';

class ResultsBar extends StatefulWidget {
  final int? resultCount;
  final bool isLoading;
  final String? query;
  final VoidCallback? onClear;
  final Widget? expandedContent;

  const ResultsBar({
    super.key,
    this.resultCount,
    required this.isLoading,
    this.query,
    this.onClear,
    this.expandedContent,
  });

  @override
  State<ResultsBar> createState() => _ResultsBarState();
}

class _ResultsBarState extends State<ResultsBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isExpanded = false;
  final double _expandedHeightFactor = 0.75; // 75% of screen height

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final collapsedHeight = 48.0;
    final expandedHeight = screenHeight * _expandedHeightFactor;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final height =
            collapsedHeight +
            (expandedHeight - collapsedHeight) * _controller.value;
        return Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: height,
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              // Calculate drag percentage (0 to 1)
              final dragPercentage = details.primaryDelta! / expandedHeight;
              _controller.value -= dragPercentage;
            },
            onVerticalDragEnd: (details) {
              if (_controller.value > 0.5 || details.primaryVelocity! < -500) {
                _toggleExpanded();
              } else if (_controller.value < 0.5 ||
                  details.primaryVelocity! > 500) {
                _toggleExpanded();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 16,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Draggable handle
                  GestureDetector(
                    onTap: _toggleExpanded,
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).dividerColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                  // Header content
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: _buildHeaderContent(context),
                    ),
                  ),
                  // Expanded content (only visible when expanded)
                  if (_isExpanded && widget.expandedContent != null)
                    Expanded(child: widget.expandedContent!),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderContent(BuildContext context) {
    if (widget.isLoading) {
      return Row(
        children: [
          const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 12),
          Text(
            'Searching for "${widget.query}"...',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      );
    }

    if (widget.resultCount == null) {
      return const SizedBox(); // Empty state
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _getResultsText(widget.resultCount!),
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        if (widget.onClear != null)
          TextButton(
            onPressed: widget.onClear,
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

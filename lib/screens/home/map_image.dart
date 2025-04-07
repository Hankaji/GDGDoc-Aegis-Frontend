import 'package:flutter/material.dart';
import '../../widgets/shared/search-bar.dart';
import '../../constants/icons/map-pin.dart';

enum MapState { browsing, searching, showingResults, showingDetails }

class MapImageScreen extends StatefulWidget {
  const MapImageScreen({super.key});

  @override
  State<MapImageScreen> createState() => _MapImageScreenState();
}

class _MapImageScreenState extends State<MapImageScreen> {
  Offset? _pinPosition;
  final TransformationController _transformationController = TransformationController();
  MapState _currentState = MapState.browsing;
  List<MapLocation> _searchResults = [];
  MapLocation? _selectedLocation;

  void _handleTap(TapUpDetails details) {
    if (_currentState != MapState.browsing) return;
    
    final inverseMatrix = Matrix4.inverted(_transformationController.value);
    final untransformedPosition = MatrixUtils.transformPoint(
      inverseMatrix,
      details.localPosition,
    );

    setState(() {
      _pinPosition = untransformedPosition;
    });
  }

  void _handleSearch(String query) async {
    setState(() => _currentState = MapState.searching);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _searchResults = _generateMockResults(query);
      _currentState = MapState.showingResults;
    });
  }

  List<MapLocation> _generateMockResults(String query) {
    return List.generate(5, (index) => MapLocation(
      id: index,
      name: "Location ${index + 1} for $query",
      position: Offset(
        100 + index * 80.0,
        100 + index * 60.0,
      ),
      description: "Details about location ${index + 1}",
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Base Map with Interactive Viewer
          GestureDetector(
            onTapUp: _handleTap,
            child: InteractiveViewer(
              transformationController: _transformationController,
              panEnabled: _currentState == MapState.browsing,
              scaleEnabled: _currentState == MapState.browsing,
              constrained: false,
              minScale: 0.5,
              maxScale: 4,
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  Image.asset(
                    'assets/fake-map.png',
                    fit: BoxFit.cover,
                  ),
                  // User-placed pin
                  if (_pinPosition != null && _currentState == MapState.browsing)
                    Positioned(
                      left: _pinPosition!.dx - 20,
                      top: _pinPosition!.dy - 42,
                      child: const MapPinIcon(size: 50),
                    ),
                  // Search result pins
                  ..._searchResults.map((location) => Positioned(
                    left: location.position.dx - 20,
                    top: location.position.dy - 42,
                    child: GestureDetector(
                      onTap: () => setState(() {
                        _selectedLocation = location;
                        _currentState = MapState.showingDetails;
                      }),
                      child: const MapPinIcon(
                        size: 40,
                        color: Colors.blue,
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),

          // Search Bar (always visible)
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: SearchBarWidget(
              onSubmitted: _handleSearch,
              enabled: _currentState != MapState.showingDetails,
            ),
          ),

          // Results Panel
          if (_currentState == MapState.showingResults)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildResultsPanel(),
            ),

          // Loading Indicator
          if (_currentState == MapState.searching)
            const Center(child: CircularProgressIndicator()),

          // Detail View
          if (_currentState == MapState.showingDetails && _selectedLocation != null)
            _buildDetailPanel(),
        ],
      ),
    );
  }

  Widget _buildResultsPanel() {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '${_searchResults.length} Results Found',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) => ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(_searchResults[index].name),
                  onTap: () {
                    setState(() {
                      _selectedLocation = _searchResults[index];
                      _currentState = MapState.showingDetails;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailPanel() {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _selectedLocation!.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(_selectedLocation!.description),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => setState(() => _currentState = MapState.showingResults),
                    child: const Text('Back'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _pinPosition = _selectedLocation!.position;
                        _currentState = MapState.browsing;
                      });
                    },
                    child: const Text('Show on Map'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MapLocation {
  final int id;
  final String name;
  final Offset position;
  final String description;

  MapLocation({
    required this.id,
    required this.name,
    required this.position,
    required this.description,
  });
}

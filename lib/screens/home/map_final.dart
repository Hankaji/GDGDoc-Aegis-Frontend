import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:gdgdoc/constants/icons/map-pin.dart';
import 'package:gdgdoc/domain/endpoints/location_endpoint.dart';
import 'package:gdgdoc/domain/endpoints/review_endpoint.dart';
import 'package:gdgdoc/domain/models/location.dart';
import 'package:gdgdoc/domain/models/tag.dart';
import 'package:gdgdoc/screens/home/components/review_tab.dart';
import 'package:gdgdoc/screens/home/components/tags.dart';
import 'package:gdgdoc/utils/lgn_lat.dart';
import 'package:gdgdoc/utils/vec2.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class MapFinal extends StatefulWidget {
  const MapFinal({super.key});

  @override
  State<MapFinal> createState() => _MapFinalState();
}

class _MapFinalState extends State<MapFinal> {
  String tagFilter = '';

  @override
  Widget build(BuildContext context) {
    final systemUiInsets = MediaQuery.of(context).padding;

    final result = Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const _Map(),
          _ContentSheet(systemUiInsets: systemUiInsets, tagFilter: tagFilter),
          Positioned(
            top: 0,
            left: 16,
            right: 16,
            child: _SearchBar(
              onSubmit:
                  (filter) => setState(() {
                    tagFilter = filter;
                  }),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const _BottomNavigationBar(),
      floatingActionButton: const _MapButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );

    return DefaultSheetController(child: result);
  }
}

// Example function to call and print location
Future<List<Location>> _getLocations() async {
  try {
    final List<Location> locationData = await LocationApi.getLocations();
    return locationData;
  } catch (e) {
    // log('Error fetching location: $e');
    throw (Exception(e));
  }
}

class _SearchBar extends StatefulWidget {
  Function(String)? onSubmit;

  _SearchBar({this.onSubmit});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<_SearchBar> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, right: 10, left: 10),

      /// In AnimSearchBar widget, the width, textController, onSuffixTap are required properties.
      /// You have also control over the suffixIcon, prefixIcon, helpText and animationDurationInMilli
      child: AnimSearchBar(
        onSubmitted: (String query) {
          // Simulate API call
          // await Future.delayed(const Duration(seconds: 1));
          // log(query);
          widget.onSubmit?.call(query);
        },
        width: 400,
        textController: textController,
        onSuffixTap: () {
          setState(() {
            textController.clear();
          });
        },
      ),
    );
  }
}

class _MapButton extends StatelessWidget {
  const _MapButton();

  @override
  Widget build(BuildContext context) {
    final sheetController = DefaultSheetController.of(context);

    void onPressed() {
      if (sheetController.metrics case final it?) {
        // Collapse the sheet to reveal the map behind.
        sheetController.animateTo(
          SheetOffset.absolute(it.minOffset),
          curve: Curves.fastOutSlowIn,
        );
      }
    }

    final result = FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: Colors.black,
      label: const Text('Map'),
      icon: const Icon(Icons.map),
    );

    // It is easy to create sheet position driven animations
    // by using 'PositionDrivenAnimation', a special kind of
    // 'Animation<double>' whose value changes from 0 to 1 as
    // the sheet position changes from 'startPosition' to 'endPosition'.
    final animation = SheetOffsetDrivenAnimation(
      controller: DefaultSheetController.of(context),
      // The initial value of the animation is required
      // since the sheet position is not available at the first build.
      initialValue: 1,
      // If null, the minimum position will be used. (Default)
      startOffset: null,
      // If null, the maximum position will be used. (Default)
      endOffset: null,
    ).drive(CurveTween(curve: Curves.easeInExpo));

    // Hide the button when the sheet is dragged down.
    return ScaleTransition(
      scale: animation,
      child: FadeTransition(opacity: animation, child: result),
    );
  }
}

class _Map extends StatefulWidget {
  final bool panable;
  final Vec2? initialPosition;

  const _Map({this.panable = true, this.initialPosition});

  @override
  State<_Map> createState() => _MapState();
}

class _MapState extends State<_Map> {
  List<Location> _locations = [];
  static final LatLng bottomRightLoc = LatLng(
    10.741071581787931,
    106.7018617750684,
  );
  static final Vec2 mapSize = Vec2(2048, 1251);

  static Vec2 calculateRelativeMapPosition(LatLng target) {
    double latitudeDifference = target.latitude - bottomRightLoc.latitude;
    double longitudeDifference = target.longitude - bottomRightLoc.longitude;

    // Mapscale to correct positions
    Vec2 mapScale = Vec2(15.065, 24.65);

    double relativeX = longitudeDifference * mapScale.x * mapSize.x;
    double relativeY = latitudeDifference * mapScale.y * mapSize.y;

    return Vec2(relativeX, relativeY);
  }

  @override
  void initState() {
    super.initState();
    _getLocations().then(
      (locDataList) => setState(() {
        _locations = locDataList;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: InteractiveViewer(
        transformationController:
            widget.initialPosition != null
                ? TransformationController(
                  Matrix4.translation(
                    Vector3(
                      widget.initialPosition!.x,
                      widget.initialPosition!.y,
                      0,
                    ),
                  ),
                )
                : null,
        panEnabled: widget.panable,
        scaleEnabled: true,
        constrained: false,
        minScale: 0.5,
        maxScale: 4,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Image.asset('assets/fake_map.jpeg', fit: BoxFit.contain),

            ..._locations.map((loc) {
              LatLng locLatLng = LatLng(loc.latitude!, loc.longitude!);
              Vec2 relativePosition = calculateRelativeMapPosition(locLatLng);

              return Positioned(
                bottom: relativePosition.y,
                right: -relativePosition.x,
                child: MapPinIcon(locationName: loc.name, size: 42),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _ContentSheet extends StatefulWidget {
  String? tagFilter;
  _ContentSheet({required this.systemUiInsets, this.tagFilter});

  final EdgeInsets systemUiInsets;

  @override
  State<_ContentSheet> createState() => _ContentSheetState();
}

class _ContentSheetState extends State<_ContentSheet> {
  Location? _selectedLocation; // Changed from _House to Location

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final parentHeight = constraints.maxHeight;
        final appbarHeight = 220;
        final handleHeight = const _ContentSheetHandle().preferredSize.height;
        final sheetHeight = parentHeight - appbarHeight + handleHeight;
        final minSheetOffset = SheetOffset.absolute(
          handleHeight + widget.systemUiInsets.bottom,
        );

        return SheetViewport(
          child: Sheet(
            scrollConfiguration: const SheetScrollConfiguration(),
            snapGrid: SheetSnapGrid(
              snaps: [minSheetOffset, const SheetOffset(1)],
            ),
            decoration: const MaterialSheetDecoration(
              size: SheetSize.fit,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
            ),
            child: SizedBox(
              height: sheetHeight,
              child: Column(
                children: [
                  const _ContentSheetHandle(),
                  Expanded(
                    child:
                        _selectedLocation == null
                            ? _LocationList(
                              onLocationSelected:
                                  (location) => setState(
                                    () => _selectedLocation = location,
                                  ),
                              tagFilter: widget.tagFilter ?? '',
                            )
                            : _LocationDetailView(
                              location: _selectedLocation!,
                              onBackPressed:
                                  () =>
                                      setState(() => _selectedLocation = null),
                            ),
                  ),
                  const SizedBox(height: 125),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Modified handle to include back button when in detail view
class _ContentSheetHandle extends StatelessWidget
    implements PreferredSizeWidget {
  const _ContentSheetHandle();

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: preferredSize,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 6,
              width: 40,
              decoration: const ShapeDecoration(
                color: Colors.black12,
                shape: StadiumBorder(),
              ),
            ),
            const SizedBox(height: 13),
            Expanded(
              child: Center(
                child: Text(
                  'Places Near You',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationList extends StatefulWidget {
  String tagFilter;
  _LocationList({required this.onLocationSelected, this.tagFilter = ''});

  final ValueChanged<Location> onLocationSelected;

  @override
  State<_LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<_LocationList> {
  late Future<List<Location>> _locationsFuture;

  @override
  void initState() {
    super.initState();
    _locationsFuture = _getLocations();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Location>>(
      future: _locationsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          List<Location> filteredLocations =
              snapshot.data!.where((location) {
                for (Tag tag in location.tags!) {
                  if (widget.tagFilter.isEmpty ||
                      tag.name.toLowerCase().contains(
                        widget.tagFilter.toLowerCase(),
                      )) {
                    return true;
                  }
                }
                return false;
              }).toList();

          return FadeTransition(
            opacity: SheetOffsetDrivenAnimation(
              controller: DefaultSheetController.of(context),
              initialValue: 1,
            ).drive(CurveTween(curve: Curves.easeOutCubic)),
            child: ListView.builder(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              itemCount: filteredLocations.length,
              itemBuilder: (context, index) {
                final location = filteredLocations[index];
                return GestureDetector(
                  onTap: () => widget.onLocationSelected(location),
                  child: _LocationCard(location),
                );
              },
            ),
          );
        } else {
          return const Center(child: Text('No locations found'));
        }
      },
    );
  }
}

class _LocationDetailView extends StatelessWidget {
  const _LocationDetailView({
    required this.location,
    required this.onBackPressed,
  });

  final Location location;
  final VoidCallback onBackPressed;

  // Helper methods
  String get _imageUrl => 'https://picsum.photos/600/400'; // Larger placeholder
  // double get _rating => 4.5; // Fetch from API

  @override
  Widget build(BuildContext context) {
    Vec2 locationRelativePos = _MapState.calculateRelativeMapPosition(
      LatLng(location.latitude!, location.longitude!),
    );
    Vec2 locationRelativePosFromTopLeft = Vec2(
      locationRelativePos.x - (-_MapState.mapSize.x) - 240,
      locationRelativePos.y - _MapState.mapSize.y + 120,
    );

    return Column(
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBackPressed,
            ),
            const Spacer(),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1.2,
                    child: Image.network(
                      location.thumbnailImage!,
                      fit: BoxFit.cover,
                    ),
                    // child: Image.network(_imageUrl, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  location.name ?? 'Unnamed Location',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(location.address ?? 'Address not available'),
                const SizedBox(height: 8),
                Tags(tagNames: location.tags ?? []),
                // if (location.latitude != null && location.longitude != null)
                //   Text(
                //     'Coordinates: ${location.latitude}, ${location.longitude}',
                //     style: const TextStyle(fontWeight: FontWeight.bold),
                //   ),
                const SizedBox(height: 16),
                const Text('Map', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                // ------------------------- Mini Map image -------------------------
                Container(
                  height: 150,
                  clipBehavior: Clip.hardEdge,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                  ),
                  // child: const Icon(Icons.map, size: 50),
                  child: OverflowBox(
                    alignment: Alignment.center,
                    child: _Map(
                      panable: false,
                      initialPosition: Vec2(
                        -locationRelativePosFromTopLeft.x,
                        locationRelativePosFromTopLeft.y,
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ReviewTab(locationId: location.id),
                  ),
                ),
                const SizedBox(height: 175),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    final result = BottomNavigationBar(
      unselectedItemColor: Colors.black54,
      selectedItemColor: Colors.pink,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_outlined),
          label: 'LoveIt',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inbox_outlined),
          label: 'Inbox',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );

    // Hide the navigation bar when the sheet is dragged down.
    return SlideTransition(
      position: SheetOffsetDrivenAnimation(
        controller: DefaultSheetController.of(context),
        initialValue: 1,
      ).drive(Tween(begin: const Offset(0, 1), end: Offset.zero)),
      child: result,
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard(this.location);

  final Location location;

  // Replace the hardcoded rating with a Future
  Future<double> get _ratingFuture =>
      ReviewApi.getAvgRatingByLocationId(location.id);

  String get _imageUrl => 'https://picsum.photos/300/300';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final primaryTextStyle = textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.bold,
    );
    final secondaryTextStyle = textTheme.titleMedium;
    final tertiaryTextStyle = textTheme.titleMedium?.copyWith(
      color: Colors.black54,
    );

    final image = Container(
      clipBehavior: Clip.hardEdge,
      decoration: ShapeDecoration(
        // color: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: AspectRatio(
        aspectRatio: 1.8,
        child: Image.network(location.thumbnailImage!, fit: BoxFit.cover),
        // child: Image.network(_imageUrl, fit: BoxFit.fitWidth),
      ),
    );

    // Create a FutureBuilder for the rating
    final rating = FutureBuilder<double>(
      future: _ratingFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: 24,
            height: 24,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }

        if (snapshot.hasError) {
          return const Icon(Icons.error_outline, size: 18, color: Colors.red);
        }

        final ratingValue = snapshot.data ?? 0.0;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star_rounded, color: Color(0xFFFFB53F), size: 18),
            const SizedBox(width: 4),
            Text(ratingValue.toStringAsFixed(1), style: secondaryTextStyle),
            const SizedBox(width: 8),
          ],
        );
      },
    );

    final heading = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            location.name ?? 'Unnamed Location',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: primaryTextStyle,
          ),
        ),
        rating, // Use the FutureBuilder here
      ],
    );

    final description = [
      Text(
        location.address ?? 'Address not available',
        style: tertiaryTextStyle,
      ),
      Tags(tagNames: location.tags ?? []),
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [image, heading, ...description],
      ),
    );
  }
}

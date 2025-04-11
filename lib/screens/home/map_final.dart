import 'package:faker/faker.dart' hide Image, Color;
import 'package:flutter/material.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:gdgdoc/screens/home/components/review_tab.dart';

class MapFinal extends StatelessWidget {
  const MapFinal({super.key});

  @override
  Widget build(BuildContext context) {
    final systemUiInsets = MediaQuery.of(context).padding;

    final result = Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const _Map(),
          _ContentSheet(systemUiInsets: systemUiInsets),
          Positioned(top: 0, left: 16, right: 16, child: _SearchBar()),
        ],
      ),
      bottomNavigationBar: const _BottomNavigationBar(),
      floatingActionButton: const _MapButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );

    return DefaultSheetController(child: result);
  }
}

class _SearchBar extends StatefulWidget {
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
        onSubmitted: (String query) async {
          // Simulate API call
          await Future.delayed(const Duration(seconds: 1));
          print(query);
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

class _Map extends StatelessWidget {
  const _Map();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: InteractiveViewer(
        panEnabled: true,
        scaleEnabled: true,
        constrained: false,
        minScale: 0.5,
        maxScale: 4,
        child: Stack(
          fit: StackFit.passthrough,
          children: [Image.asset('assets/fake_map.png', fit: BoxFit.contain)],
        ),
      ),
    );
  }
}

class _ContentSheet extends StatefulWidget {
  const _ContentSheet({required this.systemUiInsets});

  final EdgeInsets systemUiInsets;

  @override
  State<_ContentSheet> createState() => _ContentSheetState();
}

class _ContentSheetState extends State<_ContentSheet> {
  _House? _selectedHouse;

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
                  const _ContentSheetHandle(), // Your original handle
                  Expanded(
                    child:
                        _selectedHouse == null
                            ? _HouseList(
                              onHouseSelected:
                                  (house) =>
                                      setState(() => _selectedHouse = house),
                            )
                            : _HouseDetailView(
                              house: _selectedHouse!,
                              onBackPressed:
                                  () => setState(() => _selectedHouse = null),
                            ),
                  ),
                  const SizedBox(height: 125), // Extra space at bottom
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

class _HouseList extends StatelessWidget {
  const _HouseList({required this.onHouseSelected});

  final ValueChanged<_House> onHouseSelected;

  @override
  Widget build(BuildContext context) {
    final result = ListView.builder(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      itemCount: _houses.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onHouseSelected(_houses[index]),
          child: _HouseCard(_houses[index]),
        );
      },
    );

    return FadeTransition(
      opacity: SheetOffsetDrivenAnimation(
        controller: DefaultSheetController.of(context),
        initialValue: 1,
      ).drive(CurveTween(curve: Curves.easeOutCubic)),
      child: result,
    );
  }
}

class _HouseDetailView extends StatelessWidget {
  const _HouseDetailView({required this.house, required this.onBackPressed});

  final _House house;
  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Keep the back button row fixed at the top
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBackPressed,
            ),
            const Spacer(),
          ],
        ),
        // Make only the content area scrollable
        Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(), // Better for sheet behavior
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // House image
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1.2,
                    child: Image.network(house.image, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 16),
                // House details
                Text(
                  house.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text('${house.distance} kilometers away'),
                const SizedBox(height: 8),
                Text(
                  '\$${house.charge} total before taxes',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                // Map section
                const Text('Map', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Container(
                  height: 150,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                  ),
                  child: const Icon(Icons.map, size: 50),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: ReviewTab(),
                  ),
                ),
                const SizedBox(height: 175), // Extra space at bottom
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _House {
  const _House({
    required this.title,
    required this.rating,
    required this.distance,
    required this.charge,
    required this.image,
  });

  factory _House.random() {
    return _House(
      title: '${faker.address.city()}, ${faker.address.country()}',
      rating: faker.randomGenerator.decimal(scale: 1.5, min: 3.5),
      distance: faker.randomGenerator.integer(300, min: 50),
      charge: faker.randomGenerator.integer(2000, min: 500),
      image: faker.image.loremPicsum(width: 300, height: 300),
    );
  }

  final String title;
  final double rating;
  final int distance;
  final int charge;
  final String image;
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

class _HouseCard extends StatelessWidget {
  const _HouseCard(this.house);

  final _House house;

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
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: AspectRatio(
        aspectRatio: 1.2,
        child: Image.network(house.image, fit: BoxFit.fitWidth),
      ),
    );

    final rating = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, color: secondaryTextStyle?.color, size: 18),
        const SizedBox(width: 4),
        Text(house.rating.toStringAsFixed(1), style: secondaryTextStyle),
      ],
    );

    final heading = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            house.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: primaryTextStyle,
          ),
        ),
        const SizedBox(width: 8),
        rating,
      ],
    );

    final description = [
      Text('${house.distance} kilometers away', style: tertiaryTextStyle),
      const SizedBox(height: 4),
      Text('5 nights · Jan 14 - 19', style: tertiaryTextStyle),
      const SizedBox(height: 16),
      Text(
        '\$${house.charge} total before taxes',
        style: secondaryTextStyle?.copyWith(
          decoration: TextDecoration.underline,
        ),
      ),
    ];

    return Padding(
      // Removed InkWell and just use Padding
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          image,
          const SizedBox(height: 16),
          heading,
          const SizedBox(height: 8),
          ...description,
        ],
      ),
    );
  }
}

final _houses = List.generate(5, (_) => _House.random());

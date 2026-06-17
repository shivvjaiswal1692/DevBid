import 'package:devbid/screens/create_listing_screen.dart';
import 'package:devbid/screens/explore_screen.dart';
import 'package:devbid/screens/home_screen.dart';
import 'package:devbid/screens/messages/messages_screen.dart';
import 'package:devbid/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class DevBidBottomNav extends StatelessWidget {
  const DevBidBottomNav({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  static const _routes = [
    HomeScreen.routeName,
    ExploreScreen.routeName,
    CreateListingScreen.routeName,
    MessagesScreen.routeName,
    ProfileScreen.routeName,
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: (index) {
        if (index != currentIndex) {
          Navigator.pushReplacementNamed(context, _routes[index]);
        }
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.explore_outlined), label: 'Explore'),
        NavigationDestination(icon: Icon(Icons.add_box_outlined), label: 'Sell'),
        NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: 'Messages'),
        NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    );
  }
}

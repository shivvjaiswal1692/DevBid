import 'package:devbid/screens/auth/login_screen.dart';
import 'package:devbid/screens/auth/signin_screen.dart';
import 'package:devbid/screens/auth/signup_screen.dart';
import 'package:devbid/screens/create_listing_screen.dart';
import 'package:devbid/screens/delivery_screen.dart';
import 'package:devbid/screens/explore_screen.dart';
import 'package:devbid/screens/home_screen.dart';
import 'package:devbid/screens/messages/chat_screen.dart';
import 'package:devbid/screens/messages/messages_screen.dart';
import 'package:devbid/screens/offer_bid_screen.dart';
import 'package:devbid/screens/payment_screen.dart';
import 'package:devbid/screens/profile_screen.dart';
import 'package:devbid/screens/startup_detail_screen.dart';
import 'package:devbid/services/listing_service.dart';
import 'package:devbid/services/theme_service.dart';
import 'package:devbid/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const DevBidApp());
}

class DevBidApp extends StatelessWidget {
  const DevBidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListingService()),
        ChangeNotifierProvider(create: (_) => ThemeService()),
      ],
      child: Consumer<ThemeService>(
        builder: (context, themeService, _) => MaterialApp(
          title: 'DevBid',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeService.themeMode,
          initialRoute: LoginScreen.routeName,
          routes: {
            LoginScreen.routeName: (_) => const LoginScreen(),
            SignInScreen.routeName: (_) => const SignInScreen(),
            SignupScreen.routeName: (_) => const SignupScreen(),
            HomeScreen.routeName: (_) => const HomeScreen(),
            ExploreScreen.routeName: (_) => const ExploreScreen(),
            CreateListingScreen.routeName: (_) => const CreateListingScreen(),
            MessagesScreen.routeName: (_) => const MessagesScreen(),
            ProfileScreen.routeName: (_) => const ProfileScreen(),
            StartupDetailScreen.routeName: (_) => const StartupDetailScreen(),
            OfferBidScreen.routeName: (_) => const OfferBidScreen(),
            PaymentScreen.routeName: (_) => const PaymentScreen(),
            ChatScreen.routeName: (_) => const ChatScreen(),
            DeliveryScreen.routeName: (_) => const DeliveryScreen(),
          },
        ),
      ),
    );
  }
}

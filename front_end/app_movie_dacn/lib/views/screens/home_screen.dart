import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/views/screens/taps/home_tap_screen.dart';
import 'package:app_movie/views/screens/taps/profile_tap_screen.dart';
import 'package:app_movie/views/screens/taps/search_tap_screen.dart';
import 'package:app_movie/views/screens/taps/showtime_tap_screen.dart';
import 'package:app_movie/views/screens/taps/ticket_tap_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: taps[currentIndex],
      bottomNavigationBar: showBottomNavigationBar(),
    );
  }

  List<Widget> taps = [
    const HomeTapScreen(),
    const SearchTapScreen(),
    const ShowtimeTapScreen(),
    const TicketTapScreen(),
    const ProfileTapScreen()
  ];

  showBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [button1, Color(0xFF74787F)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight
        )
      ),
      child: BottomNavigationBar(
        items: items,
        currentIndex: currentIndex,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        unselectedItemColor: Colors.white,
        fixedColor: primaryMain1,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(
        IconlyLight.home,
        color: Colors.white,
      ),
      label: 'Home'
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        IconlyLight.search,
        color: Colors.white,
      ),
      label: 'Search'
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.menu,
        color: Colors.white,
      ),
      label: 'Menu'
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        IconlyLight.ticket,
        color: Colors.white,
      ),
      label: 'Tickets'
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        IconlyLight.profile,
        color: Colors.white,
      ),
      label: 'Profile'
    )
    
  ];

}
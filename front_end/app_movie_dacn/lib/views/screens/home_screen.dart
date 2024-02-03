import 'dart:convert';

import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/services/api.dart';
import 'package:app_movie/views/screens/taps/home_tap_screen.dart';
import 'package:app_movie/views/screens/taps/profile_tap_screen.dart';
import 'package:app_movie/views/screens/taps/search_tap_screen.dart';
import 'package:app_movie/views/screens/taps/showtime_tap_screen.dart';
import 'package:app_movie/views/screens/taps/ticket_tap_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static List<dynamic> previousSearch = [];
  
  static List<dynamic> trendingList= [];
  static List<dynamic> popularList = [];
  static List<dynamic> nowPlayingList = [];
  static List<dynamic> upComingList = [];
  static List<dynamic> weekdayList = [];
  static List<dynamic> showtimeList = [];

  static List<dynamic> allMovies = [];
  static List<dynamic> movieNames = [];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> taps = [];

  late Future<List<List<dynamic>>> apiData;

  @override
  void initState() {
    super.initState();
    apiData = fetchData();
  }

  Future<List<List<dynamic>>> fetchData() async {
    HomeScreen.trendingList = await getMovieTrending();
    HomeScreen.popularList = await getMoviePopular();
    HomeScreen.nowPlayingList = await getMovieNowPlaying();
    HomeScreen.upComingList = await getMovieUpComing();
    HomeScreen.movieNames = await getMovieName();
    HomeScreen.weekdayList = await getWeekday();
    HomeScreen.showtimeList = await getShowtime();

    HomeScreen.allMovies.addAll(HomeScreen.trendingList);
    HomeScreen.allMovies.addAll(HomeScreen.popularList);
    HomeScreen.allMovies.addAll(HomeScreen.nowPlayingList);
    HomeScreen.allMovies.addAll(HomeScreen.upComingList);

    taps = [
      const HomeTapScreen(),
      const SearchTapScreen(),
      const ShowtimeTapScreen(),
      const TicketTapScreen(),
      const ProfileTapScreen()
    ];

    return [
      HomeScreen.trendingList, 
      HomeScreen.popularList,
      HomeScreen.nowPlayingList, 
      HomeScreen.upComingList,
      HomeScreen.weekdayList,
      HomeScreen.showtimeList
    ];
  }

// taps[currentIndex]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [ primaryMain2, primaryMain1 ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight
          ),
          color: Colors.grey.withOpacity(.7),
        ),
        child: FutureBuilder(
          future: apiData, 
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(
                color: primaryMain1,
              ));
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            } else {
              return taps[currentIndex];
            }
          }
        ),
      ),
      bottomNavigationBar: showBottomNavigationBar(),
    );
  }

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
        Icons.drag_indicator,
        color: Colors.white,
      ),
      label: 'ShowTimes'
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

  Future<List<dynamic>> getMovieTrending() async {
    final response = await ApiServices.getMovieTrending();
    if(response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }
    return List<dynamic>.empty();
  }

  Future<List<dynamic>> getMoviePopular() async {
    final response = await ApiServices.getMoviePopular();
    if(response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }
    return List<dynamic>.empty();
  }

  Future<List<dynamic>> getMovieNowPlaying() async {
    final response = await ApiServices.getMovieNowPlaying();
    if(response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }
    return List<dynamic>.empty();
  }

  Future<List<dynamic>> getMovieUpComing() async {
    final response = await ApiServices.getMovieUpComing();
    if(response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }
    return List<dynamic>.empty();
  }

  Future<List<dynamic>> getMovieName() async {
    final response = await ApiServices.getMovieName();
    if(response.statusCode == 200) {
      // print(jsonDecode(response.body));
      return jsonDecode(response.body) as List<dynamic>;
    }
    return [];
  }

  Future<List<dynamic>> getWeekday() async {
    final response = await ApiServices.getWeekday();
    if(response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }
    return [];
  }

  Future<List<dynamic>> getShowtime() async {
    final response = await ApiServices.getShowtime();
    if(response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }
    return [];
  }
}
import 'dart:convert';

import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/services/api.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeTapScreen extends StatefulWidget {
  const HomeTapScreen({super.key});

  @override
  State<HomeTapScreen> createState() => _HomeTapScreenState();
}

class _HomeTapScreenState extends State<HomeTapScreen> {
  List<dynamic> trendingList = [];
  List<dynamic> popularList = [];
  List<dynamic> nowPlayingList = [];
  List<dynamic> upComingList = [];

  bool isLoadingSlider = false;
  bool isLoadingPopular = false;
  bool isLoadingNowPlaying = false;
  bool isLoadingUpComing = false;

  @override
  void initState() {
    super.initState();
    getMovieTrending();
    getMoviePopular();
    getMovieNowPlaying();
    getMovieUpComing();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 32),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [ primaryMain2, primaryMain1 ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight
              ),
              color: Colors.grey.withOpacity(.7),
            ),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'CINE AURA',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold
                      )
                    )
                  ],
                ),
                const SizedBox(height: 16),

                Container(
                  height: 400,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Visibility(
                    visible: isLoadingSlider,
                    replacement: const Center(child: CircularProgressIndicator()),
                    child: CarouselSlider.builder(
                      itemCount: trendingList.length, 
                      itemBuilder: (context, index, realIndex) {
                        return builImage(trendingList[index][0]['poster_path']);
                      }, 
                      options: CarouselOptions(
                        height: 400,
                        autoPlay: true,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: const Duration(seconds: 2),
                        enlargeCenterPage: true, // quay lại mục đầu tiên
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Text(
                        'Phim được yêu thích nhất',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                SizedBox(
                  height: 160,
                  child: Visibility(
                    visible: isLoadingPopular,
                    replacement: const Center(child: CircularProgressIndicator()),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: popularList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: InkWell(
                            onTap: () {},
                            child: builImage(popularList[index][0]['poster_path'])
                          )
                        );
                      },
                    )
                  ),
                ),
                const SizedBox(height: 32),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Text(
                        'Phim đang chiếu',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                SizedBox(
                  height: 160,
                  child: Visibility(
                    visible: isLoadingNowPlaying,
                    replacement: const Center(child: CircularProgressIndicator()),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: nowPlayingList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: InkWell(
                            onTap: () {},
                            child: builImage(nowPlayingList[index][0]['poster_path'])
                          )
                        );
                      },
                    )
                  ),
                ),
                const SizedBox(height: 32),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Text(
                        'Phim sắp chiếu',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                SizedBox(
                  height: 160,
                  child: Visibility(
                    visible: isLoadingUpComing,
                    replacement: const Center(child: CircularProgressIndicator()),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: upComingList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: InkWell(
                            onTap: () {},
                            child: builImage(upComingList[index][0]['poster_path'])
                          )
                        );
                      },
                    )
                  ),
                ),
                const SizedBox(height: 32),
              ],
            )
          ),
        ),
      ),
    );
  }

  Widget builImage(String urlImage) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        urlImage,
        fit: BoxFit.cover,
      ),
    );
  }

  Future<void> getMovieTrending() async {
    setState(() {
      isLoadingSlider = false;
    });
    final response = await ApiServices.getMovieTrending();
    if(response.statusCode == 200) {
      setState(() {
        trendingList = jsonDecode(response.body) as List<dynamic>;
        isLoadingSlider = true;
      });
    }
  }

  Future<void> getMoviePopular() async {
    setState(() {
      isLoadingPopular = false;
    });
    final response = await ApiServices.getMoviePopular();

    if(response.statusCode == 200) {
      setState(() {
        popularList = jsonDecode(response.body) as List<dynamic>;
        isLoadingPopular = true;
      });
    }
  }

  Future<void> getMovieNowPlaying() async {
    setState(() {
      isLoadingNowPlaying = false;
    });
    final response = await ApiServices.getMovieNowPlaying();

    if(response.statusCode == 200) {
      setState(() {
        nowPlayingList = jsonDecode(response.body) as List<dynamic>;
        isLoadingNowPlaying = true;
      });
    }
  }

  Future<void> getMovieUpComing() async {
    setState(() {
      isLoadingUpComing = false;
    });
    final response = await ApiServices.getMovieUpComing();

    if(response.statusCode == 200) {
      setState(() {
        upComingList = jsonDecode(response.body) as List<dynamic>;
        isLoadingUpComing = true;
      });
    }
  }
}
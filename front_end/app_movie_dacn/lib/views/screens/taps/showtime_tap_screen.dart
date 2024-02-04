import 'dart:convert';

import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/services/movies_api.dart';
import 'package:app_movie/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

class ShowtimeTapScreen extends StatefulWidget {
  const ShowtimeTapScreen({super.key});

  @override
  State<ShowtimeTapScreen> createState() => _ShowtimeTapScreenState();
}

class _ShowtimeTapScreenState extends State<ShowtimeTapScreen> {
  List<dynamic> weekdays = [];
  late Map<String, dynamic> showtimes;
  List<dynamic> keys = [];

  int currentIndex = 0;

  late Future<Map<String, dynamic>> dataShowtime;

  @override
  void initState() {
    super.initState();
    weekdays = HomeScreen.weekdayList;
    dataShowtime = fetchShowtime(currentIndex.toString());
  }

  Future<Map<String, dynamic>> fetchShowtime(String weekdayId) async {
    await getShowtime(weekdayId);
    showtimes = await getShowtime(weekdayId);
    keys = showtimes.keys.toList();
    return showtimes;
  }

  @override
  Widget build(BuildContext context) {

    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 32),
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height
            ),
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
                Stack(
                  children: [
                    Image.asset(
                    'assets/images/map.png',
                    fit: BoxFit.cover,
                    ),
          
                    Positioned(
                      bottom: 16,
                      left: 42,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: button1.withOpacity(.7),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8)
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              IconlyBold.location,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              '18A Cộng Hoà, Phường 4, Quận Tân Bình,\nTP Hồ Chí Minh',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Colors.white,
                                fontSize: 14
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 32),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: weekdays.length,
                          itemBuilder: (context, index) {
                            return customWeekday(
                              weekdays[index], 
                              () {
                                setState(() {
                                  currentIndex = weekdays[index]['id'];
                                  dataShowtime = fetchShowtime(currentIndex.toString());
                                });
                              }, 
                              false
                            );
                          }
                        ),
                      ),

                      FutureBuilder(
                        future: dataShowtime,
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return const Center(child: CircularProgressIndicator(
                              color: primaryMain1,
                            ));
                          }else if(snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }else {
                            return Visibility(
                              visible: keys[0] == 'null' ? false : true,
                              replacement: SizedBox(
                                height: MediaQuery.of(context).size.height / 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Chưa có lịch chiếu chi tiết hôm nay',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.headlineLarge,
                                    ),
                                  ],
                                ),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: keys.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => customMovieOfDay(showtimes[keys[index]])
                              ),
                            );
                          }
                        }
                      )
                    ],
                  ),
                )
              ]
            )
          ),
        ),
      ),
    );
  }

  Widget customWeekday(dynamic weekday, Function() onTap, bool checked) {
    DateFormat dateFormat = DateFormat('yyy-MM-dd');
    DateTime date = dateFormat.parse(weekday['date']);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          gradient: !checked 
          ? LinearGradient(
            colors: [ 
              const Color(0xFFD7F3F6).withOpacity(.6), 
              const Color(0xFFF2F2F2)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
          : LinearGradient(
            colors: [ 
              const Color(0xFFFED5B4), 
              const Color(0xFFC94044).withOpacity(.46)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8)
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              weekday['name'],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: !checked ? button1 : Colors.white,
                fontWeight: FontWeight.w700
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 1,
              width: 28,
              color: button2.withOpacity(.42),
            ),
            const SizedBox(height: 8),
            Text(
              date.day < 10 ? '0${date.day.toString()}' : date.day.toString(),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: !checked ? button1 : Colors.white,
                fontSize: 18
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget customMovieOfDay(List<dynamic> showtime) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              width: 120,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 1,
                  color: Colors.white
                )
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  showtime[0]['movie_poster'],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child; // Ảnh đã được tải thành công, hiển thị nó
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: primaryMain1,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  showtime[0]['movie_name'],
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  showtime[0]['movie_genres'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  showtime[0]['movie_country'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${showtime[0]['duration']} phút',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                GridView.count(
                  crossAxisCount: 4,
                  childAspectRatio: 5/3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: showtime.map((e) => customShowTime(e)).toList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget customShowTime(dynamic e) {
    return InkWell(
      onTap: () {
        print(e['timeframe_id']);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ 
              const Color(0xFFD7F3F6).withOpacity(.6), 
              const Color(0xFFF2F2F2)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          ),
          borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              e['start_time'],
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> getShowtime(String weekdayId) async {
    final response = await MovieApi.getShowtime(weekdayId);
    if(response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    return Map();
  }
}
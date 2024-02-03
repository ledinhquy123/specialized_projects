import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/views/screens/home_screen.dart';
import 'package:app_movie/views/widgets/custom_weekday.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ShowtimeTapScreen extends StatefulWidget {
  const ShowtimeTapScreen({super.key});

  @override
  State<ShowtimeTapScreen> createState() => _ShowtimeTapScreenState();
}

class _ShowtimeTapScreenState extends State<ShowtimeTapScreen> {
  List<dynamic> weekdays = [];
  List<dynamic> showtimes = [];

  int currentIndex = 0;
  List<bool> check = List.generate(7, (index) => false);

  @override
  void initState() {
    super.initState();
    weekdays = HomeScreen.weekdayList;
    showtimes = HomeScreen.showtimeList;
    print(showtimes);
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
                      // Row(
                      //   // children: weekdays.keys.map,
                      // )
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: weekdays.length,
                          itemBuilder: (context, index) {
                            return CustomWeekday(
                              weekday: weekdays[index],
                              onTap: () {
                                setState(() {
                                  currentIndex = weekdays[index]['id'];
                                  check[index] = !check[index];
                                  print(currentIndex);
                                });
                              },
                              checked: check[index],
                            );
                          }
                        ),
                      ),

                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: showtimes.length,
                        itemBuilder: (context, index) {
                          return Text(
                           showtimes[index]['data'].toString()
                          );
                        },
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
}
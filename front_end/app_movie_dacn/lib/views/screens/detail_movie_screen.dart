import 'dart:convert';

import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/services/movies_api.dart';
import 'package:app_movie/utils/button_back.dart';
import 'package:app_movie/views/screens/home_screen.dart';
import 'package:app_movie/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class DeatailMovieScreen extends StatefulWidget {
  String id;
  DeatailMovieScreen({
    super.key,
    required this.id
  });

  @override
  State<DeatailMovieScreen> createState() => _DeatailMovieScreenState();
}

class _DeatailMovieScreenState extends State<DeatailMovieScreen> {
  late Future<List<dynamic>> allActors;

  late YoutubePlayerController videoController;
  bool buyTicket = false;

  List<dynamic> dataActor = [];
  List<dynamic> movie = [];

  @override
  void initState() {
    super.initState();
    movie = HomeScreen.allMovies.where(
      (element) => element['id_movie'] == widget.id
    ).toList();

    final check = HomeScreen.nowPlayingList.where(
      (element) => element['id_movie'] == widget.id
    ).toList();

    setState(() {
      if(check.isNotEmpty) buyTicket = true;
    });
    allActors = fetchActor();
  }

  Future<List<dynamic>> fetchActor() async {
    dataActor = await getActor();
    // print(dataActor);
    return dataActor;
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
            child: FutureBuilder(
              future: allActors,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(
                    color: primaryMain1,
                  ));
                } else if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
                } else {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 8),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child: Image.network(
                              movie[0]['backdrop_path'],
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
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
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              children: [
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Diễn viên',
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                    itemCount: dataActor.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => infoActor(
                                      dataActor[index]['profile_path'],
                                      dataActor[index]['name'],
                                      dataActor[index]['character'],
                                    )
                                  ),
                                ),
                                
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Trailer',
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: YoutubePlayer(
                                    controller: YoutubePlayerController(
                                      initialVideoId: YoutubePlayer.convertUrlToId(movie[0]['video_path'])!,
                                      flags: const YoutubePlayerFlags(
                                        autoPlay: false,
                                        mute: true
                                      )
                                    ),
                                    showVideoProgressIndicator: true,
                                    progressIndicatorColor: Colors.blueAccent,
                                  ),
                                ),
                                const SizedBox(height: 32),

                                Visibility(
                                  visible: buyTicket,
                                  replacement: const Text('Hiện tại phim không chiếu tại rạp'),
                                  child: CustomButton(
                                    width: MediaQuery.of(context).size.width / 1.2,
                                    height: MediaQuery.of(context).size.height / 20,
                                    text: 'Mua vé',
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700
                                    ),
                                    onTap: () {}
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 5,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryMain2.withOpacity(.7),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8)
                            )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                movie[0]['title'],
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headlineLarge!.
                                copyWith(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 30,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Đánh giá: ',
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Icon(
                                    IconlyBold.star,
                                    size: 12,
                                    color: Color(0xFFFFD233),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${movie[0]['vote_average'].toStringAsFixed(1)}/10',
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              ),
                                                
                              Text(
                                'Thể loại: ${movie[0]['genres']}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Quốc gia: ${movie[0]['country']}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Thời lượng: ${movie[0]['runtime']} phút',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                                                
                              Text(
                                movie[0]['over_view'],
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      showButtonBack(
                        context, 
                        primaryMain2, 
                        primaryMain1, 
                        Icons.arrow_back,
                        32,
                        24
                      ),
                    ],
                  );
                }
              },
            )
          ),
        ),
      ),
    );
    
  }

  Future<List<dynamic>> getActor() async {
    final response = await MovieApi.getActors(widget.id);
    if(response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }
    return [];
  }

  Widget infoActor(String urlImage, String name, String character) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.network(
                  urlImage,
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
          const SizedBox(height: 8),

          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            character,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
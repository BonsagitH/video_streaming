import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(MainVideosPage());
}

class MainVideosPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MainVideosPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Streaming App',
      home: VideoApp(),
    );
  }
}

double ht = 0.0, wdt = 0.0;

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  List videos = [
    'http://192.168.101.62:9000/cooking',
    'http://192.168.101.62:9000/dancing',
    'http://192.168.101.62:9000/exercise',
    'http://192.168.101.62:9000/sports',
    'http://192.168.101.62:9000/learning',
    'http://192.168.101.62:9000/driving',
  ];

  List images = [
    'http://192.168.101.62:9000/cooking_img',
    'http://192.168.101.62:9000/dancing_img',
    'http://192.168.101.62:9000/exercise_img',
    'http://192.168.101.62:9000/sports_img',
    'http://192.168.101.62:9000/learning_img',
    'http://192.168.101.62:9000/driving_img',
  ];
  List titles = [
    'Cooking',
    'Dance',
    'Exercise',
    'Sports',
    'Learning',
    'Github',
  ];
  List description = [
    '  Cooking...',
    'Dancing .... ',
    'Daily ....',
    'Climb ....',
    "Let's Learn new",
    'Long Drive '
  ];
  List times = [
    '0:27',
    '0:12',
    '0:15',
    '0:22',
    '0:21',
    '0:15',
  ];

  @override
  Widget build(BuildContext context) {
    ht = MediaQuery.of(context).size.height / 1000;
    wdt = MediaQuery.of(context).size.width / 1000;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(
          'Slide Preview of new Contents',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              GestureDetector(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Material(
                          child: Ink.image(
                            image: NetworkImage(
                              images[index],
                            ),
                            height: 280 * ht,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 50 * ht,
                      right: 40 * wdt,
                      child: Container(
                        padding: EdgeInsets.all(5 * ht),
                        color: Colors.grey[900],
                        child: Text(
                          times[index],
                          style: TextStyle(
                            color: Colors.grey[50],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  setState(
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Videos(
                            imageS: images[index],
                            videoS: videos[index],
                            titleS: titles[index],
                            descriptionS: description[index],
                            image: images,
                            video: videos,
                            title: titles,
                            description: description,
                            time: times,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              rows(
                images[index],
                titles[index],
                description[index],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget rows(img, tlt, desc) {
    return Row(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 15 * wdt, vertical: 10 * ht),
          child: Container(
            height: 50 * ht,
            width: 50 * ht,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
              image: DecorationImage(
                image: NetworkImage(img),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tlt,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 2 * ht,
            ),
            Text(desc),
          ],
        )
      ],
    );
  }
}

class Videos extends StatefulWidget {
  final String imageS, videoS, titleS, descriptionS;
  final List image, video, title, description, time;
  const Videos({
    required this.imageS,
    required this.videoS,
    required this.titleS,
    required this.descriptionS,
    required this.image,
    required this.video,
    required this.title,
    required this.description,
    required this.time,
  });
  @override
  _VideosState createState() => _VideosState(
        imageS: this.imageS,
        videoS: this.videoS,
        titleS: this.titleS,
        descriptionS: this.descriptionS,
        images: this.image,
        videos: this.video,
        titles: this.title,
        descriptions: this.description,
        times: time,
      );
}

class _VideosState extends State<Videos> {
  String imageS, videoS, titleS, descriptionS;
  List images, videos, titles, descriptions, times;
  _VideosState({
    required this.imageS,
    required this.videoS,
    required this.titleS,
    required this.descriptionS,
    required this.images,
    required this.videos,
    required this.titles,
    required this.descriptions,
    required this.times,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.grey[900],
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer.network(videoS),
          ),
          rows2(
            imageS,
            titleS,
            descriptionS,
          ),
          Divider(
            color: Colors.orange[300],
            height: 2 * ht,
            thickness: 2,
          ),
          SizedBox(
            height: 20 * ht,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return images[index] == imageS
                    ? Container()
                    : Column(
                        children: [
                          GestureDetector(
                            child: Stack(
                              children: [
                                Image.network(
                                  images[index],
                                  height: 280 * ht,
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                                Positioned(
                                  bottom: 20 * ht,
                                  right: 40 * wdt,
                                  child: Container(
                                    padding: EdgeInsets.all(5 * ht),
                                    color: Colors.grey[900],
                                    child: Text(
                                      times[index],
                                      style: TextStyle(
                                        color: Colors.grey[50],
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                imageS = images[index];
                                videoS = videos[index];
                                titleS = titles[index];
                                descriptionS = descriptions[index];
                              });
                            },
                          ),
                          rows2(
                            images[index],
                            titles[index],
                            descriptions[index],
                          ),
                          SizedBox(height: 10 * ht),
                        ],
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget rows2(img, tlt, desc) {
    // this class is used to make the circular image, title, and description under the displayed image
    return Row(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 15 * wdt, vertical: 10 * ht),
          child: Container(
            height: 50 * ht,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
              image: DecorationImage(
                image: NetworkImage(img),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tlt,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 3 * ht,
            ),
            Text(desc),
          ],
        )
      ],
    );
  }
}

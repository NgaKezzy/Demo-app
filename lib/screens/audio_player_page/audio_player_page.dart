import 'package:flutter/material.dart';
import 'package:test_bloc/config/print_color.dart';
import 'package:test_bloc/screens/audio_player_page/music_player.dart';
import 'package:test_bloc/screens/audio_player_page/song_list.dart';
import 'package:test_bloc/screens/audio_player_page/title_page_view.dart';

class AudioPlayerPage extends StatefulWidget {
  const AudioPlayerPage({super.key});

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  bool isMusic = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final PageController pageController = PageController(initialPage: 0);

    final List<Widget> page = [
      const MusicPlayer(),
      const SongList(),
    ];

    return Scaffold(
      body: SafeArea(
        child: Container(
            height: height,
            width: width,
            padding: EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFFFF9B50), Color(0xFF952323)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Stack(
              children: [
                PageView(
                  controller: pageController,
                  onPageChanged: (int page) {
                    if (page == 0) {
                      setState(() {
                        isMusic = true;
                      });
                    } else {
                      setState(() {
                        isMusic = false;
                      });
                    }
                    printRed(isMusic.toString());
                  },
                  children: page,
                ),
                Positioned(
                  child: isMusic
                      ? const TitlePageView(
                          title: 'Music', widthFirst: 20, widthLast: 5)
                      : const TitlePageView(
                          title: 'Song List', widthFirst: 5, widthLast: 20),
                )
              ],
            )),
      ),
    );
  }
}

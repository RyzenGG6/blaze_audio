import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class mainscreen extends StatefulWidget {
  const mainscreen({super.key});

  @override
  State<mainscreen> createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  IconData? icon;
  final OnAudioQuery audioQuery = OnAudioQuery();
  final AudioPlayer audioPlayer = AudioPlayer();

  var color = Colors.white;
  var audiopath;
  @override
  void initState() {
    super.initState();
    icon = Icons
        .play_arrow; // Set a default icon value when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, 'home');
          },
          child:Icon(Icons.arrow_back),),
        title: Text('Audio Files'),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: FutureBuilder<List<SongModel>>(
              future: OnAudioQuery().querySongs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error loading audio files.'),
                  );
                } else if (snapshot.hasData) {
                  List<SongModel> songs = snapshot.data!;
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 50, top: 20),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: songs.length,
                          itemBuilder: (context, index) {
                            SongModel song = songs[index];
                            String title = song.title;
                            String? artist = song.artist;
                            final String? audiopath = songs[index].uri;
                            return SafeArea(
                              child: Container(
                                padding: EdgeInsets.only(top: 10),
                                margin: EdgeInsets.all(10),
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(5),
                                  tileColor: this.color,
                                  onTap: () {
                                    this.audiopath = audiopath;
                                    setState(() {});
                                  },
                                  title: Text(
                                    title,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(width: 1.5),
                                      borderRadius: BorderRadius.circular(20)),
                                  subtitle: Text(artist!),
                                  leading: Icon(Icons.music_note),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text('No audio files found.'),
                  );
                }
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    icon = getIcon();
                  });

                  // Call the function to handle audio play
                  if (icon == Icons.play_arrow) {
                    await audioPlayer.stop();
                  } else if (icon == Icons.stop) {
                    // Call stop()

                    await playAudioFromUri(audiopath);
                  }
                },
                child: Icon(icon)),
          ),
        ],
      ),
    );
  }

  Future<void> playAudioFromUri(audioUri) async {
    try {
      await audioPlayer.setUrl(audioUri);
      await audioPlayer.play();
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  IconData? getIcon() {
    if (icon == Icons.play_arrow) {
      icon = Icons.stop;
      return icon;
    } else if (icon == Icons.stop) {
      icon = Icons.play_arrow;
      return icon;
    }

    // Return the original icon if none of the conditions match.
    return icon;
  }
}

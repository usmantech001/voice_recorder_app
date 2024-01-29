import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:social_media_recorder/audio_encoder_type.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Record record;
  String audiopath = '';
  final audioPlayer = AudioPlayer();
 late FlutterSoundRecorder recordAudio;
  String duration = '0:0';
  bool isRecording = false;
  
  @override
  void initState() {
    super.initState();
    record = Record();
    recordAudio = FlutterSoundRecorder();
  }

  @override
  void dispose() {
    super.dispose();
    record.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Recording App') , 
        centerTitle: true,
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
           
            VoiceMessageView(
              controller: VoiceController(
                audioSrc: audiopath,
                maxDuration:  Duration(seconds: int.parse(duration.split(':')[0]) +1),
                isFile: true,
                onComplete: () {},
                onPause: () {},
                onPlaying: () {},
                onError: (err) {
                },
              ),
            ),
           
            
        

            
             SocialMediaRecorder(
             radius: BorderRadius.circular(10),
              startRecording: () async {
                 
               
              },
              stopRecording: (_time) async {
                
               String? path = await record.stop();
                setState(() {
                duration =  _time;
                  audiopath = path!;
                });
                print('sent');
              },
              sendRequestFunction: (soundFile, _time) async {
                bool hasPermission = await record.hasPermission();
                if(hasPermission){
                  await record.start();
                }else{

                }
              },
              encode: AudioEncoderType.AAC,
            ),
          ],
        ),
      ),
    );
  }
}

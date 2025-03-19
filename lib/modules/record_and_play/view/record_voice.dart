import 'package:aavaaz_app/modules/record_and_play/models/record_audio_model.dart';
import 'package:aavaaz_app/modules/record_and_play/view/widget/mic_animation_example.dart';
import 'package:aavaaz_app/modules/record_and_play/view_model/record_audio_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RecordVoiceView extends StatefulWidget {
  const RecordVoiceView({super.key});
  @override
  State<RecordVoiceView> createState() => _RecordVoiceViewState();
}

class _RecordVoiceViewState extends State<RecordVoiceView> {
  final AudioViewModel viewModel = AudioViewModel();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AudioModel>(
      valueListenable: viewModel,
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            toolbarHeight: 70,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Image.asset(
                "assets/vectorLogo.png",
                repeat: ImageRepeat.noRepeat,
                filterQuality: FilterQuality.high,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: CircleAvatar(
                  maxRadius: 22,
                  backgroundImage: AssetImage("assets/Avatar.png"),
                ),
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(child: Center(child: ShapeScreen())),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                height: MediaQuery.sizeOf(context).height * 0.2,
                child: value.isRecording ?
                    SizedBox(
                      //height: 20,
                      width: double.infinity,
                      child: Lottie.asset('assets/waveanimation.json'),
                    ) :
                    languageSelectionWidget(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget languageSelectionWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.07,
          width: MediaQuery.sizeOf(context).width * 0.33,
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              "English",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
        Icon(
          Icons.compare_arrows,
          color: Colors.white,
        ),
        Container(
          height: MediaQuery.sizeOf(context).height * 0.07,
          width: MediaQuery.sizeOf(context).width * 0.33,
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              "German",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'dart:io';

import 'package:aavaaz_app/modules/record_and_play/models/record_audio_model.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:record/record.dart';

class AudioViewModel extends ValueNotifier<AudioModel> {
  // AudioModel _audioModel = AudioModel();
  // final ValueNotifier<AudioModel> _audioModel =
  //     ValueNotifier<AudioModel>(AudioModel());

  final _audioRecorder = AudioRecorder();
  final _audioPlayer = AudioPlayer();

  AudioViewModel() : super(AudioModel());

  // ValueNotifier<AudioModel> get audioModel => _audioModel;

  Future<void> toggleRecording() async {
    if (value.isRecording) {
      await _stopRecording();
    } else {
      await _startRecording();
    }
    notifyListeners();
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        final String filePath = path.join(
          appDocDir.path,
          "recording_${DateTime.now().millisecondsSinceEpoch}.wav",
        );
        print("Recording Started $filePath");
        await _audioRecorder.start(RecordConfig(), path: filePath);
        value = AudioModel(isRecording: true);
      }
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      String? path = await _audioRecorder.stop();
      value = AudioModel(filePath: path, isRecording: false);
      print("Recording Stoped $path");
      await _playRecording();
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  Future<void> _playRecording() async {
    print("Recording Playing ${value.filePath}");

    if (value.filePath != null) {
      await _audioPlayer.setFilePath(value.filePath!);
      await _audioPlayer.play();
    }
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }
}

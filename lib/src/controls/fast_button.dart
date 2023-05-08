import 'package:appinio_video_player/src/custom_video_player_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomVideoPlayerFastRewindClick extends StatelessWidget {
  final CustomVideoPlayerController customVideoPlayerController;
  final Function fadeOutOnPlay;
  const CustomVideoPlayerFastRewindClick({
    Key? key,
    required this.customVideoPlayerController,
    required this.fadeOutOnPlay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: customVideoPlayerController.isPlayingNotifier,
        builder: (context, isPlaying, _) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => _fastRewind(isPlaying),
            child: customVideoPlayerController
                .customVideoPlayerSettings.fastRewind,
          );
        });
  }

  Future<void> _fastRewind(isPlaying) async {
    Duration? currentDuration = await customVideoPlayerController.videoPlayerController.position;
    if (currentDuration != null) {
      currentDuration = Duration(seconds: currentDuration.inSeconds.toInt() - 10);
      if (!isPlaying) {
        if (currentDuration < const Duration(seconds: 10)) {
          customVideoPlayerController.videoProgressNotifier.value = Duration(seconds: 0);
          await customVideoPlayerController.videoPlayerController.seekTo(Duration(seconds: 0));
        } else {
          customVideoPlayerController.videoProgressNotifier.value = currentDuration;
          await customVideoPlayerController.videoPlayerController.seekTo(currentDuration);
        }
      } else {
        await customVideoPlayerController.videoPlayerController.seekTo(currentDuration);
      }
    }
  }
}

class CustomVideoPlayerFastRewindButton extends StatelessWidget {
  const CustomVideoPlayerFastRewindButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
      child: Icon(
        Icons.fast_rewind_outlined,
        color: CupertinoColors.white,
      ),
    );
  }
}

class CustomVideoPlayerFastForwardClick extends StatelessWidget {
  final CustomVideoPlayerController customVideoPlayerController;
  final Function fadeOutOnPlay;
  const CustomVideoPlayerFastForwardClick({
    Key? key,
    required this.customVideoPlayerController,
    required this.fadeOutOnPlay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: customVideoPlayerController.isPlayingNotifier,
        builder: (context, isPlaying, _) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => _fastForward(),
            child: customVideoPlayerController
                .customVideoPlayerSettings.fastForward,
          );
        });
  }

  Future<void> _fastForward() async {
    Duration? currentDuration = await customVideoPlayerController.videoPlayerController.position;
    if (currentDuration != null) {
      currentDuration = Duration(seconds: currentDuration.inSeconds.toInt() + 10);
      Duration totalDuration = customVideoPlayerController.videoPlayerController.value.duration;
      if (totalDuration < currentDuration) {
        customVideoPlayerController.videoProgressNotifier.value = totalDuration;
        await customVideoPlayerController.videoPlayerController.seekTo(totalDuration);
      } else {
        customVideoPlayerController.videoProgressNotifier.value = currentDuration;
        await customVideoPlayerController.videoPlayerController.seekTo(currentDuration);
      }
    }
  }
}

class CustomVideoPlayerFastForwardButton extends StatelessWidget {
  const CustomVideoPlayerFastForwardButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
      child: Icon(
        Icons.fast_forward_outlined,
        color: CupertinoColors.white,
      ),
    );
  }
}

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/components/components.dart';
import 'package:intl/intl.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final AssetEntity video;

  const VideoPage({
    super.key,
    required this.video,
  });

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  bool isLoadingVideo = true;
  late ChewieController chewieController;
  late VideoPlayerController videoPlayerController;

  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();

    if (widget.video.type == AssetType.video) {
      widget.video.originFile.then((value) {
        videoPlayerController = VideoPlayerController.file(value!);

        videoPlayerController.initialize().then((_) {
          chewieController = ChewieController(
            videoPlayerController: videoPlayerController,
            autoPlay: true,
            looping: true,
            showControls: true,
            hideControlsTimer: const Duration(seconds: 1),
            materialProgressColors: ChewieProgressColors(
              playedColor: Colors.red,
              handleColor: Colors.red.shade900,
              backgroundColor: Colors.white,
              bufferedColor: Colors.white,
            ),
          );

          setState(() {
            isLoadingVideo = false;
          });
        });
      });
    }
  }

  @override
  void dispose() {
    chewieController.dispose();
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingVideo) {
      return const PageLoading();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Chewie(
        controller: chewieController,
      ),
      bottomNavigationBar: Container(
        color: Colors.black.withOpacity(0.5),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat.yMMMMd().format(widget.video.createDateTime),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 20),
            Text(
              "${widget.video.width} X ${widget.video.height}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

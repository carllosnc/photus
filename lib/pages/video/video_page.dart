import 'dart:typed_data';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import '/imports/app.dart';

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
            hideControlsTimer: const Duration(seconds: 2),
            materialProgressColors: ChewieProgressColors(
              playedColor: Colors.blue,
              handleColor: Colors.blue.shade900,
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

  Future<void> removeVideo(BuildContext context) async {
    var id = await PhotoManager.editor.deleteWithIds([widget.video.id]);

    if (id.isNotEmpty) {
      files.removeMediaById(widget.video.id);
      files.removedMedias.add(widget.video.id);

      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  void shareVideo() {
    widget.video.file.then((value) {
      Uint8List bytes = value!.readAsBytesSync();

      Share.shareXFiles([
        XFile.fromData(
          bytes,
          name: widget.video.title,
          mimeType: widget.video.mimeType,
        )
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingVideo) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(
                Icons.delete_outline,
              ),
              iconSize: 20,
              onPressed: () {
                removeVideo(context);
              },
            ),
          ],
        ),
        body: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
            ),
            iconSize: 20,
            onPressed: () {
              removeVideo(context);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.share_outlined,
            ),
            iconSize: 20,
            onPressed: shareVideo,
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
              widget.video.createDateTime.formattedDate,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 20),
            Text(
              "${widget.video.width} X ${widget.video.height}",
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

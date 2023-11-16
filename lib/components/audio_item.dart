import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:share_plus/share_plus.dart';
import '/imports/app.dart';

class AudioItem extends StatelessWidget {
  const AudioItem({
    super.key,
    required this.asset,
  });

  final AssetEntity asset;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final player = AudioPlayer();

        showModalBottomSheet(
          context: context,
          builder: (context) {
            asset.file.then((value) {
              player.setFilePath(value!.path);
            });

            return AudioItemContent(
              player: player,
              asset: asset,
            );
          },
        ).whenComplete(() {
          player.dispose();
        });
      },
      child: Container(
        color: Colors.red.shade700,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.headphones,
                color: Colors.black.withOpacity(0.5),
                size: 30,
              ),
              const SizedBox(height: 5),
              Text(
                Duration(seconds: asset.duration).formattedDuration,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AudioItemContent extends StatefulWidget {
  const AudioItemContent({
    super.key,
    required this.player,
    required this.asset,
  });

  final AudioPlayer player;
  final AssetEntity asset;

  @override
  State<AudioItemContent> createState() => _AudioItemContentState();
}

class _AudioItemContentState extends State<AudioItemContent> with FilesMixin {
  void shareAudio() {
    widget.asset.file.then((value) async {
      Uint8List bytes = await value!.readAsBytes();

      Share.shareXFiles([
        XFile.fromData(
          bytes,
          name: widget.asset.title,
          mimeType: widget.asset.mimeType,
        )
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: const Color.fromARGB(255, 25, 25, 25),
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: Column(
        children: [
          PlayerWidget(player: widget.player),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.fromLTRB(35, 0, 20, 0),
            child: Row(
              children: [
                Text(
                  widget.asset.createDateTime.formattedDate,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.share_outlined,
                    size: 20,
                  ),
                  onPressed: shareAudio,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    size: 20,
                  ),
                  onPressed: () async {
                    var id = await PhotoManager.editor.deleteWithIds([widget.asset.id]);

                    if (id.isNotEmpty) {
                      files.removeMediaById(widget.asset.id);
                      files.removedMedias.add(widget.asset.id);

                      if (context.mounted) {
                        Navigator.pop(context, true);
                      }
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

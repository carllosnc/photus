import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';
import '/imports/app.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class PhotoPage extends StatefulWidget {
  final AssetEntity photo;

  const PhotoPage({
    super.key,
    required this.photo,
  });

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> with FilesMixin {
  bool isFullScreen = false;
  bool isLoading = true;

  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  removePhoto(BuildContext context) async {
    var id = await PhotoManager.editor.deleteWithIds([widget.photo.id]);

    if (id.isNotEmpty) {
      files.removeMediaById(widget.photo.id);
      files.removedMedias.add(widget.photo.id);

      if (context.mounted) {
        Navigator.pop(context, true);
      }
    }
  }

  void sharePhoto() {
    widget.photo.file.then((value) {
      Uint8List bytes = value!.readAsBytesSync();

      Share.shareXFiles([
        XFile.fromData(
          bytes,
          name: widget.photo.title,
          mimeType: widget.photo.mimeType,
        )
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: isFullScreen,
      extendBody: isFullScreen,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        actions: [
          IconButton(
            icon: Icon(
              isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
              color: isFullScreen ? Colors.greenAccent : Colors.yellow,
            ),
            iconSize: 22,
            onPressed: () {
              setState(() {
                isFullScreen = !isFullScreen;
              });
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
            ),
            iconSize: 20,
            onPressed: () {
              removePhoto(context);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.share_outlined,
            ),
            iconSize: 20,
            onPressed: sharePhoto,
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child: InteractiveViewer(
                maxScale: 3.0,
                minScale: 1.0,
                constrained: true,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: FadeInImage(
                    fit: BoxFit.contain,
                    fadeInDuration: const Duration(milliseconds: 300),
                    placeholder: MemoryImage(kTransparentImage),
                    image: AssetEntityImageProvider(
                      widget.photo,
                      isOriginal: true,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
              widget.photo.createDateTime.formattedDate,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 20),
            Text(
              "${widget.photo.width} X ${widget.photo.height}",
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

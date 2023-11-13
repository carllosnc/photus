import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotoPage extends StatefulWidget {
  final AssetEntity photo;

  const PhotoPage({
    super.key,
    required this.photo,
  });

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  bool isFullScreen = false;
  bool isLoading = true;

  final DateFormat formatter = DateFormat('dd/MM/yyyy');

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
              color: isFullScreen ? Colors.greenAccent : Colors.white,
            ),
            onPressed: () {
              setState(() {
                isFullScreen = !isFullScreen;
              });
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.edit,
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
              DateFormat.yMMMMd().format(widget.photo.createDateTime),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 20),
            Text(
              "${widget.photo.width} X ${widget.photo.height}",
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

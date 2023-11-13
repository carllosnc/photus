import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import '/imports/app.dart';

class AlbumPage extends StatefulWidget {
  final AssetPathEntity album;

  const AlbumPage({
    super.key,
    required this.album,
  });

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  List<AssetEntity> photos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadImages();
  }

  loadImages() async {
    final List<AssetEntity> media = await widget.album.getAssetListRange(
      start: 0,
      end: 1000000,
    );

    setState(() {
      photos = media;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const PageLoading();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.album.name,
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.calendar_month_outlined,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: MediaGrid(
        assets: photos,
      ),
    );
  }
}

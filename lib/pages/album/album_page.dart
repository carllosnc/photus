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

class _AlbumPageState extends State<AlbumPage> with FilesMixin {
  List<AssetEntity> items = [];

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
      items = media;
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(files.startDate == null ? 0 : 40),
          child: const DateFilterIndicator(),
        ),
        title: Text(
          widget.album.name,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        actions: const [
          DateFilter(),
        ],
      ),
      body: MediaGrid(
        assets: items,
      ),
    );
  }
}

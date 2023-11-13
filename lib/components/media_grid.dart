import 'package:flutter/material.dart';
import 'package:flutter_starter/imports/app.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaGrid extends StatelessWidget {
  final List<AssetEntity> assets;

  const MediaGrid({
    super.key,
    required this.assets,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemCount: assets.length,
      itemBuilder: (context, index) {
        return Media(
          asset: assets[index],
        );
      },
    );
  }
}

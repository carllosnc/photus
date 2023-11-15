import 'package:flutter/material.dart';
import '/imports/app.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaGrid extends StatefulWidget {
  final List<AssetEntity> assets;

  const MediaGrid({
    super.key,
    required this.assets,
  });

  @override
  State<MediaGrid> createState() => _MediaGridState();
}

class _MediaGridState extends State<MediaGrid> with FilesMixin {
  @override
  Widget build(BuildContext context) {
    List<AssetEntity> items = [...widget.assets];

    if (files.startDate != null && files.endDate != null) {
      items.removeWhere((asset) {
        return asset.createDateTime.isBefore(files.startDate!) || asset.createDateTime.isAfter(files.endDate!);
      });
    }

    if (files.startDate != null && files.endDate == null) {
      items.removeWhere((asset) {
        return asset.createDateTime.isBefore(files.startDate!);
      });
    }

    if (files.startDate == null && files.endDate == null) {
      items = widget.assets;
    }

    items.removeWhere((asset) {
      return files.removedMedias.contains(asset.id);
    });

    if (items.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '😐',
              style: TextStyle(
                fontSize: 90,
              ),
            ),
            Text(
              'No files found',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Media(
          asset: items[index],
        );
      },
    );
  }
}

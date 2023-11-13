import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:go_router/go_router.dart';

class Media extends StatelessWidget {
  final AssetEntity asset;

  const Media({
    super.key,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    var image = AssetEntityImageProvider(
      asset,
      isOriginal: false,
      thumbnailSize: const ThumbnailSize.square(100),
      thumbnailFormat: ThumbnailFormat.jpeg,
    );

    return Stack(
      children: [
        Positioned(
          width: 105,
          height: 105,
          child: Container(
            color: const Color.fromARGB(255, 42, 42, 42),
            child: GestureDetector(
              onTap: () {
                if (asset.type == AssetType.video) {
                  context.push('/video', extra: asset);
                  return;
                }

                if (asset.type == AssetType.image) {
                  context.push('/photo', extra: asset);
                  return;
                }
              },
              child: FadeInImage(
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 300),
                placeholder: MemoryImage(kTransparentImage),
                image: image,
              ),
            ),
          ),
        ),
        if (asset.type == AssetType.video)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.red.shade800,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
      ],
    );
  }
}

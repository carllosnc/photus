import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class _Files extends ChangeNotifier {
  bool isLoading = true;
  bool isPermissionGranted = false;
  bool isLoadingImages = true;
  bool isLoadingAlbums = true;
  List<AssetPathEntity> albums = [];
  Set<AssetEntity> medias = {};

  checkPermission() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();

    if (ps.isAuth) {
      isLoading = false;
      isPermissionGranted = true;
    } else if (ps.hasAccess) {
      isLoading = false;
      isPermissionGranted = false;
    } else {
      isLoading = false;
      isPermissionGranted = false;
    }

    await getAllPhotos();
    await getAllAlbuns();
    notifyListeners();
  }

  getAllAlbuns() async {
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList();

    albums = paths;
    isLoadingAlbums = false;
    notifyListeners();
  }

  getAllPhotos() async {
    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList();

    for (final AssetPathEntity album in albums) {
      final List<AssetEntity> media = await album.getAssetListRange(
        start: 0,
        end: 1000000,
      );

      for (final AssetEntity asset in media) {
        medias.add(asset);
      }
    }

    isLoadingImages = false;
    notifyListeners();
  }
}

final files = _Files();

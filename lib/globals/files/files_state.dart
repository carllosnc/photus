import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class _Files extends ChangeNotifier {
  bool isLoading = true;
  bool isPermissionGranted = false;
  bool isLoadingImages = true;
  bool isLoadingAlbums = true;
  List<AssetPathEntity> albums = [];
  Set<AssetEntity> medias = {};
  DateTime? startDate;
  DateTime? endDate;
  List<String> removedMedias = [];

  checkPermission() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();

    if (ps.isAuth) {
      isLoading = false;
      isPermissionGranted = true;
    } else if (ps.hasAccess) {
      isLoading = false;
      isPermissionGranted = true;
    } else {
      isLoading = false;
      isPermissionGranted = true;
    }

    await getAllPhotos();
    await getAllAlbuns();
    notifyListeners();
  }

  getAllAlbuns() async {
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
      type: RequestType.all,
    );

    albums = paths;
    isLoadingAlbums = false;
    notifyListeners();
  }

  getAllPhotos() async {
    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.all,
    );

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

  removeMediaById(String id) {
    medias.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  addToRemovedMedias(String id) {
    removedMedias.add(id);
    notifyListeners();
  }

  setRangeDate({DateTime? newStartDate, DateTime? newEndDate}) {
    startDate = newStartDate;
    endDate = newEndDate;
    notifyListeners();
  }
}

final files = _Files();

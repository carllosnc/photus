import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';
import '/imports/app.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/photo',
      builder: (context, state) {
        AssetEntity photo = state.extra as AssetEntity;

        return PhotoPage(
          photo: photo,
        );
      },
    ),
    GoRoute(
      path: '/video',
      builder: (context, state) {
        AssetEntity video = state.extra as AssetEntity;

        return VideoPage(
          video: video,
        );
      },
    ),
    GoRoute(
      path: '/albums',
      builder: (context, state) {
        return const AlbumsPage();
      },
    ),
    GoRoute(
      path: '/album',
      builder: (context, state) {
        AssetPathEntity album = state.extra as AssetPathEntity;

        return AlbumPage(
          album: album,
        );
      },
    ),
  ],
);

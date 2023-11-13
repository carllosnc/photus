import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/imports/app.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with FilesMixin {
  @override
  void initState() {
    super.initState();

    files.checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    if (files.isLoading || files.isLoadingImages) {
      return const PageLoading();
    }

    if (files.isPermissionGranted == false) {
      return const PermissionNotGranted();
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.grid_view_outlined,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.calendar_month_outlined,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.folder_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              context.push('/albums');
            },
          ),
        ],
        title: const Text(
          'PHOTUS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            letterSpacing: 2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: MediaGrid(
        assets: files.medias.toList(),
      ),
    );
  }
}

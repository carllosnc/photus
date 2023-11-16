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
      return const Center(
        child: SizedBox(
          width: 25,
          height: 25,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    if (files.isPermissionGranted == false) {
      return const PermissionNotGranted();
    }

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(files.startDate == null ? 0 : 40),
          child: const DateFilterIndicator(),
        ),
        actions: [
          const DateFilter(),
          IconButton(
            icon: const Icon(
              Icons.folder_outlined,
            ),
            iconSize: 20,
            onPressed: () {
              context.push('/albums');
            },
          ),
        ],
        title: const Text(
          'PHOTUS',
          style: TextStyle(
            fontSize: 14,
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

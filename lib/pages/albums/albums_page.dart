import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/imports/app.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({super.key});

  @override
  State<AlbumsPage> createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ALBUMS',
          style: TextStyle(
            fontSize: 14,
            letterSpacing: 2,
            fontWeight: FontWeight.w600,
          ),
        ),
        //border bottom
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            color: Colors.white.withOpacity(0.15),
            height: 1,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: files.albums.length,
        itemBuilder: (context, index) {
          String numberOfFiles = "-";

          return ListTile(
            title: Text(
              files.albums[index].name,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            leading: Icon(
              Icons.folder_outlined,
              size: 21,
              color: Colors.white.withOpacity(0.5),
            ),
            subtitle: StatefulBuilder(builder: (context, setInternalState) {
              files.albums[index].assetCountAsync.then((value) {
                if (context.mounted) {
                  setInternalState(() {
                    numberOfFiles = value.toString();
                  });
                }
              });
              return Text(
                "$numberOfFiles files",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.5),
                ),
              );
            }),
            onTap: () {
              context.push('/album', extra: files.albums[index]);
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_starter/imports/app.dart';

class PermissionNotGranted extends StatelessWidget {
  const PermissionNotGranted({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: 100,
              color: Colors.white.withOpacity(0.2),
            ),
            const SizedBox(height: 10),
            Text(
              'Permission not granted'.toUpperCase(),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Please allow access to photos',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 30),
            FilledButton(
              onPressed: () {
                files.checkPermission();
              },
              child: const Text('Try again'),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "If the permission popup is not showing up you will need to allow the access manually from the settings.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

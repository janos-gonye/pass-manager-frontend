import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: Align(
              alignment: Alignment.bottomCenter,
              child: CircularProgressIndicator())),
    );
  }
}

class LoaderService {
  static _Loader _loader;
  static OverlaySupportEntry overlay;

  static void displayLoader() {
    LoaderService.overlay = showOverlay((context, t) {
      LoaderService._loader = _loader;
      return _Loader();
      // Display the loader until it gets manually hidden
    }, duration: Duration(days: 365));
  }

  static void hideLoader() {
    LoaderService.overlay.dismiss();
  }
}

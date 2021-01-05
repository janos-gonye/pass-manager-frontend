import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
      Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        height: 3,
        left: 0,
        right: 0,
        child: LinearProgressIndicator(),
      )
    ]));
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

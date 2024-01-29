import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class RacerPage extends StatelessWidget {
  const RacerPage({
    super.key,
    required this.racerId,
  });
  final String racerId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(racerId),
          ),
        ),
      ),
    );
  }
}

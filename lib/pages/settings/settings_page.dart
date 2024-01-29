import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:racing/c_theme.dart';

final InAppReview inAppReview = InAppReview.instance;

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            const Text(
              'Settings',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SvgPicture.asset('images/bell.svg'),
          ],
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          ST(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => const ReadTrmsFormula(
                          fasil:
                              'https://docs.google.com/document/d/1vzdexsgM5DOxeRDiQvSAHd0Cc6korEoNEVSgiqCpnYY/edit?usp=sharing',
                        )),
              );
            },
            t: 'Privacy Policy',
          ),
          ST(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => const ReadTrmsFormula(
                          fasil:
                              'https://docs.google.com/document/d/12cRoRm4egm215x9LAGQqgAzvkEiKqo95zr0YWVlalv4/edit?usp=sharing',
                        )),
              );
            },
            t: 'Terms of use',
          ),
          ST(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => const ReadTrmsFormula(
                          fasil: 'https: //forms.gle/BfVXacpGX48emXmX9',
                        )),
              );
            },
            t: 'Write support',
          ),
          ST(
            onTap: () {
              inAppReview.openStoreListing(
                appStoreId: '6476882443',
              );
            },
            t: 'Rate app',
          ),
        ],
      ),
    );
  }
}

class ST extends StatelessWidget {
  const ST({super.key, required this.onTap, required this.t});
  final VoidCallback onTap;
  final String t;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: CTheme.darkGreyColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                t,
                style: const TextStyle(
                  color: CTheme.whiteColor,
                  fontSize: 16,
                ),
              ),
            ),
            SvgPicture.asset('images/circle_arrow.svg'),
          ],
        ),
      ),
    );
  }
}

class ReadTrmsFormula extends StatelessWidget {
  final String fasil;

  const ReadTrmsFormula({Key? key, required this.fasil}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(fasil)),
        ),
      ),
    );
  }
}

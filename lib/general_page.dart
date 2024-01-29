import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:racing/c_theme.dart';
import 'package:racing/pages/home/home_page.dart';
import 'package:racing/pages/news/%20news_page.dart';
import 'package:racing/pages/profile/profile_page.dart';
import 'package:racing/pages/settings/settings_page.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  final List<Widget> _pages = [
    const HomePage(),
    const NewsPage(),
    const ProfilePage(),
    const SettingsPage(),
  ];
  var _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 4),
        height: 90,
        color: CTheme.blackColor,
        child: SafeArea(
          child: Row(
            children: [
              BI(
                p: 'images/home.svg',
                enabled: _index == 0,
                onTap: () => _onT(0),
                title: 'Home',
              ),
              BI(
                p: 'images/globe.svg',
                enabled: _index == 1,
                onTap: () => _onT(1),
                title: 'News',
              ),
              BI(
                p: 'images/person.svg',
                enabled: _index == 2,
                onTap: () => _onT(2),
                title: 'Profile',
              ),
              BI(
                p: 'images/gear.svg',
                enabled: _index == 3,
                onTap: () => _onT(3),
                title: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onT(int i) => setState(() {
        _index = i;
      });
}

class BI extends StatelessWidget {
  const BI({
    super.key,
    required this.p,
    required this.enabled,
    required this.onTap,
    required this.title,
  });

  final String p;
  final bool enabled;
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              p,
              colorFilter: ColorFilter.mode(
                enabled ? Theme.of(context).primaryColor : CTheme.greyColor,
                BlendMode.srcIn,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color:
                    enabled ? Theme.of(context).primaryColor : CTheme.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

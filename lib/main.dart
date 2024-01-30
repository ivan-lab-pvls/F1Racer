import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:racing/c_theme.dart';
import 'package:racing/data/controllers/news_controller.dart';
import 'package:racing/data/controllers/notes_controller.dart';
import 'package:racing/domain/configuration.dart';
import 'package:racing/domain/notifx.dart';
import 'package:racing/general_page.dart';
import 'package:racing/pages/racer/racer_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: AppFirebaseOptions.currentPlatform);

  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 14),
    minimumFetchInterval: const Duration(seconds: 14),
  ));

  await FirebaseRemoteConfig.instance.fetchAndActivate();

  await NotificationsFb().activate();
  final bd = await SharedPreferences.getInstance();

  runApp(MyApp(bd));
}

class MyApp extends StatelessWidget {
  const MyApp(
    this._bd, {
    super.key,
  });

  final SharedPreferences _bd;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsController(_bd),
      child: ChangeNotifierProvider(
        create: (context) => NotesController(_bd),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: CTheme.theme,
          home: const IPage(),
        ),
      ),
    );
  }
}

class IPage extends StatefulWidget {
  const IPage({super.key});

  @override
  State<IPage> createState() => _IPageState();
}

class _IPageState extends State<IPage> {
  String? _racer;
  var _onB = false;
  var _loading = true;
  @override
  void initState() {
    super.initState();
    _f();
  }

  void _f() async {
    final _p = await SharedPreferences.getInstance();
    _star(_p);
    final racer = FirebaseRemoteConfig.instance.getString('racer');
    if (!racer.contains('isRacer')) {
      setState(() {
        _racer = racer;
        _loading = false;
      });
      return;
    }

    final onBoardingDone = _p.getBool('onBoardingDone') ?? false;
    if (!onBoardingDone) {
      setState(() {
        _onB = true;
        _loading = false;
      });
      return;
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_racer != null) {
      return RacerPage(racerId: _racer!);
    }

    if (_onB) {
      return const OnFirstBoarding();
    }

    if (_loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
    }

    return const GeneralPage();
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'images/racer.png',
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}

class OnFirstBoarding extends StatefulWidget {
  const OnFirstBoarding({super.key});

  @override
  State<OnFirstBoarding> createState() => _OnFirstBoardingState();
}

class _OnFirstBoardingState extends State<OnFirstBoarding> {
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          PVCH(
            text:
                'Explore the thrilling world of Formula 1 with our mobile app, designed specifically for true racing enthusiasts like you!',
            onTap: () {
              _controller.nextPage(
                duration: const Duration(milliseconds: 350),
                curve: Curves.ease,
              );
            },
            pa: 'images/image_1.png',
          ),
          PVCH(
            text:
                'Stay updated on the latest track events, enjoy live broadcasts, and immerse yourself in the atmosphere of Formula 1 passion.',
            onTap: () {
              _controller.nextPage(
                duration: const Duration(milliseconds: 350),
                curve: Curves.ease,
              );
            },
            pa: 'images/image_2.png',
          ),
          PVCH(
            text:
                'Stay in the loop with news and key moments in Formula 1. Let the adrenaline and excitement begin – it\'s all in your hands!',
            onTap: () async {
              final b = await SharedPreferences.getInstance();
              await b.setBool('onBoardingDone', true);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => GeneralPage(),
              ));
            },
            pa: 'images/image_3.png',
          ),
        ],
      ),
    );
  }
}

class PVCH extends StatelessWidget {
  const PVCH({
    super.key,
    required this.text,
    required this.onTap,
    required this.pa,
  });
  final String text;
  final VoidCallback onTap;
  final String pa;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(pa),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(flex: 4),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                OrangeButton(
                  text: 'Continue',
                  onTap: onTap,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrangeButton extends StatelessWidget {
  const OrangeButton({super.key, required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xFFca7727),
              Color(0xFFf8992d),
            ],
          ),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

Future<void> _star(SharedPreferences bd) async {
  final rev = InAppReview.instance;
  bool alreadyRated = bd.getBool('isRated') ?? false;
  if (!alreadyRated) {
    if (await rev.isAvailable()) {
      rev.requestReview();
      await bd.setBool('isRated', true);
    }
  }
}

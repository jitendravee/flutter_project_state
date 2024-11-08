import 'package:flutter/material.dart';
import 'package:red_core/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _positionController;

  late Animation<double> _scaleAnimation;

  bool _showText = true;
  bool _hideScreen = false; // This controls the opacity

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    _positionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.4, end: 1)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1, end: 0.4)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_scaleController);

    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(title: 'Redscope Home Page'),
        ),
      );
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showText = false;
      });
      _positionController.forward().whenComplete(() {
        Future.delayed(const Duration(milliseconds: 1800), () {
          setState(() {
            _hideScreen = true;
          });
        });

        _scaleController.forward().whenComplete(() {});
      });
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedOpacity(
        opacity: _hideScreen ? 0 : 1,
        duration: const Duration(milliseconds: 500),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/splash_screen_bg.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            if (_showText)
              const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 2),
                  child: Text(
                    'Redscope',
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Sora-Bold",
                        color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

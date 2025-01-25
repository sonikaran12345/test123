import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logomaker/configuration/splashScreenService.dart';
import 'package:logomaker/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final InitializationService _initializationService = InitializationService();

  @override
  void initState() {
    super.initState();
    _initializationService.analytics.setAnalyticsCollectionEnabled(true);
    _initializationService.checkConnectivityAndProceed();
    // Future.delayed(const Duration(seconds: 3), () {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OnboardingScreen(),));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appbackgroundColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        height: 2208.h,
        width: 1242.w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Splash/bg.png'),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              Image.asset(
                'assets/Splash/icon.png',
                height: 920.h,
                width: 1063.w,
                fit: BoxFit.contain,
              ),
              Image.asset(
                'assets/Splash/sptext.png',
                height: 215.h,
                width: 847.w,
                fit: BoxFit.contain,
              ),
              const Spacer(),
              GradientProgressIndicator(),
              50.verticalSpace,
              110.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}




class RoundedChevron extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const Gradient gradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Colors.white, Colors.white],
      tileMode: TileMode.clamp,
    );

    final Rect colorBounds = Rect.fromLTRB(0, 0, size.width, size.height);
    final Paint paint = Paint()
      ..shader = gradient.createShader(colorBounds);

    Path path = Path();
    path.moveTo(0, 0);

    path.quadraticBezierTo(
      size.width / 12, size.height / 2,
      0, size.height,
    );

    path.lineTo(size.width, size.height);

    path.lineTo(size.width, 0);

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}



class GradientProgressIndicator extends StatefulWidget {
  @override
  _GradientProgressIndicatorState createState() =>
      _GradientProgressIndicatorState();
}

class _GradientProgressIndicatorState extends State<GradientProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: false);
    _animation = Tween<double>(begin: 750.w, end: 0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          children: [
            Container(
              height: 43.h,
              width: 778.w,
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('assets/Splash/fill.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                height: 43.h,
                width: _animation.value,
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}



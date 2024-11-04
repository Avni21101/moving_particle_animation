import 'dart:math';

import 'package:flutter/material.dart';
import 'package:generative_art/painter_canvas.dart';
import 'package:generative_art/particle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<Particle> particleList = [];
  final randomNumber = Random(DateTime.now().microsecondsSinceEpoch);

  late Animation<double> animation;
  late AnimationController animationController;

  double maxRadius = 6;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    animation = Tween<double>(begin: 0, end: 300).animate(animationController)
      ..addListener(() => setState(() {}))
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            animationController.repeat();
          } else if (status == AnimationStatus.dismissed) {
            animationController.forward();
          }
        },
      );
    animationController.forward();
    particleList = List.generate(
      200,
      (_) {
        final particle = Particle(
          color: getRandomColor(randomNumber),
          radius: randomNumber.nextDouble() * 9,
          delta: randomNumber.nextDouble() * 2 * pi,
          position: const Offset(-1, -1),
          speed: randomNumber.nextDouble() * 0.2,
        );
        return particle;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      extendBody: true,
      body: CustomPaint(
        painter: PainterCanvas(
          particleList: particleList,
          randomNumber: randomNumber,
        ),
        child: SizedBox(height: size.height, width: size.width),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

Color getRandomColor(Random rgn) {
  var a = rgn.nextInt(255);
  var r = rgn.nextInt(255);
  var g = rgn.nextInt(255);
  var b = rgn.nextInt(255);
  return Color.fromARGB(a, r, g, b);
}

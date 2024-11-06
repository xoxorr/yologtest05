import 'package:flutter/material.dart';

class IntroAnimation extends StatefulWidget {
  @override
  _IntroAnimationState createState() => _IntroAnimationState();
}

class _IntroAnimationState extends State<IntroAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3), // 애니메이션 지속 시간
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // 부드러운 페이드 애니메이션
    );

    _controller.forward(); // 애니메이션 실행
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png', // 로고 이미지 경로
                width: 150,
                height: 150,
              ),
              SizedBox(height: 20),
              Text(
                'Yolog',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF003366), // 기존의 Yolog 색상
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

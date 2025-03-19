import 'dart:async';
import 'dart:ui';

import 'package:aavaaz_app/modules/record_and_play/view/widget/mic_animation_example.dart';
import 'package:aavaaz_app/modules/record_and_play/view/record_voice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _fadeAnimation2;
  late Animation<double> _text1Animation;
  late Animation<double> _text1MovingUpAnimation;
  late Animation<double> _text2Animation;

  late AnimationController _circleController;
  late Animation<Offset> _circleAnimation;

  late Animation<Offset> _circleAnimation1;
  late Animation<Offset> _circleAnimation2;
  late Animation<Offset> _circleAnimation3;
  late Animation<Offset> _circleAnimation4;

  late AnimationController _formController;
  late Animation<Offset> _emailAnimation;
  late Animation<Offset> _passwordAnimation;
  late Animation<Offset> _buttonAnimation;

  bool showLoginForm = false;

  @override
  void initState() {
    super.initState();
    // Circle Animation Controller
    _circleController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward(); // Start animation automatically

    // Circle Movement Animation
    _circleAnimation = Tween<Offset>(
      begin: Offset(-0.5, 0), // Start bottom-left
      end: Offset(-0.4, -0.1), // Move to top-right
    ).animate(
      CurvedAnimation(parent: _circleController, curve: Curves.easeInOut),
    );

    // Circle at Bottom Right - Moves slightly up
    _circleAnimation1 = Tween<Offset>(
      begin: Offset(0, 0), // Start at normal position
      end: Offset(0, -0.05), // Move slightly up
    ).animate(
        CurvedAnimation(parent: _circleController, curve: Curves.easeInOut));

    // Circle Near Center - Moves slightly left and up
    _circleAnimation2 = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0.05, 0.05),
    ).animate(
        CurvedAnimation(parent: _circleController, curve: Curves.easeInOut));

    // Circle at Top Right - Moves slightly right and down
    _circleAnimation3 = Tween<Offset>(
      begin: Offset(2.5, -3.9), // Just below the top-right edge
      end: Offset(1.9, -4.9),
    ).animate(
        CurvedAnimation(parent: _circleController, curve: Curves.easeInOut));

    // Circle at Top Left - Moves slightly left and down
    _circleAnimation4 = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(-0.05, 0.05),
    ).animate(
        CurvedAnimation(parent: _circleController, curve: Curves.easeInOut));

    // Animation Controller
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Fade Animation for Texts
    _fadeAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Fade Animation for Text 2 (Start Hidden)
    _fadeAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.8, 1.0, curve: Curves.easeIn), // Delay Text 2 fade
      ),
    );
    // Text 1 Movement Animation (Bottom to Center)
    _text1Animation = Tween<double>(
            begin:
                // showLoginForm ? 200 :
                10,
            end:
                // showLoginForm ? 50 :
                250)
        .animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Move Text 1 (AAVAAZ) to Top Center
    _text1MovingUpAnimation = Tween<double>(begin: 200, end: 50).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Text 2 Movement Animation (Bottom to Center)
    _text2Animation = Tween<double>(begin: 10, end: 200).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.8, 1.0,
            curve: Curves.easeInOut), // Delay Text 2 movement
      ),
    );

    _controller.forward().whenComplete(() {
      setState(() {
        showLoginForm = true;
      });
      _formController.forward();
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => NextScreen()));
    });

    // Animation Controller for Login Form
    _formController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _emailAnimation =
        Tween<Offset>(begin: Offset(0, 1.5), end: Offset(0, 0)).animate(
      CurvedAnimation(
          parent: _formController,
          curve: Interval(0.2, 0.6, curve: Curves.easeOut)),
    );

    _passwordAnimation =
        Tween<Offset>(begin: Offset(0, 1.9), end: Offset(0, 0)).animate(
      CurvedAnimation(
          parent: _formController,
          curve: Interval(0.4, 0.8, curve: Curves.easeOut)),
    );

    _buttonAnimation =
        Tween<Offset>(begin: Offset(0, 2.5), end: Offset(0, 0)).animate(
      CurvedAnimation(
          parent: _formController,
          curve: Interval(0.6, 1.0, curve: Curves.easeOut)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _circleController.dispose();
    _formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Moving Circle 1
          AnimatedBuilder(
            animation: _circleController,
            builder: (context, child) {
              return FractionalTranslation(
                translation: _circleAnimation.value, // Move the circle
                child: child,
              );
            },
            child: SizedBox(
              height: 150,
              width: 150,
              child: CircleAvatar(
                backgroundColor: Color(0xff4C73C7).withOpacity(0.2),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 9,
                      sigmaY: 9,
                      tileMode: TileMode.mirror), // Blur effect
                  child: Container(
                    color: Colors.transparent, // Required for BackdropFilter
                  ),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _circleController,
            builder: (context, child) {
              return FractionalTranslation(
                translation: _circleAnimation3.value, // Move the circle
                child: child,
              );
            },
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircleAvatar(
                backgroundColor: Color(0xff4C73C7).withOpacity(0.3),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 8,
                      sigmaY: 8,
                      tileMode: TileMode.mirror), // Blur effect
                  child: Container(
                    color: Colors.transparent, // Required for BackdropFilter
                  ),
                ),
              ),
            ),
          ),
          if (!showLoginForm)
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 150,
                height: 150,
                child: Image.asset(
                  "assets/logo.gif",
                ),
              ),
            ),
          if (!showLoginForm)
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  bottom: _text1Animation.value,
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Text(
                      "AAVAAZ",
                      style: TextStyle(
                        letterSpacing: 3,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),

          // Animated Text 2
          if (!showLoginForm)
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  bottom: _text2Animation.value,
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Text(
                      "Experience the Future",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                );
              },
            ),
          // Login Form Appears After Animation
          if (showLoginForm)
            Align(
              alignment: Alignment.center,
              // child:
              // Positioned(
              //     bottom: 100,
              //     left: 30,
              //     right: 30,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: MediaQuery.sizeOf(context).height * 0.1),
                child: Column(
                  spacing: 5,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.sizeOf(context).height * 0.2),
                      child: SizedBox(
                        width: 70,
                        height: 70,
                        child: Image.asset(
                          "assets/logo.gif",
                        ),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _fadeAnimation.value,
                          child: Text(
                            "AAVAAZ",
                            style: TextStyle(
                              letterSpacing: 3,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                    Spacer(),
                    textfieldHeaderWidget(
                        "Email", AlignmentDirectional.topStart),
                    emailTextfield(),
                    SizedBox(height: 15),
                    textfieldHeaderWidget(
                        "Password", AlignmentDirectional.topStart),
                    passwordTextfield(),
                    textfieldHeaderWidget(
                        "Forgot Passowrd?", AlignmentDirectional.bottomEnd),
                    SizedBox(height: 20),
                    loginbutton(),
                    signupwidget(),
                  ],
                ),
              ),
              //),
            ),
        ],
      ),
    );
  }

  SlideTransition emailTextfield() {
    return SlideTransition(
      position: _emailAnimation,
      child: TextField(
        decoration: InputDecoration(
          hintText: "Test@gmail.com",
          hintStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.white24,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  SlideTransition passwordTextfield() {
    return SlideTransition(
      position: _passwordAnimation,
      child: TextField(
        decoration: InputDecoration(
          hintText: "******************",
          hintStyle: TextStyle(color: Colors.white),
          suffixIcon: Icon(
            Icons.visibility_outlined,
            color: Colors.white,
          ),
          filled: true,
          fillColor: Colors.white24,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        style: TextStyle(color: Colors.white),
        obscureText: true,
      ),
    );
  }

  SlideTransition loginbutton() {
    return SlideTransition(
      position: _buttonAnimation,
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => RecordVoiceView()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xffA9D0F5),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10), // Adjust the radius as needed
            ),
          ),
          child: Text(
            "Log In",
            style: GoogleFonts.ibmPlexSans(
                fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget signupwidget() {
    return SlideTransition(
      position: _buttonAnimation,
      child: RichText(
        text: TextSpan(
          text: "Don’t have an account? ",
          style: GoogleFonts.inter(
            color: Color(0xff8499A8),
            fontSize: 16,
          ),
          children: [
            TextSpan(
              text: "Sign up",
              style: GoogleFonts.ibmPlexSans(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textfieldHeaderWidget(String title, AlignmentGeometry alignment) {
    return Align(
      alignment: alignment,
      child: SlideTransition(
        position: _emailAnimation,
        child: Text(
          title,
          style: TextStyle(
            color: Color(0xffA9D0F5),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildCircle() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xff4C73C7), // 40% shade
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Blur effect
        child: Container(
          color: Colors.transparent, // Required for BackdropFilter
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Home Screen"),
      ),
    );
  }
}

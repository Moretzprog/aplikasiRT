import 'package:flutter/material.dart';
import '/main_navigation.dart';
import 'dart:ui';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Data tiap halaman onboarding
  final List<Map<String, dynamic>> onboardingData = [
    {
      "title": "Selamat Datang",
      "desc": "Mari berkolaborasi menjaga\nrumah tangga aman dan nyaman.",
      "image": "assets/images/people3.png",
      "width": 300.0,
      "height": 300.0,
    },
    {
      "title": "Lapor Cepat",
      "desc":
          "Laporkan kejadian atau gangguan\nlangsung dari HP Anda kapan saja.",
      "image": "assets/images/women.png",
      "width": 300.0,
      "height": 300.0,
    },
    {
      "title": "Komunitas Aman",
      "desc":
          "Bersama warga kita menciptakan lingkungan\nyang lebih aman dan nyaman.",
      "image": "assets/images/people2.png",
      "width": 500.0,
      "height": 300.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(1.0, -1.0), // pojok kanan atas
            radius: 2.0,
            colors: [
              Color(0xFFE9E4F0),
              Color.fromARGB(255, 216, 208, 235),
              Color.fromARGB(255, 232, 222, 241),
            ],
            stops: [0.0, 0.4, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: onboardingData.length,
                  itemBuilder: (context, index) {
                    bool isActive = index == _currentPage;
                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: isActive ? 1.0 : 0.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 90.0),
                          Text(
                            onboardingData[index]["title"]!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            onboardingData[index]["desc"]!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          const SizedBox(height: 70.0),
                          Image.asset(
                            onboardingData[index]["image"]!,
                            width: onboardingData[index]["width"],
                            height: onboardingData[index]["height"],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Indikator bulat
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingData.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: _currentPage == index ? 16.0 : 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.white
                          : Colors.white54,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50.0),

              // Tombol
              // Tombol dengan glassmorphism effect
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_currentPage == onboardingData.length - 1) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const MainNavigation(),
                              ),
                            );
                          } else {
                            // Geser ke halaman berikutnya
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOutCubic,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.black87,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          minimumSize: const Size(double.infinity, 50.0),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                        ),
                        child: Text(
                          _currentPage == onboardingData.length - 1
                              ? "Get Started"
                              : "Next",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 60.0),
            ],
          ),
        ),
      ),
    );
  }
}

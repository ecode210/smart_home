import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/view/dashboard.dart';
import 'package:smart_home/view/settings.dart';
import 'package:smart_home/viewmodel/smart_home.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);
  User? user = FirebaseAuth.instance.currentUser!;
  stt.SpeechToText speech = stt.SpeechToText();
  bool isListening = false;
  String lastWords = '';

  void _initSpeech() async {
    isListening = await speech.initialize();
    setState(() {});
  }

  void _startListening() async {
    await speech.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            Dashboard(user),
            Container(
              height: size.height,
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Alexa Voice Center",
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        color: Colors.cyan,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      width: size.width,
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.cyan.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Tap Alexa to start listening...',
                              style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                  color: Colors.grey.shade900,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.cyan.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              lastWords,
                              style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                  color: Colors.grey.shade900,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Settings(user),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: Provider.of<SmartHome>(context).selectedTab,
          onTap: (int index) {
            setState(() {
              Provider.of<SmartHome>(context, listen: false).selectedTab = index;
            });
          },
          backgroundColor: Colors.white,
          elevation: 0,
          iconSize: 30,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          enableFeedback: true,
          items: [
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                  setState(() {
                    Provider.of<SmartHome>(context, listen: false).voice = false;
                  });
                },
                child: const Icon(
                  Icons.home_filled,
                  color: Colors.cyan,
                ),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    2,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                  setState(() {
                    Provider.of<SmartHome>(context, listen: false).voice = false;
                  });
                },
                child: const Icon(
                  Icons.settings,
                  color: Colors.cyan,
                ),
              ),
              label: "Settings",
            ),
          ],
        ),
        floatingActionButton: SizedBox(
          height: size.width * 0.17,
          width: size.width * 0.17,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {
                _pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
                setState(() {
                  Provider.of<SmartHome>(context, listen: false).voice =
                      !Provider.of<SmartHome>(context, listen: false).voice;
                  if (Provider.of<SmartHome>(context, listen: false).voice) {
                    _startListening();
                  }
                });
              },
              elevation: 0,
              backgroundColor: Colors.cyan,
              child: Provider.of<SmartHome>(context).voice
                  ? Lottie.asset(
                      "assets/lottie/voice.json",
                      fit: BoxFit.contain,
                      repeat: true,
                    )
                  : const FaIcon(
                      FontAwesomeIcons.amazon,
                      color: Colors.white,
                      size: 30,
                    ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

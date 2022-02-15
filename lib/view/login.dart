import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/view/home.dart';
import 'package:smart_home/viewmodel/smart_home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey _sliderKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.6,
              child: CarouselSlider.builder(
                key: _sliderKey,
                initialPage: 0,
                slideIndicator: CircularSlideIndicator(
                  alignment: Alignment.center,
                  currentIndicatorColor: Colors.cyan,
                  indicatorBackgroundColor: Colors.grey.shade300,
                  padding: const EdgeInsets.fromLTRB(0, 350, 0, 0),
                ),
                slideBuilder: (index) {
                  final sliderImage =
                      Provider.of<SmartHome>(context, listen: false)
                          .sliderImages[index];
                  return sliderImage;
                },
                slideTransform: const DefaultTransform(),
                itemCount: 3,
              ),
            ),
            const SizedBox(height: 10),
            const FaIcon(
              FontAwesomeIcons.solidLightbulb,
              color: Colors.cyan,
              size: 35,
            ),
            const SizedBox(height: 10),
            Text(
              "Smart Home",
              style: GoogleFonts.quicksand(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              """
Control all of your device
safely and easily""",
              textAlign: TextAlign.center,
              style: GoogleFonts.quicksand(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Colors.cyan,
              thickness: 2,
              indent: 30,
              endIndent: 30,
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                Provider.of<SmartHome>(context, listen: false)
                    .googleLogin()
                    .then((credentials) {
                  if (credentials.user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Home(),
                      ),
                    );
                  }
                });
              },
              child: Container(
                height: 50,
                width: size.width * 0.6,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Sign in with Google",
                      style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

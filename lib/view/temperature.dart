import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:smart_home/view/rooms.dart';
import 'package:smart_home/viewmodel/smart_home.dart';

class Temperature extends StatefulWidget {
  const Temperature({Key? key}) : super(key: key);

  @override
  _TemperatureState createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: PreferredSize(
        preferredSize: Size(size.width, 90),
        child: Container(
          width: size.width,
          height: 90,
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.cyan,
                  size: 30,
                ),
              ),
              Text(
                "Temperature",
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.drag_indicator_rounded,
                  color: Colors.cyan,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 50,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Smart AC",
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          color: Colors.grey.shade900,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                    CupertinoSwitch(
                      onChanged: (bool newValue) {
                        setState(() {
                          Provider.of<SmartHome>(context, listen: false)
                              .smartAC = newValue;
                        });
                      },
                      value: Provider.of<SmartHome>(context).smartAC,
                      activeColor: Colors.cyan,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: size.height * 0.35,
                width: size.width * 0.65,
                child: SleekCircularSlider(
                  min: 16,
                  max: 36,
                  initialValue: Provider.of<SmartHome>(context).temperature,
                  appearance: CircularSliderAppearance(
                    size: 200,
                    animationEnabled: true,
                    customWidths: CustomSliderWidths(
                      trackWidth: 80,
                      progressBarWidth: 30,
                      handlerSize: 30,
                      shadowWidth: 0,
                    ),
                    customColors: CustomSliderColors(
                      trackColor: Colors.cyan.shade100,
                      progressBarColor: Colors.cyan,
                      hideShadow: true,
                    ),
                  ),
                  innerWidget: (value) {
                    return Container(
                      height: size.height * 0.4,
                      width: size.width * 0.7,
                      alignment: Alignment.center,
                      child: Text(
                        "${value.toInt()}℃",
                        style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: 45,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    );
                  },
                  onChange: (value) {
                    setState(() {
                      Provider.of<SmartHome>(context, listen: false)
                          .temperature = value;
                    });
                  },
                  onChangeStart: (startValue) {},
                  onChangeEnd: (endValue) {},
                ),
              ),
              SizedBox(
                width: size.width,
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (Provider.of<SmartHome>(context, listen: false)
                                  .temperature >
                              16) {
                            Provider.of<SmartHome>(context, listen: false)
                                .temperature--;
                          }
                        });
                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.remove_rounded,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (Provider.of<SmartHome>(context, listen: false)
                                  .temperature <
                              36) {
                            Provider.of<SmartHome>(context, listen: false)
                                .temperature++;
                          }
                        });
                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SizedBox(
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Other Devices",
                        style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Row(
                          children: const [
                            Expanded(
                              child: Rooms(
                                index: 0,
                                deviceName: "Smart TV",
                                deviceBrand: "Samsung",
                                iconData: FontAwesomeIcons.tv,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Rooms(
                                index: 1,
                                deviceName: "Air Conditioner",
                                deviceBrand: "Samsung",
                                iconData: FontAwesomeIcons.snowflake,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

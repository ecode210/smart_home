import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/view/rooms.dart';
import 'package:smart_home/view/temperature.dart';
import 'package:smart_home/viewmodel/smart_home.dart';
import 'package:websafe_svg/websafe_svg.dart';

class Dashboard extends StatefulWidget {
  final user;

  const Dashboard(this.user, {Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        children: [
          Container(
            width: size.width,
            height: 70,
            margin: EdgeInsets.fromLTRB(0, size.height * 0.05, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hello Olawole",
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          color: Colors.grey.shade900,
                          fontSize: 23,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                    Text(
                      "Save your electricity usage",
                      style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: Colors.cyan,
                  radius: 25,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: size.width,
            height: 120,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Energy Usage Today",
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          color: Colors.grey.shade900,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                    Text(
                      "29.1 kWh",
                      style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Room Temperature",
                          style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                                color: Colors.grey.shade900,
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -1),
                          ),
                        ),
                        Text(
                          "${Provider.of<SmartHome>(context).temperature.toInt()}℃",
                          style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                              color: Colors.grey.shade900,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Temperature()),
                        );
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Check",
                          style: GoogleFonts.quicksand(
                              textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          )),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: size.width,
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: WebsafeSvg.asset(
                    "assets/svg/clouds.svg",
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Cloudy",
                      style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                    Text(
                      "Abuja, Nigeria",
                      style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          // letterSpacing: -1,
                        ),
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Text(
                  "27.5℃",
                  style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  )),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: TabBar(
              controller: _tabController,
              unselectedLabelColor: Colors.cyan,
              isScrollable: true,
              physics: const BouncingScrollPhysics(),
              labelStyle: GoogleFonts.quicksand(
                textStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              labelPadding: const EdgeInsets.symmetric(horizontal: 20),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.cyan,
              ),
              tabs: [
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("Living Room"),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("Dining Room"),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("Bedroom"),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("Kitchen"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: size.width,
            height: 400,
            child: TabBarView(
              controller: _tabController,
              children: [
                SizedBox(
                  width: size.width,
                  height: 500,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: const [
                            Expanded(
                              child: Rooms(
                                index: 0,
                                deviceName: "Smart TV",
                                deviceBrand: "Samsung",
                                iconData: FontAwesomeIcons.tv,
                              ),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: Rooms(
                                index: 1,
                                deviceName: "Air Conditioner",
                                deviceBrand: "Samsung",
                                iconData: FontAwesomeIcons.snowflake,
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          children: const [
                            SizedBox(height: 20),
                            Expanded(
                              child: Rooms(
                                index: 2,
                                deviceName: "Lights",
                                deviceBrand: "Philips",
                                iconData: FontAwesomeIcons.lightbulb,
                              ),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: Rooms(
                                index: 3,
                                deviceName: "Internet",
                                deviceBrand: "Airtel",
                                iconData: FontAwesomeIcons.internetExplorer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: 500,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: const [
                            Expanded(
                              child: Rooms(
                                index: 4,
                                deviceName: "Smart TV",
                                deviceBrand: "Samsung",
                                iconData: FontAwesomeIcons.tv,
                              ),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: Rooms(
                                index: 5,
                                deviceName: "Air Conditioner",
                                deviceBrand: "Samsung",
                                iconData: FontAwesomeIcons.snowflake,
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          children: const [
                            SizedBox(height: 20),
                            Expanded(
                              child: Rooms(
                                index: 6,
                                deviceName: "Lights",
                                deviceBrand: "Philips",
                                iconData: FontAwesomeIcons.lightbulb,
                              ),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: Rooms(
                                index: 7,
                                deviceName: "Internet",
                                deviceBrand: "Airtel",
                                iconData: FontAwesomeIcons.internetExplorer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: 500,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: const [
                            Expanded(
                              child: Rooms(
                                index: 8,
                                deviceName: "Smart TV",
                                deviceBrand: "Samsung",
                                iconData: FontAwesomeIcons.tv,
                              ),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: Rooms(
                                index: 9,
                                deviceName: "Air Conditioner",
                                deviceBrand: "Samsung",
                                iconData: FontAwesomeIcons.snowflake,
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          children: const [
                            SizedBox(height: 20),
                            Expanded(
                              child: Rooms(
                                index: 10,
                                deviceName: "Lights",
                                deviceBrand: "Philips",
                                iconData: FontAwesomeIcons.lightbulb,
                              ),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: Rooms(
                                index: 11,
                                deviceName: "Internet",
                                deviceBrand: "Airtel",
                                iconData: FontAwesomeIcons.internetExplorer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: 500,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: const [
                            Expanded(
                              child: Rooms(
                                index: 12,
                                deviceName: "Oven",
                                deviceBrand: "Master Chef",
                                iconData: FontAwesomeIcons.gripfire,
                              ),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: Rooms(
                                index: 13,
                                deviceName: "Smart Fridge",
                                deviceBrand: "Air Thermocool",
                                iconData: FontAwesomeIcons.snowflake,
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          children: const [
                            SizedBox(height: 20),
                            Expanded(
                              child: Rooms(
                                index: 14,
                                deviceName: "Lights",
                                deviceBrand: "Philips",
                                iconData: FontAwesomeIcons.lightbulb,
                              ),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: Rooms(
                                index: 15,
                                deviceName: "Microwave",
                                deviceBrand: "Master Chef",
                                iconData: FontAwesomeIcons.waveSquare,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

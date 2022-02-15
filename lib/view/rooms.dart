import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/viewmodel/smart_home.dart';

class Rooms extends StatefulWidget {
  final String deviceName;
  final String deviceBrand;
  final IconData iconData;
  final int index;

  const Rooms({Key? key, required this.deviceName, required this.deviceBrand, required this.iconData, required this.index}) : super(key: key);

  @override
  _RoomsState createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: size.width * 0.15,
            width: size.width * 0.15,
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: FaIcon(
              widget.iconData,
              color: Colors.white,
              size: 25,
            ),
          ),
          Text(
            widget.deviceName,
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
            widget.deviceBrand,
            style: GoogleFonts.quicksand(
              textStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: -1,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Provider.of<SmartHome>(context).switches[widget.index] == true ? "On" : "Off",
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                    color: Provider.of<SmartHome>(context).switches[widget.index] == true
                        ? Colors.cyan
                        : Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                  ),
                ),
              ),
              CupertinoSwitch(
                onChanged: (bool newValue) {
                  setState(() {
                    Provider.of<SmartHome>(context, listen: false).switches[widget.index] = newValue;
                  });
                },
                value: Provider.of<SmartHome>(context).switches[widget.index],
                activeColor: Colors.cyan,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

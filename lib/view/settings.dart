import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/view/login.dart';
import 'package:smart_home/viewmodel/smart_home.dart';

class Settings extends StatelessWidget {
  final user;

  const Settings(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.cyan,
            radius: 100,
            child: Container(
              height: 200,
              width: 200,
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  user.photoURL!,
                ),
                radius: 95,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            user.displayName!.toString(),
            style: GoogleFonts.quicksand(
              textStyle: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Text(
            user.email!.toString(),
            style: GoogleFonts.quicksand(
              textStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              Provider.of<SmartHome>(context, listen: false).logout();
              Timer(const Duration(seconds: 1), (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              });
            },
            child: Container(
              height: 50,
              width: size.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.power_settings_new_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Logout",
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: non_constant_identifier_names, unnecessary_const, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData DarkThem = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: Colors.pink,
      prefixStyle: const TextStyle(color: Colors.pink),
      hintStyle: TextStyle(color: HexColor('#9E18A7')),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: HexColor('#9E18A7'),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: HexColor('#9E18A7'),
        ),
      )),
  primarySwatch: Colors.pink,
  scaffoldBackgroundColor: HexColor('#1A031B'),
  appBarTheme: AppBarTheme(
    actionsIconTheme: IconThemeData(color: HexColor('#9E18A7'), size: 30.0),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('#1A031B'),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('#1A031B'),
    elevation: 0.0,
    titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30.0,
        color: HexColor('#9E18A7')),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.orange,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: HexColor('#F7F7F7'),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: HexColor('000000'),
      backgroundColor: HexColor('#1A031B'),
      elevation: 40.0),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
        color: HexColor('#0A0404'),
        fontSize: 40.0,
        fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(
        color: HexColor('0A0404'), fontSize: 20.0, fontWeight: FontWeight.w600),
  ),
);
ThemeData LightThem = ThemeData(
  primarySwatch: Colors.orange,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    actionsIconTheme: IconThemeData(color: Colors.black, size: 30.0),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.orange,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.orange,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: HexColor('000000'),
      unselectedItemColor: HexColor('#F2EBCC'),
      backgroundColor: Colors.white,
      elevation: 40.0),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
        color: HexColor('#0A0404'),
        fontSize: 40.0,
        fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(
        color: HexColor('0A0404'), fontSize: 20.0, fontWeight: FontWeight.w600),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    prefixIconColor: Colors.amber,
  ),
);

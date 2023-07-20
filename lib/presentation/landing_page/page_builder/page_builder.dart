import 'package:flutter/material.dart';
import '../components/app_bar.dart';

Scaffold buildPage(
    {required bool isLargeScreen,
    required List<Widget> widgets,
    scaffoldKey,
    context}) {
  List<Widget> columnChilren = [];
  columnChilren.addAll(widgets);
  return Scaffold(
    key: scaffoldKey,
    drawer: isLargeScreen ? null : drawer(scaffoldKey),
    body: Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: (columnChilren),
          ),
        ),
        landingPageAppBar(isLargeScreen, scaffoldKey, context)
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        //TODO: impliment chat system
      },
      child: Icon(
        Icons.phone,
        color: Colors.green.shade900,
      ),
      splashColor: Colors.green.shade500,
      backgroundColor: Colors.green.shade300,
    ),
  );
}

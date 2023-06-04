import 'package:flutter/material.dart';

import '../config/theme.dart';

class StatisticsCard {
  final String? img, title, capacity;
  final int? amount;
  final double? percentage;
  final Color? color;
  final Function()? onTap;

  StatisticsCard({
    this.onTap,
    this.img,
    this.title,
    this.capacity,
    this.amount,
    this.percentage,
    this.color,
  });
}

List<StatisticsCard> demoStat = [
  StatisticsCard(
      title: "Attendees",
      amount: 200,
      img: "assets/icons/Documents.svg",
      capacity: "",
      color: primaryColor,
      percentage: 35,
      onTap: () {}),
  StatisticsCard(
    title: "Non-Admin Staffs",
    amount: 1328,
    img: "assets/icons/google_drive.svg",
    capacity: "",
    color: const Color(0xFFFFA113),
    percentage: 35,
  ),
  StatisticsCard(
    title: "Admins Staffs",
    amount: 1328,
    img: "assets/icons/one_drive.svg",
    capacity: "",
    color: const Color(0xFFA4CDFF),
    percentage: 10,
  ),
  StatisticsCard(
    title: "Campers",
    amount: 5328,
    img: "assets/icons/drop_box.svg",
    capacity: "",
    color: const Color(0xFF007EE5),
    percentage: 78,
  ),
  StatisticsCard(
    title: "Disability Cluster",
    amount: 1328,
    img: "assets/icons/google_drive.svg",
    capacity: "",
    color: const Color(0xFFFFA113),
    percentage: 35,
  ),
];

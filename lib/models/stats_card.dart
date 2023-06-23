import 'package:flutter/material.dart';


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

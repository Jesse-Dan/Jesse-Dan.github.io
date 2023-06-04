import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

extension ContainerExtension on Container {
  Widget shimmer({
    required Color baseColor,
    required Color highlightColor,
  }) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: this,
    );
  }
}

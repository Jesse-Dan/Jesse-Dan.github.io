
// Extension on the Container widget
import 'package:flutter/material.dart';

extension GlassMorphism on BoxDecoration {
  BoxDecoration glassMorphism() {
    return BoxDecoration(
      borderRadius: this.borderRadius,
      color: this.color?.withOpacity(0.2) ?? Colors.transparent,
      boxShadow: [
        BoxShadow(
          color: this.color?.withOpacity(0.3) ?? Colors.transparent,
          blurRadius: 8,
          spreadRadius: 2,
        ),
      ],
    );
  }
}



import 'package:flutter/material.dart';

import '../../../../../../config/theme.dart';
import 'data_list_tile.dart';

class ProfileBottom extends StatelessWidget {
  const ProfileBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        // height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.7),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              headerText(text: 'About developer'),
              contentText(text: 'Jesse Dan Amuda', title: 'Story'),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../config/overlay_config/overlay_service.dart';
import '../../../config/theme.dart';
import '../../../models/user_model.dart';

class AdminUserImage extends StatelessWidget {
  const AdminUserImage({
    super.key,
    this.registerdAdmin,
  });
  final AdminModel? registerdAdmin;

  @override
  Widget build(BuildContext context) {
    return registerdAdmin != null
        ? registerdAdmin!.imageUrl == ''
            ? const Icon(Icons.person, color: primaryColor)
            : InkWell(
                onTap: () {
                  OverlayService.show(
                      child: Material(
                    color: Colors.transparent,
                    child: SizedBox.fromSize(
                      size: Size(400, 400),
                      child: Stack(
                        children: [
                          Image.network(registerdAdmin!.imageUrl, scale: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                                onPressed: () {
                                  OverlayService.closeAlert();
                                },
                                icon: Icon(
                                  Icons.clear_rounded,
                                  size: 30,
                                  color: kSecondaryColor,
                                )),
                          )
                        ],
                      ),
                    ),
                  ));
                },
                child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(registerdAdmin!.imageUrl, scale: 10)),
              )
        : const Icon(Icons.person, color: primaryColor);
  }
}

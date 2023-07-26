import 'package:flutter/material.dart';

class PopupMenu extends StatelessWidget {
  final List<PopupMenuItemModel> items;
  final Widget icon;

  const PopupMenu({Key? key, required this.items, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopupMenuItemModel>(
      icon: icon,
      padding: const EdgeInsets.only(left: 0, right: 120),
      onSelected: (PopupMenuItemModel selectedItem) {
        selectedItem.onTap(); // Invoke the selected item's callback
      },
      itemBuilder: (BuildContext context) {
        return items.map((PopupMenuItemModel item) {
          return PopupMenuItem<PopupMenuItemModel>(
            value: item,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the popup menu
                item.onTap(); // Invoke the selected item's callback
              },
              child: Text(item.title),
            ),
          );
        }).toList();
      },
    );
  }
}

class PopupMenuItemModel {
  final String title;
  final Function() onTap;

  PopupMenuItemModel({required this.title, required this.onTap});
}

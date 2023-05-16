import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:HaniNotes/Models/WidgetModels/CustomMenuItem.dart';

class Menu{
  static DropdownButton2 generate(BuildContext context, Icon icon,List<CustomMenuItem> menuItems){
    return DropdownButton2(
              icon: icon,
              items: [
                ...menuItems.map(
                      (item) =>
                      DropdownMenuItem<CustomMenuItem>(
                        value: item,
                        child: Menu.buildItem(item),
                      ),
                ),
              ],
              onChanged: (customMenuItem) {
                customMenuItem.onTap();
              },
              itemHeight: 48,
              itemPadding: const EdgeInsets.only(left: 16, right: 16),
              dropdownWidth: 130,
              dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color.fromARGB(255, 32, 145, 238),
              ),
              dropdownElevation: 8,
              offset: const Offset(0, -4),
            );
  }

  static Widget buildItem(CustomMenuItem item) {
    return Row(
      children: [
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Icon(
            item.icon,
            color: Colors.white,
            size: 22
        ),
      ],
    );
  }
}



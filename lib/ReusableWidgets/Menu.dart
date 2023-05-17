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
                        child: Menu.buildItem(item,context),
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
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              dropdownElevation: 8,
              offset: const Offset(0, -4),
            );
  }

  static Widget buildItem(CustomMenuItem item,BuildContext context) {
    return Row(
      children: [
        Text(
          item.text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Icon(
            item.icon,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            size: 22
        ),
      ],
    );
  }
}



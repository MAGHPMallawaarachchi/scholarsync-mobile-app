import 'package:flutter/material.dart';
// this widget dont have any changes....
class MenuItems extends StatelessWidget {
  const MenuItems({super.key, required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: 30,
          ),
          const SizedBox(width: 20,),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 18,
              color: Colors.black
            ),
          )
        ],
      ),
    );
  }
}
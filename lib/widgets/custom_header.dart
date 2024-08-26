import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.cyan,
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text('con que doc?'),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
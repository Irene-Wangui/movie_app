import 'package:flutter/material.dart';

class ProfileItem {
  final IconData icon;
  final String title;
  final Function() onPressed;

  ProfileItem(this.icon, this.title, this.onPressed);
}

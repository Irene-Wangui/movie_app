import 'package:flutter/material.dart';
import 'package:smokeless_movies/widgets/profilewidget/profile_item.dart';

class ProfileListTile extends StatelessWidget {
  final ProfileItem item;
  const ProfileListTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(item.icon),
      title: Text(item.title),
      onTap: item.onPressed,
    );
  }
}

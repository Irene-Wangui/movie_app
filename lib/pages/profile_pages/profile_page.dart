import 'package:flutter/material.dart';
import 'package:smokeless_movies/pages/profile_pages/my_account_page.dart';

class Myprofile extends StatelessWidget {
  const Myprofile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Profile"),
        ),
        body: ListView(
          children: [
            ListTile(title: Text(" My movies"), leading: Icon(Icons.movie), onTap: () {}),
            ListTile(
              title: Text("My Tvshows"),
              leading: Icon(Icons.tv),
              onTap: () {},
            ),
            ListTile(
              title: Text("My Account"),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyAccountPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text("Settings"),
              leading: Icon(Icons.settings),
              onTap: () {},
            ),
          ],
        ));
  }
}

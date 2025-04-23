import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smokeless_movies/pages/my_tv_shows_page.dart';
import 'package:smokeless_movies/pages/profile_pages/my_account_page.dart';
import 'package:smokeless_movies/pages/profile_pages/my_movies_page.dart';
import 'package:smokeless_movies/pages/series_details_page.dart';

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
            ListTile(
              title: Text(" My movies"),
              leading: Icon(Icons.movie),
              onTap: () {
                log('clicked on my movies');
                Get.to(() => MyMoviesPage());
              },
            ),
            ListTile(
              title: Text("My Tvshows"),
              leading: Icon(Icons.tv),
              onTap: () {
                log('clicked on my movies');
                Get.to(() => MyTvshowsPage());
              },
            ),
            ListTile(
              title: Text("My Account"),
              leading: Icon(Icons.person),
              onTap: () {
                Get.to(() => MyAccountPage());
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

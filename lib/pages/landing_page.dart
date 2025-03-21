import 'package:flutter/material.dart';
import 'package:smokeless_movies/pages/homepage.dart';
import 'package:smokeless_movies/pages/movie_list_page.dart';
import 'package:smokeless_movies/pages/profile_pages/profile_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int currentpage = 0;

  List<Widget> pages = [
    HomePage(),
    MovieListPage(),
    Center(child: Text("TV Shows")),
    Myprofile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        child: NavigationBar(
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: Icon(Icons.movie), label: "Movies"),
            NavigationDestination(icon: Icon(Icons.tv), label: "TV Shows"),
            NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
          ],
          selectedIndex: currentpage,
          onDestinationSelected: (value) {
            setState(() {
              currentpage = value;
            });
          },
        ),
      ),
      body: pages[currentpage],
    );
  }
}

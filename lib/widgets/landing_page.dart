import 'package:flutter/material.dart';
import 'package:smokeless_movies/pages/homepage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int currentpage = 0;
  List<Widget> pages = [
    HomePage(),
    Center(child: Text("Movies")),
    Center(child: Text("Tvshows")),
    /* Scaffold(
      appBar:AppBar(title: Text("My profile"),
    ),
    body: ListView(
      children: [
        Text("my movies",)
      ],
    ),
    ); */
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        //borderRadius: BorderRadius.all(20))
        child: NavigationBar(
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: Icon(Icons.movie), label: "Movies"),
            NavigationDestination(icon: Icon(Icons.tv), label: "Tvshows"),
            NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
          ],
          selectedIndex: currentpage,
          onDestinationSelected: (value) {
            setState(
              () {
                currentpage = value;
              },
            );
          },
        ),
      ),
      body: pages[currentpage],
    );
  }
}

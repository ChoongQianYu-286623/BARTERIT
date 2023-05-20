import 'package:barterlt/models/user.dart';
import 'package:barterlt/screens/buyertabscreen.dart';
import 'package:barterlt/screens/loginscreen.dart';
import 'package:barterlt/screens/profiletabscreen.dart';
import 'package:barterlt/screens/sellertabscreen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required User user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<Widget> tabchildren;
  int _currentIndex = 0;
  String maintitle = "Buyer";

  @override
  void initState(){
    super.initState();
    print("Buyer");
    tabchildren = const [
      BuyerTabScreen(),
      SellerTabScreen(),
      ProfileTabScreen()
    ];
  }

  @override
  void dispose(){
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Row(
        children: <Widget> [
          Text(maintitle),
          const SizedBox(
            width: 120,
          ),
          IconButton(
            onPressed: _onlogout, 
            icon: const Icon(Icons.login_outlined),
            color: Colors.black ,)
        ],
      )),
      body: tabchildren[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.attach_money,
              ),
              label: "Buyer"),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.store_mall_directory,
              ),
              label: "Seller"),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              ),
              label: "Profile"),
        ]),
    );
  }

  void onTabTapped(int value) {
    setState(() {
      _currentIndex = value;
      if(_currentIndex == 0) {
        maintitle = "Buyer";
      }
      if(_currentIndex == 1) {
        maintitle = "Seller";
      }
      if(_currentIndex == 2) {
        maintitle = "Profile";
      }
    });
  }

  void _onlogout() {
    Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (content)=> const LoginScreen()));
  }
}
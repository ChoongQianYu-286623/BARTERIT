import 'package:barterlt/models/user.dart';
import 'package:barterlt/buyer/buyertabscreen.dart';
import 'package:barterlt/shared/profiletabscreen.dart';
import 'package:barterlt/seller/sellertabscreen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({super.key, required this.user});

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
    print(widget.user.name);
    print("Buyer");
    tabchildren =  [
      BuyerTabScreen(user: widget.user),
      SellerTabScreen(user: widget.user),
      ProfileTabScreen(user: widget.user)
    ];
  }

  @override
  void dispose(){
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    bool? centerTitle;
    return Scaffold(
      
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

}
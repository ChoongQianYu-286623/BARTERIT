import 'dart:convert';
import 'dart:io';
import 'package:barterlt/myconfig.dart';
import 'package:barterlt/shared/cardinfoscreen.dart';
import 'package:barterlt/shared/editprofilescreen.dart';
import 'package:barterlt/shared/registrationscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:barterlt/models/user.dart';
import 'package:barterlt/shared/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ProfileTabScreen extends StatefulWidget {
  final User user;
  const ProfileTabScreen({super.key, required this.user});

  @override
  State<ProfileTabScreen> createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen> {
  final TextEditingController _oldpasswordController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  final TextEditingController _addressEditingController = TextEditingController();
  late List<Widget> tabchildren;
  String maintitle = "Profile";
  late double screenHeight,screenWidth, cardwidth;
  bool isDisable = false;
  var pathAsset = "assets/images/profile.png";


  @override
  void initState(){
    super.initState();
    print("Profile");
  }

  @override
  void dispose(){
    super.dispose();
    print("dispose");
    if(widget.user.id == 'na'){
      isDisable = true;
    } else {
      isDisable = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(maintitle,
        style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: _onlogout, 
            icon: const Icon(Icons.logout))
        ],
      ),
      body: widget.user.name.toString() == "na"
      ? Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              height: screenHeight * 0.50,
              width: screenWidth,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                     Text("Welcome!", style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                     Text(
                      "Guest",
                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    
                     CircleAvatar(
                      backgroundImage: AssetImage("assets/images/profile.png"),
                      radius: 70,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(20),
              children: [
              MaterialButton(onPressed: (){
               Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (content) => const RegistrationScreen()));
              },   
              color: const Color.fromRGBO(255,217,90,100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
              minWidth: 60,
              height: 40,
              elevation: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Registration",
                  style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 5,),
                  const Icon(Icons.arrow_circle_right_outlined),
                ],
              ),),//register
              
              const SizedBox(
                height: 15,
              ),
              
              MaterialButton(onPressed: (){
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (content) => const LoginScreen()));
              },
              color: const Color.fromRGBO(255,217,90,100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login",
                  style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 5,),
                  const Icon(Icons.arrow_circle_right_outlined),
                ],
              ),) //Login
              ],))
            ])
      : Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              height: screenHeight * 0.50,
              width: screenWidth,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Welcome!", style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                    Text(
                      widget.user.name.toString(),
                      style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  // CircleAvatar(
                  //   backgroundImage: AssetImage(pathAsset),
                  //   radius: 70,
                  // ),
                    Container(
                  margin: const EdgeInsets.all(4),
                  width: screenWidth * 0.4,
                  child: CachedNetworkImage(
                    imageUrl: "${MyConfig().SERVER}/barterlt/assets/profile_picture/${widget.user.id}.png",
                    imageBuilder: (context, imageProvider) => Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: imageProvider,fit: BoxFit.fill),
                      ),
                    ),
                    placeholder: (context, url) => const LinearProgressIndicator(),
                    errorWidget: (context, url, error) => Image.asset(pathAsset),
                    ),
                  ),
                    Text(
                      widget.user.email.toString(),
                      style: const TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(20),
              children: [
              
              MaterialButton(onPressed: ()async{
                await Navigator.push(context, 
                  MaterialPageRoute(
                  builder: (content) => EditProfileScreen(user: widget.user)));
                },
              color: const Color.fromRGBO(255,217,90,100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
              minWidth: 60,
              height: 40,
              elevation: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text("Edit Profile",
                  style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 5,),
                  const Icon(Icons.arrow_circle_right_outlined),
                ],
              ),
              ), //edit profile
              
              const SizedBox(
                height: 15,
              ),

              MaterialButton(onPressed: (){
                _updatePassDialog();
              },   
              color: const Color.fromRGBO(255,217,90,100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
              minWidth: 60,
              height: 40,
              elevation: 10,
              child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Change Password",
                    style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 5,),
                    const Icon(Icons.arrow_circle_right_outlined),
                  ],
                ),
              ), //change password

              const SizedBox(
                height: 15,
              ),

              MaterialButton(onPressed: (){
               Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (content) => CardInfoScreen(user: widget.user,)));
              },   
              color: const Color.fromRGBO(255,217,90,100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
              minWidth: 60,
              height: 40,
              elevation: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Add Card Information",
                  style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 5,),
                  const Icon(Icons.arrow_circle_right_outlined),
                ],
              ),),//change password
              
              const SizedBox(
                height: 15,
              ),

              MaterialButton(onPressed: (){
              _updateAddressDialog();
              },   
              color: const Color.fromRGBO(255,217,90,100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
              minWidth: 60,
              height: 40,
              elevation: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Edit Address Information",
                  style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 5,),
                  const Icon(Icons.arrow_circle_right_outlined),
                ],
              ),),

              const SizedBox(
                height: 15,
              ),

              MaterialButton(onPressed: (){
               Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (content) => const RegistrationScreen()));
              },   
              color: const Color.fromRGBO(255,217,90,100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
              minWidth: 60,
              height: 40,
              elevation: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Registration",
                  style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 5,),
                  const Icon(Icons.arrow_circle_right_outlined),
                ],
              ),),//register
              
              const SizedBox(
                height: 15,
              ),
              
              MaterialButton(onPressed: (){
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (content) => const LoginScreen()));
              },
              color: const Color.fromRGBO(255,217,90,100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login",
                  style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 5,),
                  const Icon(Icons.arrow_circle_right_outlined),
                ],
              ),) //Login
              ],))
          ],
        ),
      ),
    );
  }

  void _onlogout() {
    Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (content)=> const LoginScreen()));
  }
  
  void _updatePassDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Change Password?",
            style: TextStyle(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 30,
                child: TextFormField(
                    controller: _oldpasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Old Password',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                  ), ),
          
                  const  SizedBox(height: 5),
                  
                  SizedBox(
                    height: 30,
                    child: TextFormField(
                    controller: _newpasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'New Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                  )
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                changePass();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  
  void changePass() {
    http.post(Uri.parse("${MyConfig().SERVER}/barterlt/php/update_profile.php"),
    body: {
      "userid": widget.user.id,
      "oldpass": _oldpasswordController.text,
      "newpass": _newpasswordController.text
    }).then((response) {
      var jsondata = jsonDecode(response.body);
      if(response.statusCode == 200){
        if(jsondata['status' == 'success']){
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Update Success")));
          Navigator.pop(context);
          setState(() {
            
          });
        }else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Update Failed")));
        Navigator.pop(context);
      }
      }else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Update Failed")));
        Navigator.pop(context);
      }
    });
  }
  
  void _updateAddressDialog() {
   showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Update Address",
            style: TextStyle(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 50,
                child: TextFormField(
                    controller: _addressEditingController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Address',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                  ), ),
                  const  SizedBox(height: 5),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _updateAddress();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  
  void _updateAddress() {}
}
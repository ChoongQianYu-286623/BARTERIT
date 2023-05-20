import 'dart:async';
import 'dart:convert';
import 'package:barterlt/models/user.dart';
import 'package:barterlt/myconfig.dart';
import 'package:barterlt/screens/loginscreen.dart';
import 'package:barterlt/screens/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_animate/flutter_animate.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    checkAndLogin();
    // Timer(
    //   const Duration(seconds: 3), 
    //   () => Navigator.pushReplacement(context,
    //    MaterialPageRoute(builder: (content)=> const MainScreen(user: user,))));
  }
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: (
        Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash.jpg'),
              opacity: 0.5,
            fit: BoxFit.cover))),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Animate(
                effects: [FadeEffect(duration: 3.seconds)],
                child: Text("BARTERIT",
              style: GoogleFonts.righteous(
              fontSize: 50,
              fontWeight: FontWeight.bold,),
            ),
            ),
            Animate(
                effects: [FadeEffect(duration: 2.seconds)],
                child: Text(" \"Used goods are just as good\" ",
              style: GoogleFonts.caveat(
              color: const Color.fromRGBO(76, 61, 61, 30),
              fontSize: 25,
              fontWeight: FontWeight.bold,),
            ),
            ),
            const CircularProgressIndicator(),
            Text("Version 0.1",
            style: 
            GoogleFonts.robotoMono(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),)
            ],
          ),),
      ],
    )),
    );
  }
  
  checkAndLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email'))?? '';
    String password = (prefs.getString('pass'))?? '';
    bool ischeck = (prefs.getBool('checkbox'))?? false;
    late User user;
    if(ischeck){
      try{
              http.post(Uri.parse("${MyConfig().SERVER}/barterlt/php/login_user.php"),
      body: {"email": email, "password": password }).then((response){
        if(response.statusCode == 200){
          var jsondata = jsonDecode(response.body);
          user = User.fromJson(jsondata['data']);
          Timer(
              const Duration(seconds: 5), 
              () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (content)=> MainScreen(user: user,))));
        }else{
          user = User(
            id: "na",
            name: "na",
            email: "na",
            phone: "na",
            datereg: "na",
            password: "na",
            otp: "na",
          );
          Timer(
              const Duration(seconds: 5), 
              () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (content)=> const LoginScreen())));
        }
      }).timeout(const Duration(seconds: 5), onTimeout: (){

      });
      } on TimeoutException catch (_){
        print("Time out");
      }
    } else {
      user = User(
            id: "na",
            name: "na",
            email: "na",
            phone: "na",
            datereg: "na",
            password: "na",
            otp: "na",
          );
          Timer(
              const Duration(seconds: 5), 
              () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (content)=> const LoginScreen())));
    }
  }
}
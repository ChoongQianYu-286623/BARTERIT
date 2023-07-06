import 'dart:async';
import 'dart:convert';

import 'package:barterlt/models/user.dart';
import 'package:barterlt/myconfig.dart';
import 'package:barterlt/screens/mainscreen.dart';
import 'package:barterlt/screens/registrationscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late double screenHeight, screenWidth, cardwitdh;
  bool _isChecked = false;

  @override
  void initState(){
    super.initState();
    loadPref();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: screenHeight * 0.45,
              width: screenWidth,
             child: Image.asset("assets/images/login.jpg",
             fit: BoxFit.cover,),
            ),
            Padding(padding: const EdgeInsets.all(8.0),
            child: Card(
              color: const Color.fromRGBO(249, 251, 231, 50),
              elevation: 8,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16,4,16,4),
                child: Column(children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                      "Welcome to BarterIt",
                      style: TextStyle(
                        color: Color.fromRGBO(72, 33, 33, 2),
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),),
                        TextFormField(
                          controller: _emailEditingController,
                          validator: (val) => val!.isEmpty || !val.contains("@") || !val.contains(".")
                              ? "Please enter a valid email"
                              : null,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(),
                              icon: Icon(Icons.email_outlined),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2.0),
                              )
                              )
                        ),
                        TextFormField(
                          controller: _passEditingController,
                          validator: (val) => val!.isEmpty || (val.length < 5)
                              ? "Password must be longer than 5"
                              : null,
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(),
                              icon: Icon(Icons.lock_outline),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2.0),
                              )
                              )
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Checkbox(
                              value: _isChecked, 
                              onChanged: (bool? value){
                                saveremovepref(value!);
                                setState(() {
                                  _isChecked = value;
                                });
                              }),
                              Flexible(
                                child: GestureDetector(
                                  onTap: null,
                                  child: const Text("Remember Me",
                                  style: TextStyle(
                                    color: Color.fromRGBO(76, 61, 61, 50),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800
                                  ),),
                                ),),
                                const SizedBox(
                                  width: 10,
                                ),
                                MaterialButton(
                                  color: const Color.fromRGBO(255,217,90,100),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                    minWidth: 60,
                                    height: 40,
                                    elevation: 10,
                                  onPressed: onLogin,
                                  child: Row(
                                    children: const [
                                      Text("Login"),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Icon(Icons.arrow_forward_outlined),
                                    ],
                                  ),
                                  ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: _goToRegister,
                          child:  RichText(
              text: const TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "Not a user?  ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black
                    )
                  ),
                  TextSpan(
                    text: "Register",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                      color: Color.fromRGBO(183, 4, 4, 80)
                    )
                  ),
                ])),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: (){
                          //   Navigator.pushReplacement(
                          // context, 
                          //   MaterialPageRoute(
                          //   builder: (content) =>  MainScreen(
                          //   user: widget.user,)));
                            },
                          child:  RichText(
                            text: const TextSpan(
                               children: <TextSpan>[
                                TextSpan(
                                  text: "Login as  ",
                                  style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black
                                  )
                                ),
                              TextSpan(
                                  text: "Guest",
                                  style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
                                  color: Color.fromRGBO(183, 4, 4, 80)
                                  )
                                ),
                          ])),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: _forgotDialog,
                          child: const Text("Forgot Password?",
                          style: TextStyle(fontSize: 14),),
                        ),
                      ],
                    ))
                ],),
              ),
            ),)
          ],
        ),
      ),
    );
  }
  
  

  void onLogin() {
    if(!_formKey.currentState!.validate()){
      ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text("Check your input")));
      return;
    }
    String email = _emailEditingController.text;
    String pass = _passEditingController.text;
    print(pass);
    try {
      http.post(Uri.parse("${MyConfig().SERVER}/barterlt/php/login_user.php"),
      body: {
        "email": email,
        "password": pass,
      }).then((response){
        print(response.body);
        if(response.statusCode == 200){
          var jsondata = jsonDecode(response.body);
          if(jsondata['status'] == 'success'){
            User user = User.fromJson(jsondata['data']);
            print(user.name);
            print(user.email);
            ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Login Success")));
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(
                builder: (content) => MainScreen(
                  user: user,)));
          }else {
            ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Login Failed")));
          }
        }
      }).timeout(const Duration(seconds: 5),onTimeout: (){

      });
    }on TimeoutException catch(_){
      print("Time out");
    }
  }

  void _goToRegister() {
    Navigator.push(context, MaterialPageRoute(builder: (content) => const RegistrationScreen()));
  }

  void _forgotDialog() {
  }

  void saveremovepref(bool value) async{
    FocusScope.of(context).requestFocus(FocusNode());
    String email = _emailEditingController.text;
    String password = _passEditingController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(value){
      if(!_formKey.currentState!.validate()){
        _isChecked = false;
        return;
      }
      await prefs.setString('email', email);
      await prefs.setString('pass', password);
      await prefs.setBool('checkbox', value);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Preferences Stored")));
    }else {
      await prefs.setString('email', '');
      await prefs.setString('pass', '');
      await prefs.setBool('checkbox', false);
      setState(() {
        _emailEditingController.text = '';
        _passEditingController.text = '';
        _isChecked = false;
      });
      ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text("Preferences Removed")));
    }
  } 

  Future<void> loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email'))??'';
    String password = (prefs.getString('pass'))??'';
    _isChecked = (prefs.getBool('checkbox'))?? false;
    if(_isChecked){
      setState(() {
        _emailEditingController.text = email;
        _passEditingController.text = password;
      });
    }
  }
}

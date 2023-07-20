import 'dart:convert';

import 'package:barterlt/myconfig.dart';
import 'package:barterlt/shared/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final TextEditingController _pass2EditingController = TextEditingController();
  bool _isChecked = false;
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  late double screenHeight, screenWidth;
  String eula = "";
  

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: screenHeight * 0.50,
            width: screenWidth,
            child: Image.asset("assets/images/register.jpg",
            fit: BoxFit.cover,
            ),
          ),
          Padding(padding: const EdgeInsets.all(8.0),
          child: Card(
            color: const Color.fromRGBO(249, 251, 231, 50),
            elevation: 8,
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(children: [
                Form(
                  key: _formKey,
                  child: Column(children: [
                    const Text(
                      "Registration Form",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                TextFormField(
                  controller: _nameEditingController,
                  validator: (val) => val!.isEmpty || (val.length < 5)
                  ? "Name must be longer than 5"
                  : null,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(),
                    icon: Icon(Icons.person),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0)
                    )
                  ),
                ),
                TextFormField(
                  controller: _emailEditingController,
                  validator: (val) => val!.isEmpty || !val.contains("@") || !val.contains(".")
                  ? "Please enter a valid email"
                  : null,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(),
                    icon: Icon(Icons.email_outlined),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0)
                    )
                  ),
                ),
                TextFormField(
                  controller: _phoneEditingController,
                  validator: (val) => val!.isEmpty || (val.length < 10)
                  ? "phone must be longer than 10"
                  : null,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Phone",
                    labelStyle: TextStyle(),
                    icon: Icon(Icons.phone_android),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0)
                    )
                  ),
                ),
                TextFormField(
                  controller: _passEditingController,
                  validator: (val) => val!.isEmpty || (val.length < 5)
                  ? "Password must be longer than 5"
                  : null,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: const TextStyle(),
                    icon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: (){
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0)
                    )
                  ),
                ),
                TextFormField(
                  controller: _pass2EditingController,
                  validator: (val) => val!.isEmpty || (val.length < 5)
                  ? "Password must be longer than 5"
                  : null,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    labelText: "Re-enter password",
                    labelStyle: const TextStyle(),
                    icon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: (){
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0)
                    )
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _isChecked, 
                      onChanged: (bool? value){
                      if(!_isChecked){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text(
                            "Terms have been read and accpeted")));
                      }
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: _showEULA,
                    child: Text("Agree with terms",
                    style: GoogleFonts.notoSerif(
                      fontSize: 13,
                      fontWeight: FontWeight.w800),)
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: ElevatedButton(
                    onPressed: onRegisterDialog, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(255,217,90,100),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )
                    ),
                    child: Row(
                        children: const [
                          Text("Register",
                          style: TextStyle(fontSize: 12),),
                          
                          SizedBox(
                          width: 2,
                          ),
                          Icon(Icons.arrow_forward_outlined,size: 15,),
                          ],
                        ),))
                  ],
                )
                  ],),
              )],
                ),
            ),
          ),),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: _goLogin,
            child: RichText(
              text: const TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "Already register?  ",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black
                    )
                  ),
                  TextSpan(
                    text: "Login",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 15,
                      color: Color.fromRGBO(183, 4, 4, 80)
                    )
                  ),
                ])),
          ),
          const SizedBox(
            height: 16,
          ),
        ],),
      ),
    );
  }

  void onRegisterDialog() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Check your input")));
      return;
    }
    if (!_isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please agree with terms and conditions")));
      return;
    }
    String passa = _passEditingController.text;
    String passb = _pass2EditingController.text;
    if (passa != passb) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Check your password")));
      return;
    }
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          title: const Text("Register new account?",
          style: TextStyle(),),
          content: const Text("Are you sure?", style: TextStyle(),),
          actions: <Widget>[
            TextButton(
              child: const Text("Yes",
              style: TextStyle(),),
              onPressed: (){
                Navigator.of(context).pop();
                registerUser();
              },),
            TextButton(
              child: const Text("No",
              style: TextStyle(),),
              onPressed: (){
                Navigator.of(context).pop();
              }
            )
          ],
        );
      });
  }

    void registerUser() {
      showDialog(
        context: context, 
        builder: (BuildContext context){
          return const AlertDialog(
            title: Text("Please Wait"),
            content: Text("Registration in progress"),
          );
        });
        String name = _nameEditingController.text;
        String email = _emailEditingController.text;
        String phone = _phoneEditingController.text;
        String passa = _passEditingController.text;

        http.post(Uri.parse("${MyConfig().SERVER}/barterlt/php/register_user.php"), 
        body: {
          "name": name,
          "email": email,
          "phone": phone,
          "password": passa,
        }).then((response){
          if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registration Success")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registration Failed")));
        }
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Registration Failed")));
        Navigator.pop(context);
      }
        });
    }


  void _goLogin() {
    Navigator.push(context, MaterialPageRoute(builder: (content) => const LoginScreen()));
  }

  loadEula() async{
    eula = await rootBundle.loadString('assets/eula.txt');
  }

  void _showEULA(){
    loadEula();
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title:  const Text(
            "EULA",
          style: TextStyle(

          ),),
          content: SizedBox(
            height: screenHeight / 1.5,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: RichText(
                      softWrap: true,
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black
                        ),
                        text: eula
                      ),),
                  ))
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: (){
                Navigator.of(context).pop();
              },)
          ],
        );
      });
  }
 } 

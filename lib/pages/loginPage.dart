import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class loginPage extends StatefulWidget {
  static const routeName = '/loginPage';

  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double spacer = 20;
    return Scaffold(
      backgroundColor:Color.fromRGBO(242, 247, 252, 1.0), // Color.fromRGBO(242, 247, 252, 1),
      body: Animate(
        effects: [FadeEffect(duration: Duration(milliseconds: 700))],

        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Image.asset("assets/logo.png"),
              SizedBox(
                height: spacer,
              ), //Namdhinggo
              Text(
                "Login to self storage",
                style: TextStyle( fontSize:  32 , fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: spacer,
              ),
          Container(
            width: size.width * 0.4,
            height: size.height * 0.4,
            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(30),
              color: Colors.white ,
              //color: Color.fromRGBO(232, 240, 254, 1.0), // Background color


            ),
            padding: EdgeInsets.all(16.0),
            child: Center(
              child:Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Username',
                        fillColor: Colors.white, // Text input background color
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0), // Spacer
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      obscureText: true, // Password field with hidden text
                      decoration: InputDecoration(
                        hintText: 'Password',
                        fillColor: Colors.white, // Text input background color
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0), // Spacer
                    GestureDetector(
                      onTap: (){
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, perform login logic here
                          // For now, you can print a message
                          print('Login successful!');
                        }
                      },
                      child: Container(
                        width: 90,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(33, 103, 199, 1) ,
                          borderRadius: BorderRadius.circular(30) ,
                        ),
                        child: Center(child: Text("Login" , style: TextStyle(color: Colors.white),)),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextButton(onPressed: (){}, child: Text("Forgot your password?"))

                  ],
                ),
              ),
            ),

            ),




             /* Container(
                width: size.width * 0.4,
                height: size.height * 0.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),

                ),
                child:
              )*/
            ],
          ),
        ),
      ),
    );
  }
}

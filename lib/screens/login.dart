import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food/screens/home.dart';
import 'package:food/screens/signup.dart';
import 'package:food/widget/support_widget.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});
  @override
  State<LogIn> createState() => _LogInState();
}
class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();

  String email="",password="";

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  userLogin()async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()),);
    }on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(backgroundColor: Colors.redAccent,content: Text(
                "No user found for that email",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          );
      }else if(e.code == 'wrong-password'){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(backgroundColor: Colors.redAccent,content: Text(
                "wrong password Provided by User",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
          child:Form(
            key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/login.png"),
              Center(
                child: Text("Sign In", style: AppWidget.lightTextFeildStyle()),
              ),
              SizedBox(height: 20.0),
              Text(
                "Please enter the details below to\ncontinue",
                style: AppWidget.lightTextFeildStyle(),
              ),

              SizedBox(height: 40.0),
              Text("Email", style: AppWidget.lightTextFeildStyle()),

              SizedBox(height: 20.0),

              Container(
                padding: EdgeInsets.only(left: 20.0),
                decoration: BoxDecoration(
                  color: Color(0xFFF4F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                   validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      return null;
                    },

                  controller: mailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Email",
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text("Password", style: AppWidget.lightTextFeildStyle()),
              SizedBox(height: 20.0),

              Container(
                padding: EdgeInsets.only(left: 20.0),
                decoration: BoxDecoration(
                  color: Color(0xFFF4F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: passwordController,
                   validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },

                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Password",
                  ),
                ),
              ),

              SizedBox(height: 20.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 28.0),
              GestureDetector(
                onTap: (){
                 if(_formKey.currentState!.validate()){
                  setState(() {
                    email = mailController.text;
                    password = passwordController.text;
                  });
                 } 
                 userLogin();
                },
              child:Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              ),
              SizedBox(height: 20.0),
              // ✅ Replaced Row + wrap() with proper Wrap widget
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: AppWidget.lightTextFeildStyle(),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food/screens/home.dart';
import 'package:food/screens/login.dart';
import 'package:food/widget/support_widget.dart';
import 'package:food/screens/bottom_nav.dart';  // Adjust path if needed
import 'package:cloud_firestore/cloud_firestore.dart';



class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? name, email, password;
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // registration() async {
  //   if (password != null && name != null && email != null) {
  //     try {
  //       UserCredential userCredential =
  //           await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //               email: email!, password: password!);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           backgroundColor: Colors.redAccent,
  //           content: Text(
  //             "Registered Successfully",
  //             style: TextStyle(fontSize: 20.0),
              
  //           ),
  //         ),
  //       );
  //       Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()),);
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'weak-password') {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             backgroundColor: Colors.redAccent,
  //             content: Text(
  //               "Password provided is too weak",
  //               style: TextStyle(fontSize: 20.0),
  //             ),
  //           ),
  //         );
  //       } else if (e.code == 'email-already-in-use') {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             backgroundColor: Colors.redAccent,
  //             content: Text(
  //               "Account already exists",
  //               style: TextStyle(fontSize: 20.0),
  //             ),
  //           ),
  //         );
  //       }
  //     }
  //   }
  // }
  registration() async {
  if (password != null && name != null && email != null) {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email!, password: password!);

      final user = userCredential.user;
      if (user != null) {
        // update displayName in FirebaseAuth
        await user.updateDisplayName(name);
        await user.reload();

        // save to Firestore users/<uid>
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Registered Successfully", style: TextStyle(fontSize: 20.0)),
        ),
      );

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    } on FirebaseAuthException catch (e) {
      // ... keep your existing error handling
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/images/login.png"),
                Center(
                  child: Text("Sign Up", style: AppWidget.lightTextFeildStyle()),
                ),
                const SizedBox(height: 20.0),
                Text(
                  "Please enter the details below to\ncontinue",
                  style: AppWidget.lightTextFeildStyle(),
                ),
                const SizedBox(height: 40.0),

                // Name
                Text("Name", style: AppWidget.lightTextFeildStyle()),
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Name",
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),

                // Email
                Text("Email", style: AppWidget.lightTextFeildStyle()),
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Email";
                      }
                      return null;
                    },
                    controller: mailController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                // Password
                Text("Password", style: AppWidget.lightTextFeildStyle()),
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    obscureText:true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                    ),
                  ),
                ),
                const SizedBox(height: 28.0),

                // Sign Up Button
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          name = nameController.text.trim();
                          email = mailController.text.trim();
                          password = passwordController.text.trim();
                        });
                        registration();
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: const EdgeInsets.all(18.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Center(
                        child: Text(
                          "Sign Up",
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
                const SizedBox(height: 20.0),

                // Sign In Link
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: AppWidget.lightTextFeildStyle(),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LogIn()),
                        );
                      },
                      child: const Text(
                        "Sign In",
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

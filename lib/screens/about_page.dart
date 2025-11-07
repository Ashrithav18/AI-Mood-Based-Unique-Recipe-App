import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) => 
  Scaffold(
    appBar: AppBar(
      title:Text("About Us"),
      backgroundColor: Colors.orange,
    ),
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.orange.shade50,Colors.orange.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        ),
      ),
    child: ListView(
      padding: const EdgeInsets.all(20.0),
      children: [ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          'assents/images/chef.jpg',
          fit: BoxFit.cover,
          height: 200,
        ),
      ),
      SizedBox(height: 20),

      Text(
        'Welcome to Unique Recipe App 🍲',
        style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
      ),
      SizedBox(height: 10),
       Text(
              'Where every recipe tells a story!',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Colors.grey[700],
              ),
            ),
    SizedBox(height: 20),
     Text(
              'We bring together tasty traditions, quick snacks, unique and creative healthy dishes so you can cook confidently at home. '
              'Our recipes include easy steps, calorie info, and Health benefits to make your cooking journey fun.\n\n'
              'Whether you’re making a quick breakfast or trying an exotic dessert, we guide you from pan to plate.\n\n'
              'Cook and enjoy — because good food is made o enjoy! ❤️',
              style: TextStyle(fontSize: 16, height: 1.5),
              ),
      Text(   'For any enquiries please mail us at 📩:uniquerecipesapp@gmail.com',
               style: TextStyle(fontSize: 16, height: 1.5,color:Colors.blue),
              

      ),
      ],
    ),
   
    ),
  );
}

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// ✅ Store suggestions globally
List<Map<String, String>> suggestions = [];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suggestion Box App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: SuggestionPage(),
    );
  }
}

class SuggestionPage extends StatefulWidget {
  @override
  _SuggestionPageState createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController recipeController = TextEditingController();

  void addSuggestion() {
    if (nameController.text.isNotEmpty && recipeController.text.isNotEmpty) {
      setState(() {
        suggestions.add({
          'name': nameController.text,
          'recipe': recipeController.text,
        });
      });
      nameController.clear();
      recipeController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("✅ Thank you for your suggestion!"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // light background
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.yellowAccent),
            SizedBox(width: 10),
            Text("Suggestion Box"),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "💡 Share your unique recipe idea!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),

            // Recipe Name Field
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.fastfood, color: Colors.yellow),
                labelText: "Recipe Name",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 15),

            // Suggestion Field
            TextField(
              controller: recipeController,
              maxLines: 4,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.edit_note, color: Colors.yellow),
                labelText: "Your Suggestion",
                alignLabelWithHint: true,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 15),

            // Submit Button
            Center(
              child: ElevatedButton.icon(
                onPressed: addSuggestion,
                icon: Icon(Icons.send, color: Colors.white),
                label: Text("Submit"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Suggestions List
            Expanded(
              child: suggestions.isEmpty
                  ? Center(
                      child: Text(
                        "No suggestions yet 🙁",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        final suggestion = suggestions[index];
                        return Card(
                          color: Colors.white,
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            leading: Icon(Icons.restaurant_menu,
                                color: Colors.yellow, size: 30),
                            title: Text(
                              suggestion['name']!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange),
                            ),
                            subtitle: Text(suggestion['recipe']!),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

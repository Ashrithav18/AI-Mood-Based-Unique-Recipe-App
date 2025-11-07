
// import 'package:flutter/material.dart';
// import 'package:food/model/food_model.dart';
// import '../data/food_list.dart';
// import '../model/food_model.dart';

// class AISuggestionPage extends StatefulWidget {
//   @override
//   _AISuggestionPageState createState() => _AISuggestionPageState();
// }

// class _AISuggestionPageState extends State<AISuggestionPage> {
//   final TextEditingController _ingredientsController = TextEditingController();
//   List<Food> _suggestedFoods = [];
//   bool _isLoading = false;
//   late List<Food> _allFoods;

//   @override
//   void initState() {
//     super.initState();
//     _allFoods = getFoodsFromList();
//     print('Total foods loaded: ${_allFoods.length}');
//     _allFoods.forEach((food) => print('Food: ${food.name}, Ingredients: ${food.ingredients}'));
//   }

//   void _getSuggestions() {
//     final String input = _ingredientsController.text;
//     print('User input: "$input"');
    
//     if (input.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please enter some ingredients'))
//       );
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//       _suggestedFoods = [];
//     });

//     // Simulate processing delay
//     Future.delayed(Duration(seconds: 1), () {
//       final List<String> availableIngredients = input
//           .toLowerCase()
//           .split(',')
//           .map((ingredient) => ingredient.trim())
//           .where((ingredient) => ingredient.isNotEmpty)
//           .toList();

//       print('Parsed ingredients: $availableIngredients');

//       // AI Suggestion Logic - FIXED
//       List<Food> suggestions = _allFoods.where((food) {
//         bool matches = food.containsIngredients(availableIngredients);
//         print('${food.name} matches: $matches');
//         return matches;
//       }).toList();

//       print('Found ${suggestions.length} suggestions');

//       // Sort by relevance (more matching ingredients first)
//       suggestions.sort((a, b) {
//         final double aScore = a.calculateMatchScore(availableIngredients);
//         final double bScore = b.calculateMatchScore(availableIngredients);
//         return bScore.compareTo(aScore);
//       });

//       setState(() {
//         _suggestedFoods = suggestions;
//         _isLoading = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('AI Food Suggestions'),
//         backgroundColor: Colors.orangeAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Ingredients Input
//             TextField(
//               controller: _ingredientsController,
//               decoration: InputDecoration(
//                 labelText: 'What ingredients do you have?',
//                 hintText: 'e.g., sago, milk, moong dal (comma separated)',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.kitchen),
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.search),
//                   onPressed: _getSuggestions,
//                 ),
//               ),
//               onSubmitted: (_) => _getSuggestions(),
//             ),
//             SizedBox(height: 24),
            
//             // Suggest Button
//             ElevatedButton(
//               onPressed: _getSuggestions,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 foregroundColor: Colors.white,
//                 padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//               ),
//               child: _isLoading
//                   ? CircularProgressIndicator(color: Colors.white)
//                   : Text('Find Recipes', style: TextStyle(fontSize: 16)),
//             ),
//             SizedBox(height: 24),
            
//             // Results Header
//             if (_suggestedFoods.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: Text(
//                   'Found ${_suggestedFoods.length} recipe(s)',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
            
//             // Results List
//             Expanded(
//               child: _suggestedFoods.isEmpty && !_isLoading
//                   ? Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.search, size: 64, color: Colors.grey),
//                           SizedBox(height: 16),
//                           Text(
//                             'Enter ingredients you have to find recipes!\n\nExample: sago, milk, sugar',
//                             style: TextStyle(fontSize: 16, color: Colors.grey),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     )
//                   : _isLoading
//                       ? Center(child: CircularProgressIndicator())
//                       : ListView.builder(
//                           itemCount: _suggestedFoods.length,
//                           itemBuilder: (context, index) {
//                             final food = _suggestedFoods[index];
//                             return FoodCard(food: food);
//                           },
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Food Card Widget
// class FoodCard extends StatelessWidget {
//   final Food food;

//   const FoodCard({required this.food});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       elevation: 3,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Food Name
//             Text(
//               food.name,
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 12),
            
//             // Ingredients
//             Text(
//               'Ingredients:',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             SizedBox(height: 4),
//             Wrap(
//               spacing: 8,
//               runSpacing: 4,
//               children: food.ingredients.map((ingredient) => Chip(
//                 label: Text(ingredient),
//                 backgroundColor: Colors.blue[100],
//               )).toList(),
//             ),
//             SizedBox(height: 12),
            
//             // Calories
//             Text(
//               'Calories: ${food.calories}',
//               style: TextStyle(color: Colors.orange, fontSize: 14),
//             ),
//             SizedBox(height: 8),
            
//             // Benefits (if available)
//             if (food.benefits != null) ...[
//               Text(
//                 'Benefits:',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//               ),
//               SizedBox(height: 4),
//               Text(
//                 food.benefits!,
//                 style: TextStyle(fontSize: 14, color: Colors.green[700]),
//               ),
//               SizedBox(height: 12),
//             ],
            
//             // Action Buttons
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       _showRecipeDialog(context, food);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.orange,
//                       foregroundColor: Colors.white,
//                     ),
//                     child: Text('View Recipe'),
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 IconButton(
//                   icon: Icon(Icons.videocam, color: Colors.blue),
//                   onPressed: () {
//                     _showVideoDialog(context, food);
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showRecipeDialog(BuildContext context, Food food) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(food.name),
//         content: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Recipe:', style: TextStyle(fontWeight: FontWeight.bold)),
//               SizedBox(height: 8),
//               Text(food.recipe),
//               SizedBox(height: 16),
//               Text('Ingredients:', style: TextStyle(fontWeight: FontWeight.bold)),
//               SizedBox(height: 8),
//               ...food.ingredients.map((ingredient) => Text('• $ingredient')).toList(),
//               SizedBox(height: 16),
//               Text('Calories: ${food.calories}', style: TextStyle(fontWeight: FontWeight.bold)),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showVideoDialog(BuildContext context, Food food) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('${food.name} Video'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(Icons.videocam, size: 64, color: Colors.blue),
//             SizedBox(height: 16),
//             Text('Video tutorial available for ${food.name}'),
//             SizedBox(height: 8),
//             Text('Path: ${food.video}'),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Close'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Add video player implementation here
//             },
//             child: Text('Play Video'),
//           ),
//         ],
//       ),
//    );
//    }
// }

// import 'package:flutter/material.dart';
// import 'package:food/model/food_model.dart';
// import '../data/food_list.dart';
// import '../model/food_model.dart';

// class AISuggestionPage extends StatefulWidget {
//   @override
//   _AISuggestionPageState createState() => _AISuggestionPageState();
// }

// class _AISuggestionPageState extends State<AISuggestionPage> {
//   final TextEditingController _ingredientsController = TextEditingController();
//   List<Food> _suggestedFoods = [];
//   bool _isLoading = false;
//   late List<Food> _allFoods;

//   @override
//   void initState() {
//     super.initState();
//     _allFoods = getFoodsFromList();
//     print('Total foods loaded: ${_allFoods.length}');
//     print('Available foods:');
//     _allFoods.forEach((food) => print('- ${food.name}'));
//   }

//   // Improved ingredient matching function
//   bool _foodContainsIngredients(Food food, List<String> availableIngredients) {
//     if (availableIngredients.isEmpty) return false;
    
//     for (String ingredient in availableIngredients) {
//       for (String foodIngredient in food.ingredients) {
//         if (foodIngredient.toLowerCase().contains(ingredient.toLowerCase())) {
//           return true; // Return true if any ingredient matches
//         }
//       }
//     }
//     return false;
//   }

//   // Calculate match score for sorting
//   double _calculateMatchScore(Food food, List<String> availableIngredients) {
//     if (availableIngredients.isEmpty) return 0.0;
    
//     int matchCount = 0;
//     for (String ingredient in availableIngredients) {
//       for (String foodIngredient in food.ingredients) {
//         if (foodIngredient.toLowerCase().contains(ingredient.toLowerCase())) {
//           matchCount++;
//           break; // Count each available ingredient only once
//         }
//       }
//     }
    
//     return matchCount / availableIngredients.length;
//   }

//   // Improved mood-based suggestion method
//   void _getMoodSuggestions() {
//     final String input = _ingredientsController.text.toLowerCase();
//     print('User mood input: "$input"');
    
//     if (input.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please enter your mood or ingredients'))
//       );
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//       _suggestedFoods = [];
//     });

//     Future.delayed(Duration(seconds: 1), () {
//       // Map moods to specific foods in your list
//       final Map<String, List<String>> moodToFoodMap = {
//         'happy': ['Rasmalai', 'Gulab Jamun', 'Jalebi', 'Kheer', 'Baklava', 'Turkish', 'Lamington'],
//         'sad': ['Soup', 'Chai', 'Chocolate', 'Comfort', 'Pudding', 'Custard'],
//         'tired': ['Energy', 'Protein', 'Quick', 'Healthy', 'Ragi', 'Noodles'],
//         'excited': ['Biryani', 'Chicken', 'Special', 'Festive', 'Celebration', 'Baklava'],
//         'stressed': ['Tea', 'Milk', 'Warm', 'Comfort', 'Pudding', 'Custard'],
//         'bored': ['New', 'Different', 'Unique', 'Exotic', 'Korean', 'Arabian'],
//         'relaxed': ['Fresh', 'Green', 'Light', 'Healthy', 'Salad', 'Jelly'],
//         'angry': ['Cold', 'Ice', 'Refreshing', 'Cool', 'Smoothie', 'Jelly'],
//         'sick': ['Plain', 'Simple', 'Clear', 'Boiled', 'Soup', 'Light'],
//         'celebrating': ['Sweet', 'Special', 'Festive', 'Party', 'Cake', 'Baklava'],
//       };

//       // Check if input contains mood words
//       String detectedMood = '';
//       final moodKeywords = ['happy', 'sad', 'tired', 'excited', 'stressed', 
//                            'bored', 'relaxed', 'angry', 'sick', 'celebrating',
//                            'mood', 'feel', 'feeling'];
      
//       for (String mood in moodKeywords) {
//         if (input.contains(mood)) {
//           detectedMood = mood;
//           break;
//         }
//       }

//       // Additional mood detection patterns
//       if (detectedMood.isEmpty) {
//         if (input.contains('today i am') || input.contains('today my mood')) {
//           if (input.contains('not good') || input.contains('bad')) {
//             detectedMood = 'sad';
//           } else if (input.contains('good') || input.contains('happy')) {
//             detectedMood = 'happy';
//           } else if (input.contains('tired') || input.contains('exhausted')) {
//             detectedMood = 'tired';
//           }
//         }
//       }

//       List<Food> suggestions = [];

//       if (detectedMood.isNotEmpty) {
//         print('Detected mood: $detectedMood');
        
//         // Get foods for this mood
//         final preferredFoodKeywords = moodToFoodMap[detectedMood] ?? [];
        
//         // Find foods that match mood keywords
//         suggestions = _allFoods.where((food) {
//           // Check if food name contains any mood-related keywords
//           for (String keyword in preferredFoodKeywords) {
//             if (food.name.toLowerCase().contains(keyword.toLowerCase())) {
//               return true;
//             }
//           }
          
//           // Check ingredients
//           for (String keyword in preferredFoodKeywords) {
//             for (String ingredient in food.ingredients) {
//               if (ingredient.toLowerCase().contains(keyword.toLowerCase())) {
//                 return true;
//               }
//             }
//           }
          
//           // Check benefits if available
//           if (food.benefits != null) {
//             for (String keyword in preferredFoodKeywords) {
//               if (food.benefits!.toLowerCase().contains(keyword.toLowerCase())) {
//                 return true;
//               }
//             }
//           }
          
//           return false;
//         }).toList();
        
//         print('Found ${suggestions.length} mood-based suggestions');
//       }

//       // If no mood-based suggestions found, fall back to ingredient search
//       if (suggestions.isEmpty) {
//         print('No mood-based suggestions found, falling back to ingredient search');
        
//         final List<String> availableIngredients = input
//             .split(',')
//             .map((ingredient) => ingredient.trim())
//             .where((ingredient) => ingredient.isNotEmpty)
//             .toList();

//         print('Trying ingredient search: $availableIngredients');

//         suggestions = _allFoods.where((food) {
//           return _foodContainsIngredients(food, availableIngredients);
//         }).toList();

//         print('Found ${suggestions.length} ingredient-based suggestions');
        
//         // Sort by relevance (more matching ingredients first)
//         suggestions.sort((a, b) {
//           final double aScore = _calculateMatchScore(a, availableIngredients);
//           final double bScore = _calculateMatchScore(b, availableIngredients);
//           return bScore.compareTo(aScore);
//         });
//       }

//       setState(() {
//         _suggestedFoods = suggestions;
//         _isLoading = false;
//       });
//     });
//   }

//   void _getSuggestions() {
//     final String input = _ingredientsController.text.toLowerCase();
    
//     // Check if input looks like a mood description rather than ingredients
//     final moodPattern = RegExp(r'\b(happy|sad|tired|excited|stressed|bored|relaxed|angry|sick|celebrating|mood|feel|feeling)\b');
    
//     if (moodPattern.hasMatch(input) || 
//         input.contains('today i am') || 
//         input.contains('today my mood') ||
//         input.contains('what can i make')) {
//       _getMoodSuggestions();
//     } else {
//       // Original ingredient-based search
//       final String inputText = _ingredientsController.text;
//       print('User input: "$inputText"');
      
//       if (inputText.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Please enter some ingredients'))
//         );
//         return;
//       }

//       setState(() {
//         _isLoading = true;
//         _suggestedFoods = [];
//       });

//       Future.delayed(Duration(seconds: 1), () {
//         final List<String> availableIngredients = inputText
//             .toLowerCase()
//             .split(',')
//             .map((ingredient) => ingredient.trim())
//             .where((ingredient) => ingredient.isNotEmpty)
//             .toList();

//         print('Parsed ingredients: $availableIngredients');

//         // Use the improved ingredient matching
//         List<Food> suggestions = _allFoods.where((food) {
//           bool matches = _foodContainsIngredients(food, availableIngredients);
//           print('Checking ${food.name}: $matches');
//           if (matches) {
//             print('  Food ingredients: ${food.ingredients}');
//             print('  Available ingredients: $availableIngredients');
//           }
//           return matches;
//         }).toList();

//         print('Found ${suggestions.length} suggestions');

//         // Sort by relevance (more matching ingredients first)
//         suggestions.sort((a, b) {
//           final double aScore = _calculateMatchScore(a, availableIngredients);
//           final double bScore = _calculateMatchScore(b, availableIngredients);
//           return bScore.compareTo(aScore);
//         });

//         setState(() {
//           _suggestedFoods = suggestions;
//           _isLoading = false;
//         });
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('AI Food Suggestions'),
//         backgroundColor: Colors.orangeAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Ingredients Input
//             TextField(
//               controller: _ingredientsController,
//               decoration: InputDecoration(
//                 labelText: 'What ingredients do you have? Or how are you feeling?',
//                 hintText: 'e.g., sago, milk OR today I feel happy',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.kitchen),
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.search),
//                   onPressed: _getSuggestions,
//                 ),
//               ),
//               onSubmitted: (_) => _getSuggestions(),
//             ),
//             SizedBox(height: 24),
            
//             // Suggest Button
//             ElevatedButton(
//               onPressed: _getSuggestions,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 foregroundColor: Colors.white,
//                 padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//               ),
//               child: _isLoading
//                   ? CircularProgressIndicator(color: Colors.white)
//                   : Text('Find Recipes', style: TextStyle(fontSize: 16)),
//             ),
//             SizedBox(height: 24),
            
//             // Results Header
//             if (_suggestedFoods.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: Text(
//                   'Found ${_suggestedFoods.length} recipe(s)',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
            
//             // Results List
//             Expanded(
//               child: _suggestedFoods.isEmpty && !_isLoading
//                   ? Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.search, size: 64, color: Colors.grey),
//                           SizedBox(height: 16),
//                           Text(
//                             'Enter ingredients you have to find recipes!\nOr tell us how you\'re feeling today!\n\nExamples:\n- sago, milk, sugar\n- today I feel happy\n- I\'m stressed and need comfort food',
//                             style: TextStyle(fontSize: 16, color: Colors.grey),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     )
//                   : _isLoading
//                       ? Center(child: CircularProgressIndicator())
//                       : ListView.builder(
//                           itemCount: _suggestedFoods.length,
//                           itemBuilder: (context, index) {
//                             final food = _suggestedFoods[index];
//                             return FoodCard(food: food);
//                           },
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Food Card Widget
// class FoodCard extends StatelessWidget {
//   final Food food;

//   const FoodCard({required this.food});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       elevation: 3,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Food Name
//             Text(
//               food.name,
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 12),
            
//             // Ingredients
//             Text(
//               'Ingredients:',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             SizedBox(height: 4),
//             Wrap(
//               spacing: 8,
//               runSpacing: 4,
//               children: food.ingredients.map((ingredient) => Chip(
//                 label: Text(ingredient),
//                 backgroundColor: Colors.blue[100],
//               )).toList(),
//             ),
//             SizedBox(height: 12),
            
//             // Calories
//             Text(
//               'Calories: ${food.calories}',
//               style: TextStyle(color: Colors.orange, fontSize: 14),
//             ),
//             SizedBox(height: 8),
            
//             // Benefits (if available)
//             if (food.benefits != null && food.benefits!.isNotEmpty) ...[
//               Text(
//                 'Benefits:',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//               ),
//               SizedBox(height: 4),
//               Text(
//                 food.benefits!,
//                 style: TextStyle(fontSize: 14, color: Colors.green[700]),
//               ),
//               SizedBox(height: 12),
//             ],
            
//             // Action Buttons
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       _showRecipeDialog(context, food);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.orange,
//                       foregroundColor: Colors.white,
//                     ),
//                     child: Text('View Recipe'),
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 IconButton(
//                   icon: Icon(Icons.videocam, color: Colors.blue),
//                   onPressed: () {
//                     _showVideoDialog(context, food);
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showRecipeDialog(BuildContext context, Food food) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(food.name),
//         content: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Recipe:', style: TextStyle(fontWeight: FontWeight.bold)),
//               SizedBox(height: 8),
//               Text(food.recipe),
//               SizedBox(height: 16),
//               Text('Ingredients:', style: TextStyle(fontWeight: FontWeight.bold)),
//               SizedBox(height: 8),
//               ...food.ingredients.map((ingredient) => Text('• $ingredient')).toList(),
//               SizedBox(height: 16),
//               Text('Calories: ${food.calories}', style: TextStyle(fontWeight: FontWeight.bold)),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showVideoDialog(BuildContext context, Food food) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('${food.name} Video'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(Icons.videocam, size: 64, color: Colors.blue),
//             SizedBox(height: 16),
//             Text('Video tutorial available for ${food.name}'),
//             SizedBox(height: 8),
//             Text('Path: ${food.video}'),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Close'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Add video player implementation here
//             },
//             child: Text('Play Video'),
//           ),
//         ],
//       ),
//    );
//    }
// }

import 'package:flutter/material.dart';
import 'package:food/model/food_model.dart';
import '../data/food_list.dart';
import '../model/food_model.dart';

class AISuggestionPage extends StatefulWidget {
  @override
  _AISuggestionPageState createState() => _AISuggestionPageState();
}

class _AISuggestionPageState extends State<AISuggestionPage> {
  final TextEditingController _ingredientsController = TextEditingController();
  List<Food> _suggestedFoods = [];
  bool _isLoading = false;
  late List<Food> _allFoods;

  @override
  void initState() {
    super.initState();
    _allFoods = getFoodsFromList();
    print('Total foods loaded: ${_allFoods.length}');
    print('Available foods:');
    _allFoods.forEach((food) => print('- ${food.name}'));
  }

  // Improved ingredient matching function
  bool _foodContainsIngredients(Food food, List<String> availableIngredients) {
    if (availableIngredients.isEmpty) return false;
    
    for (String ingredient in availableIngredients) {
      for (String foodIngredient in food.ingredients) {
        if (foodIngredient.toLowerCase().contains(ingredient.toLowerCase())) {
          return true; // Return true if any ingredient matches
        }
      }
    }
    return false;
  }

  // Calculate match score for sorting
  double _calculateMatchScore(Food food, List<String> availableIngredients) {
    if (availableIngredients.isEmpty) return 0.0;
    
    int matchCount = 0;
    for (String ingredient in availableIngredients) {
      for (String foodIngredient in food.ingredients) {
        if (foodIngredient.toLowerCase().contains(ingredient.toLowerCase())) {
          matchCount++;
          break; // Count each available ingredient only once
        }
      }
    }
    
    return matchCount / availableIngredients.length;
  }

  // Improved mood-based suggestion method
  void _getMoodSuggestions() {
    final String input = _ingredientsController.text.toLowerCase();
    print('User mood input: "$input"');
    
    if (input.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your mood or ingredients'))
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _suggestedFoods = [];
    });

    Future.delayed(Duration(seconds: 1), () {
      // Map moods to specific foods in your list
      final Map<String, List<String>> moodToFoodMap = {
        'happy': ['Rasmalai', 'Gulab Jamun', 'Jalebi', 'Kheer', 'Baklava', 'Turkish', 'Lamington'],
        'sad': ['Soup', 'Chai', 'Chocolate', 'Comfort', 'Pudding', 'Custard'],
        'tired': ['Energy', 'Protein', 'Quick', 'Healthy', 'Ragi', 'Noodles'],
        'excited': ['Biryani', 'Chicken', 'Special', 'Festive', 'Celebration', 'Baklava'],
        'stressed': ['Tea', 'Milk', 'Warm', 'Comfort', 'Pudding', 'Custard'],
        'bored': ['New', 'Different', 'Unique', 'Exotic', 'Korean', 'Arabian'],
        'relaxed': ['Fresh', 'Green', 'Light', 'Healthy', 'Salad', 'Jelly'],
        'angry': ['Cold', 'Ice', 'Refreshing', 'Cool', 'Smoothie', 'Jelly'],
        'sick': ['Plain', 'Simple', 'Clear', 'Boiled', 'Soup', 'Light'],
        'celebrating': ['Sweet', 'Special', 'Festive', 'Party', 'Cake', 'Baklava'],
      };

      // Check if input contains mood words
      String detectedMood = '';
      final moodKeywords = ['happy', 'sad', 'tired', 'excited', 'stressed', 
                           'bored', 'relaxed', 'angry', 'sick', 'celebrating',
                           'mood', 'feel', 'feeling'];
      
      for (String mood in moodKeywords) {
        if (input.contains(mood)) {
          detectedMood = mood;
          break;
        }
      }

      // Additional mood detection patterns
      if (detectedMood.isEmpty) {
        if (input.contains('today i am') || input.contains('today my mood')) {
          if (input.contains('not good') || input.contains('bad')) {
            detectedMood = 'sad';
          } else if (input.contains('good') || input.contains('happy')) {
            detectedMood = 'happy';
          } else if (input.contains('tired') || input.contains('exhausted')) {
            detectedMood = 'tired';
          }
        }
      }

      List<Food> suggestions = [];

      if (detectedMood.isNotEmpty) {
        print('Detected mood: $detectedMood');
        
        // Get foods for this mood
        final preferredFoodKeywords = moodToFoodMap[detectedMood] ?? [];
        
        // Find foods that match mood keywords
        suggestions = _allFoods.where((food) {
          // Check if food name contains any mood-related keywords
          for (String keyword in preferredFoodKeywords) {
            if (food.name.toLowerCase().contains(keyword.toLowerCase())) {
              return true;
            }
          }
          
          // Check ingredients
          for (String keyword in preferredFoodKeywords) {
            for (String ingredient in food.ingredients) {
              if (ingredient.toLowerCase().contains(keyword.toLowerCase())) {
                return true;
              }
            }
          }
          
          // Check benefits if available
          if (food.benefits != null) {
            for (String keyword in preferredFoodKeywords) {
              if (food.benefits!.toLowerCase().contains(keyword.toLowerCase())) {
                return true;
              }
            }
          }
          
          return false;
        }).toList();
        
        print('Found ${suggestions.length} mood-based suggestions');
      }

      // If no mood-based suggestions found, fall back to ingredient search
      if (suggestions.isEmpty) {
        print('No mood-based suggestions found, falling back to ingredient search');
        
        final List<String> availableIngredients = input
            .split(',')
            .map((ingredient) => ingredient.trim())
            .where((ingredient) => ingredient.isNotEmpty)
            .toList();

        print('Trying ingredient search: $availableIngredients');

        suggestions = _allFoods.where((food) {
          return _foodContainsIngredients(food, availableIngredients);
        }).toList();

        print('Found ${suggestions.length} ingredient-based suggestions');
        
        // Sort by relevance (more matching ingredients first)
        suggestions.sort((a, b) {
          final double aScore = _calculateMatchScore(a, availableIngredients);
          final double bScore = _calculateMatchScore(b, availableIngredients);
          return bScore.compareTo(aScore);
        });
      }

      setState(() {
        _suggestedFoods = suggestions;
        _isLoading = false;
      });
    });
  }

  void _getSuggestions() {
    final String input = _ingredientsController.text.toLowerCase();
    
    // Check if input looks like a mood description rather than ingredients
    final moodPattern = RegExp(r'\b(happy|sad|tired|excited|stressed|bored|relaxed|angry|sick|celebrating|mood|feel|feeling)\b');
    
    if (moodPattern.hasMatch(input) || 
        input.contains('today i am') || 
        input.contains('today my mood') ||
        input.contains('what can i make')) {
      _getMoodSuggestions();
    } else {
      // Original ingredient-based search
      final String inputText = _ingredientsController.text;
      print('User input: "$inputText"');
      
      if (inputText.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter some ingredients'))
        );
        return;
      }

      setState(() {
        _isLoading = true;
        _suggestedFoods = [];
      });

      Future.delayed(Duration(seconds: 1), () {
        final List<String> availableIngredients = inputText
            .toLowerCase()
            .split(',')
            .map((ingredient) => ingredient.trim())
            .where((ingredient) => ingredient.isNotEmpty)
            .toList();

        print('Parsed ingredients: $availableIngredients');

        // Use the improved ingredient matching
        List<Food> suggestions = _allFoods.where((food) {
          bool matches = _foodContainsIngredients(food, availableIngredients);
          print('Checking ${food.name}: $matches');
          if (matches) {
            print('  Food ingredients: ${food.ingredients}');
            print('  Available ingredients: $availableIngredients');
          }
          return matches;
        }).toList();

        print('Found ${suggestions.length} suggestions');

        // Sort by relevance (more matching ingredients first)
        suggestions.sort((a, b) {
          final double aScore = _calculateMatchScore(a, availableIngredients);
          final double bScore = _calculateMatchScore(b, availableIngredients);
          return bScore.compareTo(aScore);
        });

        setState(() {
          _suggestedFoods = suggestions;
          _isLoading = false;
        });
      });
    }
  }

  // Add these methods to the _AISuggestionPageState class
  void _showRecipeDialog(BuildContext context, Food food) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(food.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Recipe:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(food.recipe),
              SizedBox(height: 16),
              Text('Ingredients:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              ...food.ingredients.map((ingredient) => Text('• $ingredient')).toList(),
              SizedBox(height: 16),
              Text('Calories: ${food.calories}', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showVideoDialog(BuildContext context, Food food) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${food.name} Video'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.videocam, size: 64, color: Colors.blue),
            SizedBox(height: 16),
            Text('Video tutorial available for ${food.name}'),
            SizedBox(height: 8),
            Text('Path: ${food.video}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add video player implementation here
              // You would typically use a video player package like:
              // https://pub.dev/packages/video_player
              // For now, just close the dialog
              Navigator.pop(context);
            },
            child: Text('Play Video'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Food Suggestions'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Ingredients Input
            TextField(
              controller: _ingredientsController,
              decoration: InputDecoration(
                labelText: 'What ingredients do you have? Or how are you feeling?',
                hintText: 'e.g., sago, milk OR today I feel happy',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.kitchen),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _getSuggestions,
                ),
              ),
              onSubmitted: (_) => _getSuggestions(),
            ),
            SizedBox(height: 24),
            
            // Suggest Button
            ElevatedButton(
              onPressed: _getSuggestions,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Find Recipes', style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 24),
            
            // Results Header
            if (_suggestedFoods.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Found ${_suggestedFoods.length} recipe(s)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            
            // Results List
            Expanded(
              child: _suggestedFoods.isEmpty && !_isLoading
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'Enter ingredients you have to find recipes!\nOr tell us how you\'re feeling today!\n\nExamples:\n- sago, milk, sugar\n- today I feel happy\n- I\'m stressed and need comfort food',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: _suggestedFoods.length,
                          itemBuilder: (context, index) {
                            final food = _suggestedFoods[index];
                            return _FoodCard(
                              food: food,
                              onViewRecipe: () => _showRecipeDialog(context, food),
                              onViewVideo: () => _showVideoDialog(context, food),
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

// Food Card Widget (now as a separate class)
class _FoodCard extends StatelessWidget {
  final Food food;
  final VoidCallback onViewRecipe;
  final VoidCallback onViewVideo;

  const _FoodCard({
    required this.food,
    required this.onViewRecipe,
    required this.onViewVideo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Name
            Text(
              food.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            
            // Ingredients
            Text(
              'Ingredients:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 4),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: food.ingredients.map((ingredient) => Chip(
                label: Text(ingredient),
                backgroundColor: Colors.blue[100],
              )).toList(),
            ),
            SizedBox(height: 12),
            
            // Calories
            Text(
              'Calories: ${food.calories}',
              style: TextStyle(color: Colors.orange, fontSize: 14),
            ),
            SizedBox(height: 8),
            
            // Benefits (if available)
            if (food.benefits != null && food.benefits!.isNotEmpty) ...[
              Text(
                'Benefits:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 4),
              Text(
                food.benefits!,
                style: TextStyle(fontSize: 14, color: Colors.green[700]),
              ),
              SizedBox(height: 12),
            ],
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onViewRecipe,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('View Recipe'),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.videocam, color: Colors.blue),
                  onPressed: onViewVideo,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

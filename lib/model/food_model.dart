// import 'package:food/data/food_list.dart';

// class Food {
//   final String name;
//   final String image;
//   final List<String> ingredients;
//   final String video;
//   final String recipe;
//   final String calories;
//   final String? benefits;

//   Food({
//     required this.name,
//     required this.image,
//     required this.ingredients,
//     required this.video,
//     required this.recipe,
//     required this.calories,
//     this.benefits,
//   });

//   // Convert from Map to Food object
//   factory Food.fromMap(Map<String, dynamic> map) {
//     return Food(
//       name: map['name'] ?? '',
//       image: map['image'] ?? '',
//       ingredients: List<String>.from(map['ingredients'] ?? []),
//       video: map['video'] ?? '',
//       recipe: map['recipe'] ?? '',
//       calories: map['calories'] ?? '',
//       benefits: map['benefits'],
//     );
//   }

//   // Check if food contains specific ingredients
//   bool containsIngredients(List<String> availableIngredients) {
//     if (availableIngredients.isEmpty) return true;
    
//     return availableIngredients.every(
//       (ingredient) => ingredients.any(
//         (foodIngredient) => foodIngredient.toLowerCase().contains(ingredient.toLowerCase()),
//       ),
//     );
//   }

//   // Calculate match score based on ingredients
//   double calculateMatchScore(List<String> availableIngredients) {
//     if (availableIngredients.isEmpty) return 1.0;
    
//     final matchingIngredients = ingredients.where((ing) => 
//         availableIngredients.any((ai) => ing.toLowerCase().contains(ai.toLowerCase()))).length;
    
//     return matchingIngredients / availableIngredients.length;
//   }
// }

// // Helper function to convert your foodList to List<Food>
// List<Food> getFoodsFromList() {
//   return foodList.map((map) => Food.fromMap(map)).toList();
// }


// lib/models/food_model.dart
import 'package:food/data/food_list.dart';

class Food {
  final String name;
  final String image;
  final List<String> ingredients;
  final String video;
  final String recipe;
  final String calories;
  final String? benefits;

  Food({
    required this.name,
    required this.image,
    required this.ingredients,
    required this.video,
    required this.recipe,
    required this.calories,
    this.benefits,
  });

  // Convert from Map to Food object
  factory Food.fromMap(Map<String, dynamic> map) {
    // Handle ingredients conversion safely
    List<String> ingredientsList = [];
    if (map['ingredients'] != null) {
      if (map['ingredients'] is List) {
        ingredientsList = List<String>.from(map['ingredients']!);
      }
    }

    return Food(
      name: map['name']?.toString() ?? 'Unknown Food',
      image: map['image']?.toString() ?? '',
      ingredients: ingredientsList,
      video: map['video']?.toString() ?? '',
      recipe: map['recipe']?.toString() ?? 'No recipe available',
      calories: map['calories']?.toString() ?? 'Unknown calories',
      benefits: map['benefits']?.toString(),
    );
  }

  // Check if food contains specific ingredients
  bool containsIngredients(List<String> availableIngredients) {
    if (availableIngredients.isEmpty) return true;
    
    return availableIngredients.every(
      (ingredient) => ingredients.any(
        (foodIngredient) => foodIngredient.toLowerCase().contains(ingredient.toLowerCase()),
      ),
    );
  }

  // Calculate match score based on ingredients
  double calculateMatchScore(List<String> availableIngredients) {
    if (availableIngredients.isEmpty) return 1.0;
    
    final matchingIngredients = ingredients.where((ing) => 
        availableIngredients.any((ai) => ing.toLowerCase().contains(ai.toLowerCase()))).length;
    
    return matchingIngredients / availableIngredients.length;
  }
}

// Helper function to convert your foodList to List<Food>
List<Food> getFoodsFromList() {
  try {
    return foodList.map((map) => Food.fromMap(map)).toList();
  } catch (e) {
    print('Error converting food list: $e');
    return[];
  }
}

// import 'package:flutter/material.dart';
// import 'package:food/screens/about_page.dart';
// import 'package:food/screens/ai_food_suggestion_pages.dart';
// import 'package:food/screens/profile%20page.dart';
// //import package:food/screen/profile_page.dart';
// import 'package:food/screens/suggestion.dart';
// //import 'package:food/screens/share.dart';
// import 'package:food/screens/wishlist_page.dart';
// import '../data/food_list.dart';
// import 'recipe_detail.dart';
// import 'package:food/screens/profile page.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("🍴 Unique Food Recipe App"),
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.deepOrange, Colors.orangeAccent],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               showSearch(context: context, delegate: RecipeSearchDelegate(foodList));
//             },
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             const DrawerHeader(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.orange, Colors.yellow],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: Align(
//                 alignment: Alignment.bottomLeft,
//                 child: Text("🍲 Menu",
//                     style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.category, color: Colors.deepOrange),
//               title: const Text("Profile"),
//               onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage())),
//             ),
//             ListTile(
//               leading: const Icon(Icons.info, color: Colors.green),
//               title: const Text("About Us"),
//               onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutPage())),
//             ),
//             ListTile(
//               leading: const Icon(Icons.favorite, color: Colors.pink),
//               title: const Text("Wishlist"),
//               onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) =>  WishlistPage())),
//             ),
//             ListTile(
//               leading: const Icon(Icons.add_box, color: Color.fromARGB(255, 223, 131, 20)),
//               title: const Text("suggestion box"),
//               onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SuggestionPage())),
//             ),
//           ],
//         ),
//       ),
//       body: Stack(
//         children: [
//           // Existing Grid
//           GridView.builder(
//             padding: const EdgeInsets.all(10),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, childAspectRatio: 0.8, crossAxisSpacing: 10, mainAxisSpacing: 10),
//             itemCount: foodList.length,
//             itemBuilder: (context, index) {
//               final food = foodList[index];
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (_) => RecipeDetailPage(food: food)));
//                 },
//                 child: Card(
//                   elevation: 6,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         // image with fallback
//                         if ((food['image'] ?? '').toString().isNotEmpty)
//                           Image.asset(food['image'], fit: BoxFit.cover)
//                         else
//                           Container(color: Colors.grey[200]),
//                         Container(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [Colors.black.withOpacity(0.5), Colors.transparent],
//                               begin: Alignment.bottomCenter,
//                               end: Alignment.topCenter,
//                             ),
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.bottomLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               children: [
//                                 const Icon(Icons.fastfood, color: Colors.white),
//                                 const SizedBox(width: 5),
//                                 Flexible(
//                                   child: Text(
//                                     food['name'] ?? '',
//                                     style: const TextStyle(
//                                         color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),

//           // AI Suggestion Button (Bottom-right)
//           Positioned(
//             bottom: 16,
//             right: 16,
//             child: FloatingActionButton.extended(
//               onPressed: () {
//              Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => AISuggestionPage()),
//       );
//               },
//               label: const Text("AI Suggest"),
//               icon: const Icon(Icons.lightbulb),
//               backgroundColor: Colors.orange,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class profile {
//   const profile();
// }

// /// Simple search delegate for recipes
// class RecipeSearchDelegate extends SearchDelegate {
//   final List<Map<String, dynamic>> list;
//   RecipeSearchDelegate(this.list);

//   @override
//   List<Widget>? buildActions(BuildContext context) => [
//         IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
//       ];

//   @override
//   Widget? buildLeading(BuildContext context) =>
//       IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, null));

//   @override
//   Widget buildResults(BuildContext context) {
//     final results = list.where((food) => (food['name'] ?? '').toString().toLowerCase().contains(query.toLowerCase())).toList();
//     if (results.isEmpty) return const Center(child: Text("😢 Sorry, recipe not found"));
//     return ListView(
//       children: results.map((food) {
//         return ListTile(
//           leading: (food['image'] ?? '').toString().isNotEmpty
//               ? Image.asset(food['image'], width: 50, height: 50, fit: BoxFit.cover)
//               : const SizedBox(width: 50, height: 50),
//           title: Text(food['name'] ?? ''),
//           subtitle: Text(food['benefits'] ?? ''),
//           onTap: () {
//             close(context, null);
//             Navigator.push(context, MaterialPageRoute(builder: (_) => RecipeDetailPage(food: food)));
//           },
//         );
//       }).toList(),
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) => buildResults(context);
// }



import 'package:flutter/material.dart';
import 'package:food/screens/about_page.dart';
import 'package:food/screens/ai_food_suggestion_pages.dart';
// import 'package:food/screens/profile%20page.dart';
//import package:food/screen/profile_page.dart';
import 'package:food/screens/suggestion.dart';
//import 'package:food/screens/share.dart';
import 'package:food/screens/wishlist_page.dart';
import '../data/food_list.dart';
import 'recipe_detail.dart';
import 'package:food/screens/profilepage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🍴 Unique Food Recipe App"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.orangeAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context, delegate: RecipeSearchDelegate(foodList));
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  ProfilePage()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.yellow],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "🍲 Menu",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.green),
              title: const Text("About Us"),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const AboutPage())),
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.pink),
              title: const Text("Wishlist"),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => WishlistPage())),
            ),
            ListTile(
              leading: const Icon(Icons.add_box,
                  color: Color.fromARGB(255, 223, 131, 20)),
              title: const Text("Suggestion Box"),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SuggestionPage())),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Recipe Grid
          GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: foodList.length,
            itemBuilder: (context, index) {
              final food = foodList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => RecipeDetailPage(food: food)));
                },
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        if ((food['image'] ?? '').toString().isNotEmpty)
                          Image.asset(food['image'], fit: BoxFit.cover)
                        else
                          Container(color: Colors.grey[200]),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.5),
                                Colors.transparent
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.fastfood, color: Colors.white),
                                const SizedBox(width: 5),
                                Flexible(
                                  child: Text(
                                    food['name'] ?? '',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // AI Suggest Button (Bottom-right)
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AISuggestionPage()),
                );
              },
              label: const Text("AI Suggest"),
              icon: const Icon(Icons.lightbulb),
              backgroundColor: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}

/// Simple search delegate
class RecipeSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> list;
  RecipeSearchDelegate(this.list);

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
      ];

  @override
  Widget? buildLeading(BuildContext context) =>
      IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, null));

  @override
  Widget buildResults(BuildContext context) {
    final results = list
        .where((food) => (food['name'] ?? '')
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
    if (results.isEmpty) return const Center(child: Text("😢 Sorry, recipe not found"));
    return ListView(
      children: results.map((food) {
        return ListTile(
          leading: (food['image'] ?? '').toString().isNotEmpty
              ? Image.asset(food['image'], width: 50, height: 50, fit: BoxFit.cover)
              : const SizedBox(width: 50, height: 50),
          title: Text(food['name'] ?? ''),
          subtitle: Text(food['benefits'] ?? ''),
          onTap: () {
            close(context, null);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => RecipeDetailPage(food: food)));
          },
        );
      }).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => buildResults(context);
}

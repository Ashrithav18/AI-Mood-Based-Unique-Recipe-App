// // // // lib/pages/wishlist_page.dart
// // // import 'package:flutter/material.dart';

// // // class WishlistPage extends StatelessWidget {
// // //   const WishlistPage({super.key});
// // //   @override
// // //   Widget build(BuildContext context) => 
// // //   Scaffold(
// // //     appBar: AppBar(
// // //       title: Text("my wishlist"),
// // //       backgroundColor: Colors.orange,
// // //     ),
// // //     body: WishlistPage(
      
// // //     ),
// // //   );
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:food/screens/wishlist_dart.dart';


// // class WishlistPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("My Wishlist")),
// //       body: wishlist.isEmpty
// //           ? const Center(child: Text("No recipes yet"))
// //           : ListView.builder(
// //               itemCount: wishlist.length,
// //               itemBuilder: (context, index) {
// //                 final recipe = wishlist[index];
// //                 return ListTile(
// //                   title: Text(recipe['name']),
// //                   subtitle: Text(recipe['recipe']),
// //                 );
// //               },
// //             ),
// //     );
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:food/screens/recipe_detail.dart';
// // // TODO: Update this import to the correct file containing 'wishlist'

// // class WishlistPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("My Wishlist")),
// //       body: wishlist.isEmpty
// //           ? const Center(child: Text("No recipes yet"))
// //           : ListView.builder(
// //               itemCount: wishlist.length,
// //               itemBuilder: (context, index) {
// //                 final recipe = wishlist[index];
// //                 return ListTile(
// //                   title: Text(recipe['name'] ?? 'No name'),
// //                   subtitle: Text(recipe['recipe'] ?? 'No recipe'),
// //                 );
// //               },
// //             ),
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:food/screens/recipe_detail.dart';
// import 'package:food/screens/wishlist.dart'; // Import the shared wishlist

// class WishlistPage extends StatelessWidget {
//   get wishlist => null;

//   @override
//   Widget build(BuildContext context) {
//     // Assuming 'wishlist' is imported from 'package:food/screens/wishlist.dart'
//     return Scaffold(
//       appBar: AppBar(title: const Text("My Wishlist")),
//       body: wishlist.isEmpty
//           ? const Center(child: Text("No recipes yet"))
//           : ListView.builder(
//               itemCount: wishlist.length,
//               itemBuilder: (context, index) {
//                 final recipe = wishlist[index];
//                 return ListTile(
//                   title: Text(recipe['name'] ?? 'No name'),
//                   subtitle: Text(recipe['recipe'] ?? 'No recipe'),
//                 );
//               },
//             ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:food/screens/recipe_detail.dart';
import 'package:food/screens/wishlist.dart' hide wishlist; // Import the shared wishlist

class WishlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Wishlist")),
      body: wishlist.isEmpty
          ? const Center(child: Text("No recipes yet"))
          : ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final recipe = wishlist[index];
                return ListTile(
                  title: Text(recipe['name'] ?? 'No name'),
                  subtitle: Text(recipe['recipe'] ?? 'No recipe'),
                );
              },
            ),
    );
  }
}

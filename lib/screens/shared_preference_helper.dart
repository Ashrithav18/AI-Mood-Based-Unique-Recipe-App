// TODO Implement this library
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  // ✅ Profile image methods
  Future<void> saveUserImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("profileImage", path);
  }

  Future<String?> getUserImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("profileImage");
  }

  // ✅ Cover image methods
  Future<void> saveUserCoverImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("coverImage", path);
  }

  Future<String?> getUserCoverImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("coverImage");
}
}

// class SharedPreferenceHelper {
//   final String _keyUserImage = "USER_IMAGE";
//   final String _keyUserCoverImage = "USER_COVER_IMAGE";
//   final String _keyUserName = "USER_NAME"; // ✅ name key

//   Future<void> saveUserImage(String path) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_keyUserImage, path);
//   }

//   Future<String?> getUserImage() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyUserImage);
//   }

//   Future<void> saveUserCoverImage(String path) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_keyUserCoverImage, path);
//   }

//   Future<String?> getUserCoverImage() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyUserCoverImage);
//   }

//   // ✅ Save Name
//   Future<void> saveUserName(String name) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_keyUserName, name);
//   }

//   // ✅ Get Name
//   Future<String?> getUserName() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyUserName);
//     }
// }

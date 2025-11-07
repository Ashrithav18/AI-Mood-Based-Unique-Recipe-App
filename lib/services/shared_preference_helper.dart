import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const String _userImageKey = 'user_image';

  Future<void> saveUserImage(String imagePath) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userImageKey, imagePath);
      print("Image saved to SharedPreferences: $imagePath");
    } catch (e) {
      print('Error saving user image: $e');
    }
  }

  Future<String?> getUserImage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final imagePath = prefs.getString(_userImageKey);
      print("Retrieved image from SharedPreferences: $imagePath");
      return imagePath;
    } catch (e) {
      print('Error getting user image: $e');
      return null;
    }
  }

  Future<void> removeUserImage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userImageKey);
      print("Image removed from SharedPreferences");
    } catch (e) {
      print('Error removing user image: $e');
    }
  }
}
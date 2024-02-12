import 'package:dicoding_moments/model/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final String profileKey = "profile";

  Future<bool> isLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    final state = preferences.getString(profileKey);
    if (state == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> saveProfile(ProfileModel profile) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(profileKey, profile.toStringJson());
  }

  Future<bool> deleteProfile() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.remove(profileKey);
  }

  Future<ProfileModel?> getProfile() async {
    final preferences = await SharedPreferences.getInstance();
    final jsonString = preferences.getString(profileKey) ?? "";
    ProfileModel? profile;
    try {
      profile = ProfileModel.fromStringJson(jsonString);
    } catch (e) {
      profile = null;
    }
    return profile;
  }
}

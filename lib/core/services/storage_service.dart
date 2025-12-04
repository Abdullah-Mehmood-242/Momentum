import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';

/// Service for persisting data locally using SharedPreferences
class StorageService {
  static const String _currentUserKey = 'current_user';
  static const String _usersKey = 'registered_users';
  static const String _progressKey = 'progress_data';
  static const String _personalBestsKey = 'personal_bests';
  static const String _notificationsEnabledKey = 'notifications_enabled';

  final SharedPreferences _prefs;

  StorageService(this._prefs);

  // ==================== User Management ====================

  /// Save the current logged-in user
  Future<bool> saveCurrentUser(UserModel user) async {
    final json = jsonEncode(user.toJson());
    return await _prefs.setString(_currentUserKey, json);
  }

  /// Get the current logged-in user
  UserModel? getCurrentUser() {
    final json = _prefs.getString(_currentUserKey);
    if (json == null) return null;
    return UserModel.fromJson(jsonDecode(json));
  }

  /// Clear the current user (logout)
  Future<bool> clearCurrentUser() async {
    return await _prefs.remove(_currentUserKey);
  }

  /// Register a new user
  Future<bool> registerUser(UserModel user) async {
    final users = getRegisteredUsers();
    
    // Check if email already exists
    if (users.any((u) => u.email.toLowerCase() == user.email.toLowerCase())) {
      return false;
    }
    
    users.add(user);
    final jsonList = users.map((u) => u.toJson()).toList();
    return await _prefs.setString(_usersKey, jsonEncode(jsonList));
  }

  /// Get all registered users
  List<UserModel> getRegisteredUsers() {
    final json = _prefs.getString(_usersKey);
    if (json == null) return [];
    
    final List<dynamic> jsonList = jsonDecode(json);
    return jsonList.map((j) => UserModel.fromJson(j)).toList();
  }

  /// Find a user by email and password
  UserModel? findUser(String email, String password) {
    final users = getRegisteredUsers();
    try {
      return users.firstWhere(
        (u) => u.email.toLowerCase() == email.toLowerCase() && u.password == password,
      );
    } catch (_) {
      return null;
    }
  }

  /// Update a registered user's data
  Future<bool> updateUser(UserModel updatedUser) async {
    final users = getRegisteredUsers();
    final index = users.indexWhere((u) => u.id == updatedUser.id);
    
    if (index == -1) return false;
    
    users[index] = updatedUser;
    final jsonList = users.map((u) => u.toJson()).toList();
    
    // Also update current user if it's the same user
    final currentUser = getCurrentUser();
    if (currentUser?.id == updatedUser.id) {
      await saveCurrentUser(updatedUser);
    }
    
    return await _prefs.setString(_usersKey, jsonEncode(jsonList));
  }

  // ==================== Progress Tracking ====================

  /// Save progress data
  Future<bool> saveProgressData(List<DailyProgressModel> progressList) async {
    final jsonList = progressList.map((p) => p.toJson()).toList();
    return await _prefs.setString(_progressKey, jsonEncode(jsonList));
  }

  /// Get progress data
  List<DailyProgressModel> getProgressData() {
    final json = _prefs.getString(_progressKey);
    if (json == null) return [];
    
    final List<dynamic> jsonList = jsonDecode(json);
    return jsonList.map((j) => DailyProgressModel.fromJson(j)).toList();
  }

  /// Get today's progress
  DailyProgressModel? getTodayProgress() {
    final progressList = getProgressData();
    final today = DateTime.now();
    
    try {
      return progressList.firstWhere((p) => 
        p.date.year == today.year && 
        p.date.month == today.month && 
        p.date.day == today.day
      );
    } catch (_) {
      return null;
    }
  }

  /// Update or create today's progress
  Future<bool> updateTodayProgress(DailyProgressModel progress) async {
    final progressList = getProgressData();
    final today = DateTime.now();
    
    final index = progressList.indexWhere((p) => 
      p.date.year == today.year && 
      p.date.month == today.month && 
      p.date.day == today.day
    );
    
    if (index >= 0) {
      progressList[index] = progress;
    } else {
      progressList.add(progress);
    }
    
    return await saveProgressData(progressList);
  }

  // ==================== Personal Bests ====================

  /// Save personal bests
  Future<bool> savePersonalBests(List<PersonalBest> bests) async {
    final jsonList = bests.map((b) => b.toJson()).toList();
    return await _prefs.setString(_personalBestsKey, jsonEncode(jsonList));
  }

  /// Get personal bests
  List<PersonalBest> getPersonalBests() {
    final json = _prefs.getString(_personalBestsKey);
    if (json == null) return [];
    
    final List<dynamic> jsonList = jsonDecode(json);
    return jsonList.map((j) => PersonalBest.fromJson(j)).toList();
  }

  // ==================== Settings ====================

  /// Get notifications enabled setting
  bool getNotificationsEnabled() {
    return _prefs.getBool(_notificationsEnabledKey) ?? true;
  }

  /// Set notifications enabled setting
  Future<bool> setNotificationsEnabled(bool enabled) async {
    return await _prefs.setBool(_notificationsEnabledKey, enabled);
  }

  /// Clear all data (for testing/reset)
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}

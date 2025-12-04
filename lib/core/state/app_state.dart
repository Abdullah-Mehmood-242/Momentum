import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/models.dart';
import '../services/storage_service.dart';
import '../services/auth_service.dart';
import '../data/workout_data.dart';

/// Application state management using InheritedWidget pattern
class AppState extends ChangeNotifier {
  final StorageService _storage;
  final AuthService _authService;

  UserModel? _localUserData;
  List<WorkoutModel> _workouts = [];
  List<DailyProgressModel> _progressHistory = [];
  List<PersonalBest> _personalBests = [];
  bool _notificationsEnabled = true;
  bool _isInitialized = false;

  AppState(this._storage, this._authService);

  // ==================== Getters ====================

  AuthService get authService => _authService;
  
  /// Get Firebase user
  User? get firebaseUser => _authService.currentUser;
  
  /// Check if logged in via Firebase
  bool get isLoggedIn => _authService.isLoggedIn;
  
  /// Get user display name
  String get userName => firebaseUser?.displayName ?? _localUserData?.name ?? 'User';
  
  /// Get user email
  String get userEmail => firebaseUser?.email ?? _localUserData?.email ?? '';

  /// Get local user data for additional profile info
  UserModel? get localUserData => _localUserData;
  
  List<WorkoutModel> get workouts => _workouts;
  List<DailyProgressModel> get progressHistory => _progressHistory;
  List<PersonalBest> get personalBests => _personalBests;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get isInitialized => _isInitialized;

  DailyProgressModel get todayProgress {
    final today = DateTime.now();
    try {
      return _progressHistory.firstWhere((p) =>
          p.date.year == today.year &&
          p.date.month == today.month &&
          p.date.day == today.day);
    } catch (_) {
      return DailyProgressModel(date: today);
    }
  }

  /// Calculate activity percentage for today (based on 60 min goal)
  double get todayActivityPercent {
    const goalMinutes = 60;
    return (todayProgress.activeMinutes / goalMinutes).clamp(0.0, 1.0);
  }

  // ==================== Initialization ====================

  /// Initialize app state from storage
  Future<void> initialize() async {
    if (_isInitialized) return;

    // Load local user data from storage
    _localUserData = _storage.getCurrentUser();

    // Load workout library
    _workouts = WorkoutData.getWorkouts();

    // Load progress history
    _progressHistory = _storage.getProgressData();
    if (_progressHistory.isEmpty) {
      // Initialize empty progress for new user
      _progressHistory = WorkoutData.getInitialProgressData();
      await _storage.saveProgressData(_progressHistory);
    }

    // Load personal bests
    _personalBests = _storage.getPersonalBests();
    if (_personalBests.isEmpty) {
      _personalBests = WorkoutData.getDefaultPersonalBests();
      await _storage.savePersonalBests(_personalBests);
    }

    // Load settings
    _notificationsEnabled = _storage.getNotificationsEnabled();

    _isInitialized = true;
    notifyListeners();
  }

  // ==================== Auth Methods ====================

  /// Register with Firebase
  Future<AuthResult> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final result = await _authService.register(
      email: email,
      password: password,
      displayName: username,
    );

    if (result.success && result.user != null) {
      // Save local user data for additional profile info
      _localUserData = UserModel(
        id: result.user!.uid,
        username: username,
        email: email,
        password: '', // Don't store password locally
        name: username,
      );
      await _storage.saveCurrentUser(_localUserData!);
      await _storage.registerUser(_localUserData!);
      notifyListeners();
    }

    return result;
  }

  /// Login with Firebase
  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    final result = await _authService.login(
      email: email,
      password: password,
    );

    if (result.success && result.user != null) {
      // Load or create local user data
      _localUserData = _storage.getCurrentUser();
      if (_localUserData == null || _localUserData!.id != result.user!.uid) {
        _localUserData = UserModel(
          id: result.user!.uid,
          username: result.user!.displayName ?? '',
          email: result.user!.email ?? email,
          password: '',
          name: result.user!.displayName ?? '',
        );
        await _storage.saveCurrentUser(_localUserData!);
      }
      notifyListeners();
    }

    return result;
  }

  /// Send password reset email
  Future<AuthResult> sendPasswordResetEmail(String email) async {
    return await _authService.sendPasswordResetEmail(email);
  }

  /// Logout
  Future<void> logout() async {
    await _authService.logout();
    _localUserData = null;
    await _storage.clearCurrentUser();
    notifyListeners();
  }

  // ==================== Profile Methods ====================

  /// Update user profile
  Future<bool> updateProfile({
    String? name,
    String? email,
    double? weight,
    double? height,
    int? age,
    DateTime? dateOfBirth,
    bool? useMetricUnits,
  }) async {
    // Update Firebase display name if changed
    if (name != null && name != firebaseUser?.displayName) {
      await _authService.updateProfile(displayName: name);
    }

    // Update local data
    if (_localUserData != null) {
      _localUserData = _localUserData!.copyWith(
        name: name,
        email: email,
        weight: weight,
        height: height,
        age: age,
        dateOfBirth: dateOfBirth,
        useMetricUnits: useMetricUnits,
      );

      final success = await _storage.updateUser(_localUserData!);
      if (success) {
        notifyListeners();
      }
      return success;
    }
    return false;
  }

  // ==================== Workout Methods ====================

  /// Get workout by ID
  WorkoutModel? getWorkoutById(String id) {
    try {
      return _workouts.firstWhere((w) => w.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Search workouts by title
  List<WorkoutModel> searchWorkouts(String query) {
    if (query.isEmpty) return _workouts;
    return _workouts
        .where((w) => w.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  /// Complete a workout and update progress
  Future<void> completeWorkout(WorkoutModel workout, int durationMinutes) async {
    final today = DateTime.now();
    
    // Get or create today's progress
    DailyProgressModel progress = todayProgress;
    
    // Update progress
    progress = progress.copyWith(
      date: today,
      caloriesBurnt: progress.caloriesBurnt + (workout.caloriesPerMinute * durationMinutes),
      activeMinutes: progress.activeMinutes + durationMinutes,
      workoutsCompleted: progress.workoutsCompleted + 1,
      completedWorkoutIds: [...progress.completedWorkoutIds, workout.id],
    );

    // Update in list
    final index = _progressHistory.indexWhere((p) =>
        p.date.year == today.year &&
        p.date.month == today.month &&
        p.date.day == today.day);

    if (index >= 0) {
      _progressHistory[index] = progress;
    } else {
      _progressHistory.add(progress);
    }

    // Save to storage
    await _storage.saveProgressData(_progressHistory);
    notifyListeners();
  }

  // ==================== Settings Methods ====================

  /// Toggle notifications
  Future<void> setNotificationsEnabled(bool enabled) async {
    _notificationsEnabled = enabled;
    await _storage.setNotificationsEnabled(enabled);
    notifyListeners();
  }

  // ==================== Progress Calculation ====================

  /// Get progress data for a specific time period
  List<DailyProgressModel> getProgressForPeriod(String period) {
    final now = DateTime.now();
    DateTime startDate;

    switch (period) {
      case 'Week':
        startDate = now.subtract(const Duration(days: 7));
        break;
      case 'Month':
        startDate = DateTime(now.year, now.month - 1, now.day);
        break;
      case 'Year':
        startDate = DateTime(now.year - 1, now.month, now.day);
        break;
      default:
        startDate = now.subtract(const Duration(days: 7));
    }

    return _progressHistory
        .where((p) => p.date.isAfter(startDate))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  /// Calculate total workouts this month
  int get workoutsThisMonth {
    final now = DateTime.now();
    return _progressHistory
        .where((p) => p.date.year == now.year && p.date.month == now.month)
        .fold(0, (sum, p) => sum + p.workoutsCompleted);
  }

  /// Calculate total active time this month
  Duration get totalActiveTimeThisMonth {
    final now = DateTime.now();
    final totalMinutes = _progressHistory
        .where((p) => p.date.year == now.year && p.date.month == now.month)
        .fold(0, (sum, p) => sum + p.activeMinutes);
    return Duration(minutes: totalMinutes);
  }
}

/// Provider widget for AppState
class AppStateProvider extends InheritedNotifier<AppState> {
  const AppStateProvider({
    super.key,
    required AppState appState,
    required super.child,
  }) : super(notifier: appState);

  static AppState of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<AppStateProvider>();
    assert(provider != null, 'No AppStateProvider found in context');
    return provider!.notifier!;
  }

  static AppState? maybeOf(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<AppStateProvider>();
    return provider?.notifier;
  }
}

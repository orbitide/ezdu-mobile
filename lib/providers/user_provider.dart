import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/data/repositories/user_progress_repository.dart';
import 'package:ezdu/data/repositories/user_repository.dart';
import 'package:ezdu/services/user_onboarding_service.dart';
import 'package:flutter_riverpod/legacy.dart';

class UserState {
  final int streak;
  final int totalXp;
  final int weekXp;
  final int coin;
  final bool isPremium;
  final String? error;

  final int classId;
  final String? className;
  final int? groupId;
  final String? groupName;

  UserState({
    required this.streak,
    required this.totalXp,
    required this.weekXp,
    required this.coin,
    required this.isPremium,
    required this.error,
    required this.classId,
    required this.className,
    required this.groupId,
    required this.groupName,
  });

  const UserState.initial()
    : streak = 0,
      totalXp = 0,
      weekXp = 0,
      coin = 0,
      isPremium = false,
      error = null,
      classId = 0,
      className = null,
      groupId = 0,
      groupName = null;

  UserState copyWithError(String errorMsg) {
    return UserState(
      streak: 0,
      totalXp: 0,
      weekXp: 0,
      coin: 0,
      isPremium: false,
      error: errorMsg,
      classId: 0,
      className: '',
      groupId: null,
      groupName: '',
    );
  }

  UserState copyWith({
    int? streak,
    int? totalXp,
    int? weekXp,
    int? coin,
    bool? isPremium,
    String? error,
    int? classId,
    String? className,
    int? groupId,
    String? groupName,
  }) {
    return UserState(
      streak: streak ?? this.streak,
      totalXp: totalXp ?? this.totalXp,
      weekXp: weekXp ?? this.weekXp,
      coin: coin ?? this.coin,
      isPremium: isPremium ?? this.isPremium,
      error: error ?? this.error,
      classId: classId ?? this.classId,
      className: className ?? this.className,
      groupId: groupId ?? this.groupId,
      groupName: groupName ?? this.groupName,
    );
  }
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier(this._userRepository, this._progressRepository)
    : super(const UserState.initial());

  final UserRepository _userRepository;
  final UserProgressRepository _progressRepository;

  Future<void> init() async {
    final result = await _progressRepository.getMyProgress();

    if (result.success && result.data != null) {
      state = state.copyWith(
        streak: result.data!.streakCount,
        totalXp: result.data!.totalXp,
        coin: result.data!.coin,
        weekXp: result.data!.weekXp,
      );
    } else {
      state = state.copyWithError(result.message ?? "Failed to load progress");
    }

    await getConfig();
  }

  Future<void> getConfig() async {
    final result = await _userRepository.getConfig();

    if (result.success && result.data != null) {
      state = state.copyWith(
        classId: result.data!.classId,
        className: result.data!.className,
        groupId: result.data!.groupId,
        groupName: result.data!.groupName,
      );

      if (result.data!.classId > 0) {
        UserOnboardingService.saveClassId(state.classId);
        UserOnboardingService.saveClass(state.className!);
        if (state.groupId != null) {
          UserOnboardingService.saveGroupId(state.groupId!);
          UserOnboardingService.saveGroup(state.groupName!);
        }
      }
    } else {
      state = state.copyWithError(result.message ?? "Failed to load data");
    }
  }

  Future<void> saveUserConfig({required int classId, int? groupId}) async{
    final result = await _userRepository.saveUserConfig(classId, groupId);

    if (result.success && result.data != null) {
      state = state.copyWith(
        classId: result.data!.classId,
        className: result.data!.className,
        groupId: result.data!.groupId,
        groupName: result.data!.groupName,
      );

      if (result.data!.classId > 0) {
        UserOnboardingService.saveClassId(state.classId);
        UserOnboardingService.saveClass(state.className!);
        if (state.groupId != null) {
          UserOnboardingService.saveGroupId(state.groupId!);
          UserOnboardingService.saveGroup(state.groupName!);
        }
      }
    } else {
      state = state.copyWithError(result.message ?? "Failed to save data");
    }
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier(sl(), sl());
});

// final userInitProvider = FutureProvider<void>((ref) async {
//   await ref.read(userProvider.notifier).init();
// });

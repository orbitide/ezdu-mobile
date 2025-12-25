import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/data/models/class_model.dart';
import 'package:ezdu/data/models/group_model.dart';
import 'package:ezdu/data/repositories/classRepository.dart';
import 'package:ezdu/providers/user_provider.dart';
import 'package:ezdu/services/user_onboarding_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class OnboardingState {
  final bool isLoading;
  final int? segment;
  final int? classId;
  final String? className;
  final int? groupId;
  final String? groupName;
  final List<ClassModel> classList;
  final List<GroupModel> groupList;
  final String? error;

  OnboardingState({
    required this.isLoading,
    required this.segment,
    required this.classId,
    required this.className,
    required this.groupId,
    required this.groupName,
    required this.classList,
    required this.groupList,
    required this.error,
  });

  const OnboardingState.initial()
    : isLoading = false,
      segment = null,
      classId = null,
      className = null,
      groupId = null,
      groupName = null,
      classList = const [],
      groupList = const [],
      error = null;

  OnboardingState copyWithLoading() {
    return OnboardingState(
      isLoading: true,
      segment: null,
      classId: null,
      className: null,
      groupId: null,
      groupName: null,
      classList: const [],
      groupList: const [],
      error: null,
    );
  }

  OnboardingState copyWithError(String errorMsg) {
    return OnboardingState(
      isLoading: false,
      segment: null,
      classId: null,
      className: null,
      groupId: null,
      groupName: null,
      classList: const [],
      groupList: const [],
      error: errorMsg,
    );
  }

  OnboardingState copyWith({
    bool? isLoading,
    int? segment,
    int? classId,
    String? className,
    List<ClassModel>? classList,
    List<GroupModel>? groupList,
    String? error,
    int? groupId,
    String? groupName,
  }) {
    return OnboardingState(
      isLoading: isLoading ?? this.isLoading,
      segment: segment ?? this.segment,
      classId: classId ?? this.classId,
      className: className ?? this.className,
      classList: classList ?? this.classList,
      groupId: groupId ?? this.groupId,
      groupName: groupName ?? this.groupName,
      groupList: groupList ?? this.groupList,
      error: error ?? this.error,
    );
  }
}

class OnboardingSelectionNotifier extends StateNotifier<OnboardingState> {
  OnboardingSelectionNotifier(this._classRepository, this._ref)
    : super(const OnboardingState.initial());

  final ClassRepository _classRepository;
  final Ref _ref;

  void updateSegment(int segment) async {
    state = state.copyWithLoading();

    final response = await _classRepository.getOnboardingClassList(segment);

    if (response.success) {
      final classList = response.data!.items;

      state = state.copyWith(
        isLoading: false,
        segment: segment,
        classList: classList,
        classId: null,
        className: null,
        groupList: [],
        groupId: null,
        groupName: null,
        error: null,
      );

      // UserOnboardingService.saveSegment(segment);
    } else {
      state = state.copyWithError(response.message ?? "Failed to fetch data");
    }
  }

  Future<void> updateClass(int classId) async {
    state = state.copyWith(isLoading: true);

    final response = await _classRepository.getGroupList(classId);
    if (response.success) {
      final groupList = response.data!.items;

      state = state.copyWith(
        isLoading: state.isLoading,
        segment: state.segment,
        classList: state.classList,
        classId: state.classId,
        className: state.className,
        groupId: null,
        groupName: null,
        groupList: groupList,
      );
    } else {
      state = state.copyWith(isLoading: false, groupList: []);
    }

    var selectedClassName = state.classList
        .firstWhere((x) => x.id == classId)
        .name;

    state = state.copyWith(
      isLoading: false,
      classId: classId,
      className: selectedClassName,
      groupId: null,
      groupName: null,
    );

    // _logState('Class updated to: $selectedClassName');
  }

  void updateGroup(int? groupId) {
    var selectedGroupName = state.groupList
        .firstWhere((x) => x.id == groupId)
        .name;
    state = state.copyWith(
      isLoading: false,
      groupId: groupId,
      groupName: selectedGroupName,
    );

    // _logState('Group updated to: $group');
  }

  Future<void> finalizeOnboarding() async {
    // state = state.copyWith(isCompleted: true);

    UserOnboardingService.saveSegment(state.segment!);
    UserOnboardingService.saveClassId(state.classId!);
    UserOnboardingService.saveClass(state.className!);
    if (state.groupId != null) {
      UserOnboardingService.saveGroupId(state.groupId!);
      UserOnboardingService.saveGroup(state.groupName!);
    }

    // _logState('Onboarding Finalized!');

    await _ref
        .read(userProvider.notifier)
        .saveUserConfig(classId: state.classId!, groupId: state.groupId);
  }

  // void _logState(String action) {
  //   print('--- onboarding log ---');
  //   print(action);
  //   print(
  //     'segment: ${state.segment}, classId: ${state.classId}, className: ${state.className}, groupId: ${state.groupId}',
  //   );
  // }

  Future<void> restoreSession() async {
    final segment = await UserOnboardingService.getSegment();
    final classId = await UserOnboardingService.getClassId();
    final className = await UserOnboardingService.getClass();
    final groupId = await UserOnboardingService.getGroupId();
    final groupName = await UserOnboardingService.getGroup();

    if (segment > 0 && classId != null && classId > 0) {
      state = state.copyWith(
        isLoading: false,
        segment: segment,
        classId: classId,
        className: className,
        groupId: groupId,
        groupName: groupName,
      );
    }
  }
}

final onboardingSelectionProvider =
    StateNotifierProvider<OnboardingSelectionNotifier, OnboardingState>((ref) {
      return OnboardingSelectionNotifier(sl<ClassRepository>(), ref);
    });

final onboardingInitProvider = FutureProvider<void>((ref) async {
  await ref.read(onboardingSelectionProvider.notifier).restoreSession();
});

// final onboardingDialogShownProvider = StateProvider<bool>((ref) => false);

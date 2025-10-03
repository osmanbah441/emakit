// FILE: complete_profile_screen.dart

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:domain_models/domain_models.dart';

part 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit() : super(const CompleteProfileState()) {
    _loadCurrentUser();
  }

  final _userRepository = UserRepository.instance;

  void _loadCurrentUser() {
    final currentUser = _userRepository.currentUser;
    emit(state.copyWith(currentUser: currentUser));
  }

  Future<void> submitProfile({
    String? formFullName,
    required DateTime dateOfBirth,
  }) async {
    emit(state.copyWith(status: CompleteProfileStatus.loading));
    try {
      await Future.delayed(Duration(seconds: 2));
      final currentUser = state.currentUser;
      if (currentUser == null) throw Exception('User not authenticated');

      final finalFullName = formFullName ?? currentUser.displayName;
      if (finalFullName == null || finalFullName.isEmpty) {
        throw Exception('Full name is required.');
      }

      await _userRepository.updateDisplayName(
        username: finalFullName,
        // dateOfBirth: dateOfBirth,
      );

      emit(state.copyWith(status: CompleteProfileStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: CompleteProfileStatus.error,
          errorMessage: 'Failed to update profile. Please try again.',
        ),
      );
    }
  }
}

import 'dart:async';
import 'package:domain_models/domain_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final UserRepository _userRepository;
  late final StreamSubscription<PhoneAuthStatus> _phoneAuthStatusSubscription;

  SignInCubit(this._userRepository) : super(SignInState()) {
    _phoneAuthStatusSubscription = _userRepository.onPhoneAuthStatusChanged
        .listen((status) {
          return switch (status) {
            PhoneAuthCodeSent() => emit(
              state.copyWith(status: SignInSubmissionStatus.codeSent),
            ),

            PhoneAuthSuccess() => _checkUsernameAndEmitState(),
            PhoneAuthAutoVerified() => _checkUsernameAndEmitState(),

            PhoneAuthFailed(error: final error) => emit(
              state.copyWith(
                status: SignInSubmissionStatus.failure,
                error: error.message,
              ),
            ),
          };
        });
  }

  void _checkUsernameAndEmitState() async {
    final user = _userRepository.currentUser;
    if (user != null && (user.displayName?.isEmpty ?? true)) {
      emit(state.copyWith(status: SignInSubmissionStatus.usernameRequired));
    } else {
      emit(state.copyWith(status: SignInSubmissionStatus.success));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(status: SignInSubmissionStatus.loading));
    try {
      await _userRepository.signInWithGoogle();
      _checkUsernameAndEmitState();
    } on AuthException catch (e) {
      emit(
        state.copyWith(
          status: SignInSubmissionStatus.failure,
          error: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SignInSubmissionStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> sendOtp(String phoneNumber) async {
    emit(
      state.copyWith(
        status: SignInSubmissionStatus.loading,
        phoneNumber: phoneNumber,
      ),
    );
    try {
      await _userRepository.signInWithPhoneNumber(phoneNumber: phoneNumber);
    } on AuthException catch (e) {
      emit(
        state.copyWith(
          status: SignInSubmissionStatus.failure,
          error: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SignInSubmissionStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> verifyOtp(String otpCode) async {
    emit(state.copyWith(status: SignInSubmissionStatus.loading));
    try {
      await _userRepository.verifyPhoneNumberOtp(otpCode: otpCode);
    } on AuthException catch (e) {
      emit(
        state.copyWith(
          status: SignInSubmissionStatus.failure,
          error: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SignInSubmissionStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> setUsername(String username) async {
    emit(state.copyWith(status: SignInSubmissionStatus.loading));
    try {
      await _userRepository.updateDisplayName(username: username);
      emit(state.copyWith(status: SignInSubmissionStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: SignInSubmissionStatus.failure,
          error: "Could not save username. Please try again.",
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _phoneAuthStatusSubscription.cancel();
    return super.close();
  }
}

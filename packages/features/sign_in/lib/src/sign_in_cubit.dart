import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:user_repository/user_repository.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({UserRepository? userRepository})
    : _userRepository = userRepository ?? UserRepository.instance,
      super(const SignInState());

  final UserRepository _userRepository;

  Future<void> continueWithMobile(String phoneNumber) async {
    emit(
      state.copyWith(
        status: SignInSubmissionStatus.inProgress,
        method: SignInMethod.phone,
      ),
    );
    try {
      await _userRepository.signInwithPhoneNumberWeb(phoneNumber);
      emit(state.copyWith(status: SignInSubmissionStatus.awaitingOtp));
    } on InvalidPhoneNumberException {
      emit(
        state.copyWith(
          status: SignInSubmissionStatus.invalidPhoneNumber,
          method: SignInMethod.none,
        ),
      );
    } on NetworkErrorException {
      emit(
        state.copyWith(
          status: SignInSubmissionStatus.networkError,
          method: SignInMethod.none,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: SignInSubmissionStatus.unknownError,
          method: SignInMethod.none,
        ),
      );
    }
  }

  Future<void> resendOtp(String phoneNumber) async {
    // No need to show loading, just attempt to resend in the background.
    try {
      await _userRepository.signInwithPhoneNumberWeb(phoneNumber);
    } catch (_) {
      // Optionally handle resend failure, e.g., with a snackbar.
      // For now, we fail silently and the user can try again.
    }
  }

  Future<void> verifyOtp(String otp) async {
    emit(
      state.copyWith(
        status: SignInSubmissionStatus.inProgress,
        method: SignInMethod.phone,
      ),
    );
    try {
      await _userRepository.verifyOtpWeb(otp);
      emit(
        state.copyWith(
          status: SignInSubmissionStatus.success,
          method: SignInMethod.none,
        ),
      );
    } on InvalidOtpException {
      emit(
        state.copyWith(
          status: SignInSubmissionStatus.failedOtpVerification,
          method: SignInMethod.none,
        ),
      );
    } on SessionExpiredException {
      emit(
        state.copyWith(
          status: SignInSubmissionStatus.failedOtpVerification,
          method: SignInMethod.none,
        ),
      );
    } on NetworkErrorException {
      emit(
        state.copyWith(
          status: SignInSubmissionStatus.networkError,
          method: SignInMethod.none,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: SignInSubmissionStatus.unknownError,
          method: SignInMethod.none,
        ),
      );
    }
  }

  Future<void> continueWithGoogle() async {
    emit(
      state.copyWith(
        status: SignInSubmissionStatus.inProgress,
        method: SignInMethod.google,
      ),
    );
    try {
      kIsWeb
          ? await _userRepository.signInWithGoogleWeb()
          : await _userRepository.signInWithGoogleMobile();
      emit(
        state.copyWith(
          status: SignInSubmissionStatus.success,
          method: SignInMethod.none,
        ),
      );
    } on GoogleSignInAbortedException {
      emit(
        state.copyWith(
          status: SignInSubmissionStatus.googleSignInError,
          method: SignInMethod.none,
        ),
      );
    } on NetworkErrorException {
      emit(
        state.copyWith(
          status: SignInSubmissionStatus.networkError,
          method: SignInMethod.none,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SignInSubmissionStatus.unknownError,
          method: SignInMethod.none,
        ),
      );
    }
  }
}

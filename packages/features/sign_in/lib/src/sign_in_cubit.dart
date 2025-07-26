import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:api/api.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final _userRepository = Api.instance.userRepository;

  SignInCubit() : super(const SignInState());

  void continueWithMobile(String phoneNumber) async {
    emit(state.copyWith(status: SignInSubmissionStatus.inprogress));
    try {
      await _userRepository.signInwithPhoneNumberWeb(phoneNumber);
      emit(state.copyWith(status: SignInSubmissionStatus.awaitingOtp));
    } catch (_) {
      emit(state.copyWith(status: SignInSubmissionStatus.networkError));
    }
  }

  void verifyOtp(String otp) async {
    emit(state.copyWith(status: SignInSubmissionStatus.inprogress));
    try {
      final isNewUser = await _userRepository.verifyOtp(otp);

      emit(
        state.copyWith(
          status: isNewUser
              ? SignInSubmissionStatus.newUser
              : SignInSubmissionStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: SignInSubmissionStatus.failedOtpVerification),
      );
    }
  }

  void continueWithGoogle() async {
    emit(state.copyWith(status: SignInSubmissionStatus.inprogress));
    try {
      await _userRepository.signInWithGoogleWeb();
      emit(state.copyWith(status: SignInSubmissionStatus.success));
    } catch (_) {
      emit(state.copyWith(status: SignInSubmissionStatus.networkError));
    }
  }

  void updateDisplayName(String name) async {
    try {
      await _userRepository.updateDisplayName(name);
      emit(state.copyWith(status: SignInSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SignInSubmissionStatus.networkError));
    }
  }
}

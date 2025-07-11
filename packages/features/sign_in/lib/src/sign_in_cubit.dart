import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain_models/domain_models.dart';

import 'package:api/api.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final _userRepository = Api.instance.userRepository;

  SignInCubit() : super(const SignInState());

  Future<void> continueWithMobile(String phoneNumber) async {
    emit(state.copyWith(status: SignInSubmissionStatus.inprogress));
    try {
      await _userRepository.signInwithPhoneNumberWeb(phoneNumber);
      emit(state.copyWith(status: SignInSubmissionStatus.awaitingOtp));
    } catch (_) {
      emit(state.copyWith(status: SignInSubmissionStatus.networkError));
    }
  }

  Future<void> verifyOtp(String otp) async {
    emit(state.copyWith(status: SignInSubmissionStatus.inprogress));
    try {
      final result = await _userRepository.verifyOtp(otp);

      emit(
        state.copyWith(
          status: result.isNewUser
              ? SignInSubmissionStatus.newUser
              : SignInSubmissionStatus.success,
          user: result.user,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(status: SignInSubmissionStatus.failedOtpVerification),
      );
    }
  }

  Future<void> continueWithGoogle() async {
    emit(state.copyWith(status: SignInSubmissionStatus.inprogress));
    try {
      final result = await _userRepository.signInWithGoogleWeb();

      emit(
        state.copyWith(
          status: result.isNewUser
              ? SignInSubmissionStatus.newUser
              : SignInSubmissionStatus.success,
          user: result.user,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: SignInSubmissionStatus.networkError));
    }
  }
}

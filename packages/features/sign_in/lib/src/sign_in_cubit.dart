import 'dart:async';
import 'package:domain_models/domain_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final UserRepository _userRepository;

  SignInCubit(this._userRepository) : super(SignInState());

  Future<void> signInWithApple() async {
    emit(state.copyWith(status: SignInSubmissionStatus.appleSignInLoading));
    try {
      await _userRepository.signInWithApple();
      emit(state.copyWith(status: SignInSubmissionStatus.success));
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

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(status: SignInSubmissionStatus.googleSignInLoading));
    try {
      await _userRepository.signInWithGoogle();
      emit(state.copyWith(status: SignInSubmissionStatus.success));
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
}

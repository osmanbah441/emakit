import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:domain_models/domain_models.dart';
import 'package:user_repository/user_repository.dart';
import 'package:store_repository/store_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required UserRepository userRepository,
    required StoreRepository storeRepository,
  }) : _userRepository = userRepository,
       _storeRepository = storeRepository,
       super(const ProfileState()) {
    _userSubscription = _userRepository.onUserChanges.listen((user) {
      if (user == null) {
        emit(const ProfileState(status: ProfileStatus.authenticationRequired));
      } else {
        _fetchPageData();
      }
    });

    _phoneAuthStatusSubscription = _userRepository.onPhoneAuthStatusChanged
        .listen((status) {
          switch (status) {
            case PhoneAuthCodeSent():
              emit(
                state.copyWith(phoneLinkingStatus: PhoneLinkingStatus.codeSent),
              );
              break;
            case PhoneAuthSuccess():
              emit(
                state.copyWith(phoneLinkingStatus: PhoneLinkingStatus.success),
              );
              refetch();
              break;
            case PhoneAuthFailed(error: final error):
              emit(
                state.copyWith(
                  phoneLinkingStatus: PhoneLinkingStatus.failure,
                  linkingError: error.message,
                ),
              );
              break;
            default:
              break;
          }
        });
  }

  final UserRepository _userRepository;
  final StoreRepository _storeRepository;
  late final StreamSubscription<UserInfo?> _userSubscription;
  late final StreamSubscription<PhoneAuthStatus> _phoneAuthStatusSubscription;

  void refetch() => _fetchPageData();

  void _fetchPageData() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final user = _userRepository.currentUser;
      if (user == null) {
        emit(state.copyWith(status: ProfileStatus.authenticationRequired));
        return;
      }

      final store = await _storeRepository.getOwnedStore();

      emit(
        state.copyWith(status: ProfileStatus.success, user: user, store: store),
      );
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.failure, error: e.toString()));
    }
  }

  void linkGoogleAccount() async {
    emit(state.copyWith(updateStatus: UpdateStatus.inProgress));
    try {
      // await _userRepository.linkWithGoogle();
      // After success, we might want to refetch data to show the new email
      refetch();
      emit(state.copyWith(updateStatus: UpdateStatus.success));
    } catch (e) {
      emit(
        state.copyWith(updateStatus: UpdateStatus.failure, error: e.toString()),
      );
    } finally {
      emit(state.copyWith(updateStatus: UpdateStatus.initial));
    }
  }

  void updatePhoto() async {}

  // ADD THIS METHOD to start the phone linking process
  Future<void> linkPhoneNumber(String phoneNumber) async {
    emit(
      state.copyWith(
        phoneLinkingStatus: PhoneLinkingStatus.loading,
        linkingPhoneNumber: phoneNumber,
        clearLinkingError: true,
      ),
    );
    try {
      // You will need to implement this method in your UserRepository
      // await _userRepository.signInWithPhoneNumber(phoneNumber: phoneNumber);
    } on AuthException catch (e) {
      emit(
        state.copyWith(
          phoneLinkingStatus: PhoneLinkingStatus.failure,
          linkingError: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          phoneLinkingStatus: PhoneLinkingStatus.failure,
          linkingError: e.toString(),
        ),
      );
    }
  }

  // ADD THIS METHOD to verify the OTP for linking
  Future<void> verifyPhoneNumberLink(String otpCode) async {
    emit(state.copyWith(phoneLinkingStatus: PhoneLinkingStatus.loading));
    try {
      // You will need to implement this in your UserRepository
      // await _userRepository.verifyPhoneNumberOtp(otpCode: otpCode);
    } on AuthException catch (e) {
      emit(
        state.copyWith(
          phoneLinkingStatus: PhoneLinkingStatus.failure,
          linkingError: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          phoneLinkingStatus: PhoneLinkingStatus.failure,
          linkingError: e.toString(),
        ),
      );
    }
  }

  void logOut() async {
    try {
      await _userRepository.signOut();
    } catch (e) {
      emit(
        state.copyWith(
          updateStatus: UpdateStatus.failure,
          error: "Failed to log out: ${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _phoneAuthStatusSubscription.cancel();
    return super.close();
  }
}

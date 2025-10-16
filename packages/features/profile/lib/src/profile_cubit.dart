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
  }

  final UserRepository _userRepository;
  final StoreRepository _storeRepository;
  late final StreamSubscription<UserInfo?> _userSubscription;

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
    return super.close();
  }
}

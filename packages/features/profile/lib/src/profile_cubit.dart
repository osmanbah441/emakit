import 'package:address_repository/address_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:domain_models/domain_models.dart';
import 'package:payment_repository/payment_repository.dart';
import 'package:profile/src/profile_state.dart';
import 'package:user_repository/user_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository _userRepository;
  final AddressRepository _addressRepository;
  final PaymentRepository _paymentRepository;

  ProfileCubit({
    required UserRepository userRepository,
    required AddressRepository addressRepository,
    required PaymentRepository paymentRepository,
  }) : _userRepository = userRepository,
       _addressRepository = addressRepository,
       _paymentRepository = paymentRepository,
       super(const ProfileState()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));

    final user = _userRepository.currentUser;
    if (user == null) {
      emit(
        state.copyWith(status: ProfileStatus.failure, error: 'User not found.'),
      );
      return;
    }

    try {
      // Fetch all data in parallel
      final results = await Future.wait([
        _addressRepository.getAddresses(),
        _paymentRepository.getPaymentMethods(),
      ]);

      emit(
        state.copyWith(
          status: ProfileStatus.success,
          user: user,
          addresses: results[0] as List<Address>,
          paymentMethods: results[1] as List<PaymentMethod>,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.failure, error: e.toString()));
    }
  }

  Future<void> linkGoogleAccount() async {
    // Implementation would call user repository and then reload the profile
  }

  Future<void> signOut() async {
    await _userRepository.signOut();
  }
}

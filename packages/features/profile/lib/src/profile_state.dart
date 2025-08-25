import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:profile/src/profile_screen.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final UserInfo? user;
  final List<Address> addresses;
  final List<PaymentMethod> paymentMethods;
  final String? error;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.user,
    this.addresses = const [],
    this.paymentMethods = const [],
    this.error,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    UserInfo? user,
    List<Address>? addresses,
    List<PaymentMethod>? paymentMethods,
    String? error,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      addresses: addresses ?? this.addresses,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, user, addresses, paymentMethods, error];
}

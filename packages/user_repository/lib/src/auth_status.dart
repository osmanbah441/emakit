import 'package:domain_models/domain_models.dart';

/// Represents all possible states of the phone number authentication flow.
/// The UI layer will listen for these states to show the appropriate UI.
sealed class PhoneAuthStatus {}

/// Indicates that the OTP code has been successfully sent.
/// The UI should now prompt the user to enter the code.
class PhoneAuthCodeSent extends PhoneAuthStatus {}

/// Indicates the user has been signed in successfully after OTP verification.
class PhoneAuthSuccess extends PhoneAuthStatus {}

/// Indicates that the phone verification process failed.
class PhoneAuthFailed extends PhoneAuthStatus {
  final AuthException error;
  PhoneAuthFailed(this.error);
}

/// Indicates that Firebase automatically verified the user (e.g., via SafetyNet on Android).
/// The user is already signed in, and no OTP is needed.
class PhoneAuthAutoVerified extends PhoneAuthStatus {}

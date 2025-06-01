import 'package:cloud_functions/cloud_functions.dart';

final class CloudFunctionService {
  const CloudFunctionService();

  static final _functions = FirebaseFunctions.instance;

  static void useEmulator(String host, int port) {
    _functions.useFunctionsEmulator(host, port);
  }
}

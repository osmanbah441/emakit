import 'package:backend/src/database/generated/default.dart';

final class DataconnectService {
  const DataconnectService();

  static final _connector = DefaultConnector.instance;

  static void useEmulator(String host, int port) {
    _connector.dataConnect.useDataConnectEmulator(host, port);
  }
}

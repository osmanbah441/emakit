import 'package:ai/src/live_model/live_model.dart';

final class AIService {
  AIService._() : liveModel = LiveModel();

  static final instance = AIService._();

  final LiveModel liveModel;
}

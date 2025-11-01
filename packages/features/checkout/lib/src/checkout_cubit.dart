import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain_models/domain_models.dart';
import 'package:cart_repository/cart_repository.dart';
part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(this._cartRepository) : super(const CheckoutState()) {
    _loadInitialData();
  }

  final CartRepository _cartRepository;

  void _loadInitialData() async {
    final items = await _cartRepository.getItems(onlySelected: true);

    emit(state.copyWith(isLoading: false, items: items));
  }

  void unSelect(String id) async {
    try {
      await _cartRepository.update(id, isSelected: false);
      _loadInitialData();
    } catch (e) {
      // TODO
    }
  }
}

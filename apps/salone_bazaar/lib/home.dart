import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:product_list/product_list.dart';
import 'package:store_repository/store_repository.dart';
import 'package:user_repository/user_repository.dart';

import 'router/route_paths.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Store? _store;

  @override
  void initState() {
    super.initState();
    _setHasStore();
  }

  void _setHasStore() async {
    final hasStore = await StoreRepository.instance.getOwnedStore();
    if (mounted) {
      setState(() {
        _store = hasStore;
      });
    }
  }

  void _signOut() async {
    await UserRepository.instance.signOut();
    if (mounted) {
      context.goNamed(RoutePaths.signIn.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserInfo?>(
      stream: UserRepository.instance.onAuthStateChanged,
      builder: (context, asyncSnapshot) {
        final user = asyncSnapshot.data;

        final storeState = _store == null
            ? UserStoreState.noStore
            : _store!.status.isPending
            ? UserStoreState.pendingApproval
            : _store!.status.isSuspended
            ? UserStoreState.suspended
            : UserStoreState.hasStore;

        return Scaffold(
          appBar: AppBar(
            actionsPadding: const EdgeInsets.only(right: 12),
            title: const Text('Salone Bazaar'),
            actions: [
              CartIconButton(
                onPressed: () {
                  context.goNamed(RoutePaths.cart.name);
                },
              ),
              if (user != null)
                ProfileAvatarPopupMenu(
                  isSignedIn: true,
                  storeState: storeState,
                  avatarImageUrl: user.photoURL,
                  onProfileSettingsTap: () =>
                      context.goNamed(RoutePaths.profile.name),
                  onApplyToSellTap: () =>
                      context.goNamed(RoutePaths.sellerOnboarding.name),
                  onManageStoreTap: () =>
                      context.goNamed(RoutePaths.storeDashboard.name),
                  onMyOrdersTap: () {
                    context.goNamed(RoutePaths.orderList.name);
                  },
                  onLogOutTap: _signOut,
                ),
            ],
          ),
          body: ProductListScreen(
            // You might want to inject repositories here as well
            // filterDialog: CategorySelectionAlertDialog(),
            // onAddNewProductTap: (context) =>
            //     context.goNamed(RoutePaths.addEditProduct.name),
            // onCategoryFilterTap: (category) => context.goNamed(
            //   RoutePaths.filter.name,
            //   pathParameters: {
            //     'id': category.id!,
            //     'mainCategoryName': category.name,
            //   },
            // ),
            onProductSelected: (productId) => context.goNamed(
              RoutePaths.productDetails.name,
              pathParameters: {'productId': productId},
            ),
          ),
        );
      },
    );
  }
}

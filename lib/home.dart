import 'package:api/api.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:emakit/app_router.dart';
import 'package:filter/filter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:product_list/product_list.dart';

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
    final hasStore = await Api.instance.userRepository.getStore;
    setState(() {
      _store = hasStore;
    });
  }

  void _signOut() async {
    await Api.instance.userRepository.signOut();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Api.instance.userRepository.authChanges(),
      builder: (context, asyncSnapshot) {
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
            title: const Text('Emakit'),
            actions: [
              CartIconButton(
                itemCount: 10,
                onPressed: () {
                  context.goNamed(AppRouter.cartRouteName);
                },
              ),

              ProfileAvatarPopupMenu(
                storeState: storeState,
                avatarImageUrl: 'https://picsum.photos/200',
                onProfileSettingsTap: () =>
                    context.goNamed(AppRouter.profileRouteName),
                onApplyToSellTap: () =>
                    context.goNamed(AppRouter.sellerOnboardingRouteName),

                onManageStoreTap: () =>
                    context.goNamed(AppRouter.storeDashboardRouteName),

                onMyOrdersTap: () {
                  context.goNamed(AppRouter.orderListRouteName);
                },
                onLogOutTap: () async {
                  _signOut();
                  context.goNamed(AppRouter.signInRouteName);
                },
              ),
            ],
          ),
          body: ProductListScreen(
            filterDialog: CategorySelectionAlertDialog(),
            onAddNewProductTap: (context) =>
                context.goNamed(AppRouter.addEditProductRouteName),

            onCategoryFilterTap: (category) => context.goNamed(
              AppRouter.filterRouteName,
              pathParameters: {
                'id': category.id!,
                'mainCategoryName': category.name,
              },
            ),
            onProductTap: (context, productId) => context.goNamed(
              AppRouter.productDetailsRouteName,
              pathParameters: {'productId': productId},
            ),
          ),
        );
      },
    );
  }
}

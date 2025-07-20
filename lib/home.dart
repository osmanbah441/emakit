import 'package:api/api.dart';
import 'package:component_library/component_library.dart';
import 'package:emakit/app_router.dart';
import 'package:filter/filter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:product_list/product_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void _signOut() async {
    await Api.instance.userRepository.signOut();
  }

  @override
  Widget build(BuildContext context) {
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
            storeState: UserStoreState.noStore,
            avatarImageUrl: 'https://picsum.photos/200',
            onProfileSettingsTap: () {
              context.goNamed(AppRouter.profileRouteName);
            },
            onApplyToSellTap: () {
              context.goNamed(AppRouter.sellerOnboardingRouteName);
            },

            onManageStoreTap: () =>
                context.goNamed(AppRouter.storeDashboardRouteName),

            onMyOrdersTap: () {
              context.goNamed(AppRouter.orderListRouteName);
            },
            onLogOutTap: () async {
              _signOut();
              context.goNamed(AppRouter.homeRouteName);
            },
          ),
        ],
      ),
      body: ProductListScreen(
        filterDialog: CategorySelectionAlertDialog(),
        onAddNewProductTap: (context) =>
            context.goNamed(AppRouter.addEditProductRouteName),
        onManageCategoryTap: (context) =>
            context.goNamed(AppRouter.manageCategoriesRouteName),
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
  }
}

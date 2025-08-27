import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_repository/product_repository.dart';

import 'package:component_library/component_library.dart';

import 'home_bloc.dart';
import 'search_delegate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onProfileSettingsTap,
    required this.onApplyToSellTap,
    required this.onManageStoreTap,
    required this.onMyOrdersTap,
    required this.onLogInTap,
    required this.onLogOutTap,
    required this.onSeeMoreTap,
    required this.onDiscoverStoreTap,
    required this.onCategoryCardTap,
  });

  final VoidCallback onProfileSettingsTap;
  final VoidCallback onApplyToSellTap;
  final VoidCallback onManageStoreTap;
  final VoidCallback onMyOrdersTap;
  final VoidCallback onLogInTap;
  final VoidCallback onLogOutTap;
  final VoidCallback onSeeMoreTap;
  final VoidCallback onDiscoverStoreTap;
  final Function(String id) onCategoryCardTap;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ProductRepository>(
      create: (context) => ProductRepository.instance,
      child: BlocProvider(
        create: (context) => HomeBloc()..add(HomePageDataFetched()),
        child: HomeView(
          onProfileSettingsTap: onProfileSettingsTap,
          onApplyToSellTap: onApplyToSellTap,
          onManageStoreTap: onManageStoreTap,
          onMyOrdersTap: onMyOrdersTap,
          onLogInTap: onLogInTap,
          onLogOutTap: onLogOutTap,
          onSeeMoreTap: onSeeMoreTap,
          onDiscoverStoreTap: onDiscoverStoreTap,
          onCategoryCardTap: onCategoryCardTap,
        ),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
    required this.onProfileSettingsTap,
    required this.onApplyToSellTap,
    required this.onManageStoreTap,
    required this.onMyOrdersTap,
    required this.onLogInTap,
    required this.onLogOutTap,
    required this.onSeeMoreTap,
    required this.onDiscoverStoreTap,
    required this.onCategoryCardTap,
  });

  final VoidCallback onProfileSettingsTap;
  final VoidCallback onApplyToSellTap;
  final VoidCallback onManageStoreTap;
  final VoidCallback onMyOrdersTap;
  final VoidCallback onLogInTap;
  final VoidCallback onLogOutTap;
  final VoidCallback onSeeMoreTap;
  final VoidCallback onDiscoverStoreTap;
  final Function(String id) onCategoryCardTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Salone Bazaar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          ProfileAvatarPopupMenu(
            storeState: UserStoreState.pendingApproval, // TODO:
            isSignedIn: true, // TODO:
            onProfileSettingsTap: onProfileSettingsTap,
            onApplyToSellTap: onApplyToSellTap,
            onManageStoreTap: onManageStoreTap,
            onMyOrdersTap: onMyOrdersTap,
            onLogOutTap: onLogOutTap,
            onLogInTap: onLogInTap,
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == HomeStatus.failure) {
            return Center(
              child: Text('Failed to load products: ${state.errorMessage}'),
            );
          }
          if (state.status == HomeStatus.success) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () => showSearch(
                        context: context,
                        delegate: ProductSearchDelegate(
                          // productRepository: context.read<ProductRepository>(),
                        ),
                      ),
                      child: const AbsorbPointer(child: SearchBarWidget()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: CustomDressSection(
                      title: "Have a design in mind?",
                      subtitle:
                          "Our expert tailors can bring your vision to life. Share your ideas with us.",
                      onTap: onDiscoverStoreTap,
                    ),
                  ),

                  ShowcaseGridSection(
                    title: 'Categories',
                    items: state.productCategories,
                    itemBuilder: (context, item) =>
                        CategoryCard(imageUrl: item.imageUrl, name: item.name),
                    onItemTap: (item) => onCategoryCardTap(item.id),
                  ),
                ],
              ),
            );
          }
          // Initial state
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

/// The main search bar widget.
class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search for Ankara styles, Bubus, tailors...',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }
}

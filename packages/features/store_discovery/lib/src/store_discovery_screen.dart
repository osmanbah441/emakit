import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:component_library/component_library.dart';

// --- Data Model ---
enum SortOption { rating, followers, name }

class Store extends Equatable {
  final String id;
  final String name;
  final String description;
  final String logoUrl;
  final double rating;
  final int followers;
  final bool isFollowed;

  const Store({
    required this.id,
    required this.name,
    required this.description,
    required this.logoUrl,
    required this.rating,
    required this.followers,
    this.isFollowed = false,
  });

  Store copyWith({bool? isFollowed}) {
    return Store(
      id: id,
      name: name,
      description: description,
      logoUrl: logoUrl,
      rating: rating,
      followers: followers,
      isFollowed: isFollowed ?? this.isFollowed,
    );
  }

  @override
  List<Object> get props => [
    id,
    name,
    description,
    logoUrl,
    rating,
    followers,
    isFollowed,
  ];
}

// --- Data Repository ---
class StoreRepository {
  // In a real app, this would fetch data from an API.
  Future<List<Store>> fetchStores() async {
    // Simulate a network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      Store(
        id: '1',
        name: 'Urban Threads',
        description: 'Modern & stylish urban wear.',
        logoUrl: 'https://picsum.photos/id/101/100',
        rating: 4.8,
        followers: 12500,
        isFollowed: true,
      ),
      Store(
        id: '2',
        name: 'Vintage Vogue',
        description: 'Classic styles from every decade.',
        logoUrl: 'https://picsum.photos/id/102/100',
        rating: 4.5,
        followers: 8900,
      ),
      Store(
        id: '3',
        name: 'ActiveWear Co.',
        description: 'Performance gear for your workout.',
        logoUrl: 'https://picsum.photos/id/103/100',
        rating: 4.9,
        followers: 25000,
        isFollowed: true,
      ),
      Store(
        id: '4',
        name: 'Luxe Label',
        description: 'High-end fashion and accessories.',
        logoUrl: 'https://picsum.photos/id/104/100',
        rating: 4.7,
        followers: 55000,
      ),
      Store(
        id: '5',
        name: 'Boho Boutique',
        description: 'Free-spirited and eclectic finds.',
        logoUrl: 'https://picsum.photos/id/105/100',
        rating: 4.6,
        followers: 7200,
      ),
      Store(
        id: '6',
        name: 'Street Smart',
        description: 'The latest in streetwear fashion.',
        logoUrl: 'https://picsum.photos/id/106/100',
        rating: 4.8,
        followers: 18000,
        isFollowed: true,
      ),
    ];
  }
}

// --- State Management (Cubit) ---

// State class
class StoreState extends Equatable {
  final List<Store> allStores;
  final List<Store> followedStores;
  final List<Store> discoverStores;
  final SortOption sortOption;
  final String searchQuery;

  const StoreState({
    this.allStores = const [],
    this.followedStores = const [],
    this.discoverStores = const [],
    this.sortOption = SortOption.name,
    this.searchQuery = '',
  });

  StoreState copyWith({
    List<Store>? allStores,
    List<Store>? followedStores,
    List<Store>? discoverStores,
    SortOption? sortOption,
    String? searchQuery,
  }) {
    return StoreState(
      allStores: allStores ?? this.allStores,
      followedStores: followedStores ?? this.followedStores,
      discoverStores: discoverStores ?? this.discoverStores,
      sortOption: sortOption ?? this.sortOption,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object> get props => [
    allStores,
    followedStores,
    discoverStores,
    sortOption,
    searchQuery,
  ];
}

// Cubit class
class StoreCubit extends Cubit<StoreState> {
  final StoreRepository _storeRepository;

  StoreCubit(this._storeRepository) : super(const StoreState()) {
    loadStores();
  }

  void loadStores() async {
    final initialStores = await _storeRepository.fetchStores();
    emit(state.copyWith(allStores: initialStores));
    _updateLists();
  }

  void toggleFollow(Store store) {
    final updatedStores = state.allStores.map((s) {
      if (s.id == store.id) {
        return s.copyWith(isFollowed: !s.isFollowed);
      }
      return s;
    }).toList();
    emit(state.copyWith(allStores: updatedStores));
    _updateLists();
  }

  void search(String query) {
    emit(state.copyWith(searchQuery: query));
    _updateLists();
  }

  void sort(SortOption option) {
    emit(state.copyWith(sortOption: option));
    _updateLists();
  }

  void _updateLists() {
    final followed = state.allStores.where((s) => s.isFollowed).toList();

    List<Store> discover = List.from(state.allStores);

    // Filter
    if (state.searchQuery.isNotEmpty) {
      discover = discover
          .where(
            (s) =>
                s.name.toLowerCase().contains(state.searchQuery.toLowerCase()),
          )
          .toList();
    }

    // Sort
    switch (state.sortOption) {
      case SortOption.rating:
        discover.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case SortOption.followers:
        discover.sort((a, b) => b.followers.compareTo(a.followers));
        break;
      case SortOption.name:
        discover.sort((a, b) => a.name.compareTo(b.name));
        break;
    }

    emit(state.copyWith(followedStores: followed, discoverStores: discover));
  }
}

// --- UI Widgets ---

// Provider setup
class StoreDiscoveryScreen extends StatelessWidget {
  const StoreDiscoveryScreen({super.key, required this.onStoreTapped});
  final Function(String) onStoreTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreCubit(StoreRepository()),
      child: StoreDiscoveryView(onStoreTapped: onStoreTapped),
    );
  }
}

@visibleForTesting
class StoreDiscoveryView extends StatelessWidget {
  final Function(String) onStoreTapped;

  const StoreDiscoveryView({super.key, required this.onStoreTapped});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Find Stores'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Following'),
              Tab(text: 'Discover'),
            ],
          ),
        ),
        body: BlocBuilder<StoreCubit, StoreState>(
          builder: (context, state) {
            // Show a loading indicator while the initial data is being fetched
            if (state.allStores.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return TabBarView(
              children: [
                // --- Following Tab ---
                state.followedStores.isEmpty
                    ? Center(
                        child: Text(
                          'You are not following any stores yet.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                    : _buildStoreList(state.followedStores, context),
                // --- Discover Tab ---
                Column(
                  children: [
                    _buildControls(context),
                    Expanded(
                      child: _buildStoreList(state.discoverStores, context),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildControls(BuildContext context) {
    final cubit = context.read<StoreCubit>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            onChanged: (query) => cubit.search(query),
            decoration: const InputDecoration(
              hintText: 'Search for a store...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sort by:', style: Theme.of(context).textTheme.titleSmall),
              DropdownButton<SortOption>(
                value: context.watch<StoreCubit>().state.sortOption,
                items: const [
                  DropdownMenuItem(value: SortOption.name, child: Text('Name')),
                  DropdownMenuItem(
                    value: SortOption.rating,
                    child: Text('Rating'),
                  ),
                  DropdownMenuItem(
                    value: SortOption.followers,
                    child: Text('Followers'),
                  ),
                ],
                onChanged: (SortOption? newValue) {
                  if (newValue != null) {
                    cubit.sort(newValue);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStoreList(List<Store> stores, BuildContext context) {
    if (stores.isEmpty) {
      return Center(
        child: Text(
          'No stores found.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: stores.length,
      itemBuilder: (context, index) {
        final store = stores[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: StoreCard(
            name: store.name,
            imageUrl: store.logoUrl,
            onFollowTap: () => context.read<StoreCubit>().toggleFollow(store),
            isFollowed: store.isFollowed,
            rating: store.rating,
            followers: store.followers,
            // Pass the store's ID to the callback.
            onTap: () => onStoreTapped(store.id),
          ),
        );
      },
    );
  }
}

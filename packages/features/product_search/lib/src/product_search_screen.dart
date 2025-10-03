import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:component_library/component_library.dart';
import 'package:product_search/src/search_bloc.dart';

class ProductSearchScreen extends StatelessWidget {
  const ProductSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: const ProductSearchView(),
    );
  }
}

@visibleForTesting
class ProductSearchView extends StatefulWidget {
  const ProductSearchView({super.key});

  @override
  State<ProductSearchView> createState() => _ProductSearchViewState();
}

class _ProductSearchViewState extends State<ProductSearchView> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _focusNode.requestFocus(),
    );
  }

  void _onTextChanged(String value, BuildContext context) {
    _debounce?.cancel();
    if (value.length >= 3) {
      _debounce = Timer(const Duration(milliseconds: 500), () {
        context.read<SearchBloc>().add(SubmitTextSearch(value));
      });
    }
    setState(() {}); // update trailing icon
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    try {
      final x = await _picker.pickImage(source: source, imageQuality: 80);
      if (x == null) return;
      context.read<SearchBloc>().add(SubmitImageSearch(File(x.path)));
      _controller.clear();
      _focusNode.unfocus();
      setState(() {});
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? 'Image pick failed')));
    }
  }

  void _showImageSourceSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(context, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(context, ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SearchBloc>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SearchBar(
                controller: _controller,
                focusNode: _focusNode,
                hintText: 'Search products...',
                onChanged: (value) => _onTextChanged(value, context),
                onSubmitted: (value) => bloc.add(SubmitTextSearch(value)),
                trailing: [
                  _controller.text.isEmpty
                      ? IconButton(
                          icon: const Icon(Icons.camera_alt_outlined),
                          onPressed: () => _showImageSourceSheet(context),
                        )
                      : IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _controller.clear();
                            bloc.add(ClearSearch());
                            _focusNode.requestFocus();
                            setState(() {});
                          },
                        ),
                ],
              ),
            ),

            // Results
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  switch (state.status) {
                    case SearchStatus.loading:
                      return const Center(child: CircularProgressIndicator());
                    case SearchStatus.success:
                      if (state.results.isEmpty) {
                        return const Center(child: Text("No results found."));
                      }
                      return GridView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: state.results.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.7,
                            ),
                        itemBuilder: (context, i) => ProductListCard(
                          imageUrl: state.results[i].imageUrl,
                          price: state.results[i].price,
                        ),
                      );
                    default:
                      return const Center(
                        child: Text('Search by typing or picking an image'),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

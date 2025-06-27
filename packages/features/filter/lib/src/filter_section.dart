import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_cubit.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({super.key, required this.state});

  final CategoryDetailsLoaded state;

  static const _divider = Divider(height: 32, thickness: 1);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubCategoryFilter(context, state),
        const SizedBox(height: 12), // Replaced spacing: 12
        _divider,
        _buildBrandFilter(context, state),
        const SizedBox(height: 12), // Replaced spacing: 12
        _divider,
        _buildPriceRangeFilter(context, state),
        const SizedBox(height: 12), // Replaced spacing: 12
        _divider,
        const SizedBox(height: 16),
        _buildActionButtons(context),
      ],
    );
  }

  Widget _buildSubCategoryFilter(
    BuildContext context,
    CategoryDetailsLoaded state,
  ) {
    return SelectableFilterChips<Category>(
      itemLabelBuilder: (category) => category.name,
      title: 'Shop popular ${state.mainCategoryName.toLowerCase()} categories:',
      options: state.subCategories,
      selectedOption: state.tempFilters.selectedSubCategory,
      onOptionSelected: (category) {
        context.read<CategoryDetailsCubit>().updateTempSubCategory(category);
      },
    );
  }

  Widget _buildBrandFilter(BuildContext context, CategoryDetailsLoaded state) {
    return SelectableFilterChips<String>(
      itemLabelBuilder: (name) => name,
      title: 'Brands',
      options: state.availableBrands,
      selectedOption: state.tempFilters.selectedBrand,
      onOptionSelected: (brand) {
        context.read<CategoryDetailsCubit>().updateTempBrand(brand);
      },
    );
  }

  Widget _buildPriceRangeFilter(
    BuildContext context,
    CategoryDetailsLoaded state,
  ) {
    final priceRange = state.tempFilters.priceRange!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Range (\$${priceRange.min.round()} - \$${priceRange.max.round()})',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        RangeSlider(
          values: RangeValues(priceRange.min, priceRange.max),
          min: state.priceRange.min,
          max: state.priceRange.max,
          divisions: (state.priceRange.max / 10).round(),
          labels: RangeLabels(
            '\$${priceRange.min.round()}',
            '\$${priceRange.max.round()}',
          ),
          onChanged: (RangeValues newValues) {
            context.read<CategoryDetailsCubit>().updateTempPriceRange((
              min: newValues.start,
              max: newValues.end,
            ));
          },
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ButtonActionBar(
      onRightTap: () => context.read<CategoryDetailsCubit>().applyFilters(),
      onLeftTap: () => context.read<CategoryDetailsCubit>().resetFilters(),
      rightLabel: 'Apply Filters',
      leftLabel: "Reset",
    );
  }
}

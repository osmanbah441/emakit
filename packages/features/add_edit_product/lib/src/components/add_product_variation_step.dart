import 'package:add_edit_product/src/add_edit_product_cubit.dart';
import 'package:add_edit_product/src/components/product_attributes_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductVariationStep extends StatelessWidget {
  const AddProductVariationStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditProductCubit, AddEditProductState>(
      builder: (context, state) => ProductAttributesBuilder(
        title:
            'Add the details for your product variation. Describe its unique features like size, color, or material.',
        initialValues: state.productVariationData,
        onSubmit: (data) {
          context.read<AddEditProductCubit>().addProductVariation(data);
        },
      ),
    );
  }
}

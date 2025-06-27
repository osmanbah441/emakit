import 'package:add_edit_product/src/add_edit_product_cubit.dart';
import 'package:add_edit_product/src/components/product_attributes_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductSpecificationStep extends StatelessWidget {
  const AddProductSpecificationStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditProductCubit, AddEditProductState>(
      builder: (context, state) => ProductAttributesBuilder(
        initialValues: state.productSpecificationData,
        onSubmit: (data) {
          context.read<AddEditProductCubit>().addProductSpecification(data);
        },
        title:
            "We're ready to help you list your new product! Please provide its unique details to ensure it stands out on our platform and connects with the right buyers.",
      ),
    );
  }
}

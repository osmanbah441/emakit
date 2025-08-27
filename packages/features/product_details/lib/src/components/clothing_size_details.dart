import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../product_details_cubit.dart';

class ClothingSizeDetails extends StatelessWidget {
  const ClothingSizeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        final selectedVariation = state.selectedVariation;
        if (selectedVariation == null) return const SizedBox.shrink();

        final measurementTypes = MeasurementType.values.asNameMap().map(
          (k, v) => MapEntry(k.toLowerCase(), v),
        );

        final tableRows = selectedVariation.attributes.entries
            .where((e) => measurementTypes.containsKey(e.key.toLowerCase()))
            .map((e) {
              final inchesValue = double.tryParse(e.value.split(' ').first);
              if (inchesValue == null) return null;

              final measurement = Measurement(inches: inchesValue);
              final type = measurementTypes[e.key.toLowerCase()]!;
              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          type.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () => showDialog(
                            context: context,
                            builder: (_) => MeasurementGuideDialog(
                              title: type.name,
                              imageUrl: type.imageUrl,
                            ),
                          ),
                          child: const Icon(
                            Icons.info_outline,
                            color: Colors.grey,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(measurement.display(state.measurementUnit)),
                    ),
                  ),
                ],
              );
            })
            .whereType<TableRow>()
            .toList();

        if (tableRows.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sizing & Fit',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ToggleButtons(
                  isSelected: [
                    state.measurementUnit == MeasurementUnit.inches,
                    state.measurementUnit == MeasurementUnit.centimeters,
                  ],
                  onPressed: (index) {
                    final unit = index == 0
                        ? MeasurementUnit.inches
                        : MeasurementUnit.centimeters;
                    context.read<ProductDetailsCubit>().setMeasurementUnit(
                      unit,
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  constraints: const BoxConstraints(
                    minHeight: 32,
                    minWidth: 48,
                  ),
                  children: const [Text('in'), Text('cm')],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Table(
              border: TableBorder.all(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              columnWidths: const {
                0: IntrinsicColumnWidth(),
                1: FlexColumnWidth(2),
              },
              children: tableRows,
            ),
          ],
        );
      },
    );
  }
}

extension on MeasurementType {
  String get imageUrl {
    return 'assets/measurements/chest.png';
  }
}

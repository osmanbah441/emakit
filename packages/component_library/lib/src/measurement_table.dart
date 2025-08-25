import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:domain_models/domain_models.dart';

class MeasurementTable extends StatelessWidget {
  final List<ProductMeasurement> measurements;
  final MeasurementUnit unit;
  final ValueChanged<MeasurementUnit> onUnitChanged;

  const MeasurementTable({
    super.key,
    required this.measurements,
    required this.unit,
    required this.onUnitChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Measurement Info',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ToggleButtons(
              isSelected: [
                unit == MeasurementUnit.inches,
                unit == MeasurementUnit.centimeters,
              ],
              onPressed: (index) {
                onUnitChanged(
                  index == 0
                      ? MeasurementUnit.inches
                      : MeasurementUnit.centimeters,
                );
              },
              borderRadius: BorderRadius.circular(8),
              constraints: const BoxConstraints(minHeight: 32, minWidth: 48),
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
          children: measurements.map((measurement) {
            return TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        measurement.type.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => MeasurementGuideDialog(
                            title: measurement.type.name,
                            imageUrl: measurement.type.imageUrl,
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
                  padding: const EdgeInsets.all(12.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(measurement.value.display(unit)),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}

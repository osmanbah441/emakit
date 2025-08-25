enum MeasurementUnit { inches, centimeters }

class Measurement {
  final double inches;
  Measurement({required this.inches});
  double get centimeters => inches * 2.54;
  String display(MeasurementUnit unit) {
    if (unit == MeasurementUnit.centimeters) {
      return '${centimeters.toStringAsFixed(1)} cm';
    }
    return '${inches.toStringAsFixed(1)}"';
  }
}

enum MeasurementType {
  bust,
  waist,
  hip,
  length,
  shoulder,
  sleeveLength,
  neck,
  inseam,
  thigh;

  String get imageUrl {
    switch (this) {
      case MeasurementType.bust:
        return 'assets/images/custom_design.png';
      case MeasurementType.waist:
        return 'assets/images/custom_design.png';
      case MeasurementType.hip:
        return 'assets/images/custom_design.png';
      case MeasurementType.length:
        return 'assets/images/custom_design.png';
      case MeasurementType.shoulder:
        return 'assets/images/custom_design.png';
      case MeasurementType.sleeveLength:
        return 'assets/images/custom_design.png';
      case MeasurementType.neck:
        return 'assets/images/custom_design.png';
      case MeasurementType.inseam:
        return 'assets/images/custom_design.png';
      case MeasurementType.thigh:
        return 'assets/images/custom_design.png';
    }
  }
}

class ProductMeasurement {
  final MeasurementType type;
  final Measurement value;
  ProductMeasurement({required this.type, required this.value});
}

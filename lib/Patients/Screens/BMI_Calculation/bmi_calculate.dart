import 'dart:math';

class BmiCalculate{
  
  final int height;
  final int weight;

  double _bmi=0.0;

  BmiCalculate({required this.height, required this.weight});

  double calculateMyBMI() {
    this._bmi = weight / pow(height / 100, 2);   
    return double.parse(_bmi.toStringAsFixed(2));
  }
}
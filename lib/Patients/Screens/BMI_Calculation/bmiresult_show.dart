import 'dart:math';

class BmiResultShow {
  
  final double percentile;
  final double bmi;
  final int age;
  String bmi_Result="";
  
  BmiResultShow({required this.bmi, required this.percentile,required this.age});

  String getResult(){
    if(age>=20){
      if (bmi >= 30) {
        this.bmi_Result=  'Obese';
      }else if (bmi >= 25) {
        this.bmi_Result=  'Overweight';
      } else if (bmi > 18.5) {
        this.bmi_Result= 'Healthy';
      } else {
        this.bmi_Result= 'Underweight';
      }
    }
    else{
      if(percentile >= 95){
        this.bmi_Result=  'Obese';
      }else if (percentile >= 85) {
        this.bmi_Result=  'Overweight';
      } else if (percentile > 5) {
        this.bmi_Result= 'Healthy';
      } else {
        this.bmi_Result= 'Underweight';
      }
    }

    return bmi_Result;
  }

  String getInterpretation() {
    if (bmi_Result =='Obese') {
      //return 'You are in Obesity level. Keep diet & Try to exercise more.\n 💪🚵🚴🏊🏇🏃';
      return 'You are in Obesity level. Consume less \'bad\' fat and more \'good\' fat.\nConsume less processed and sugary foods.\nEat more servings of vegetables and fruits 🍇🍉🍍🍒🌽.\nEngage in regular aerobic activity 💪🚵🚴🏊🏇🏃.';
    } else  if (bmi_Result =='Overweight') {
      return 'You have a higher than healthy body weight. Try to exercise 💪🚵🚴🏊🏇🏃.\nAvoid food that is high in sugar, like pastries, sweetened cereal, and soda or fruit-flavored drinks.\nEat Low/No-Fat Dairy Products.';
    } else if (bmi_Result =='Healthy') {
      return 'You have a healthy body weight. Good job!\n 🍇🍉🍍🍒🌽';
    } else {
      return 'You have a lower than healthy body weight. You can eat a bit more 🍲🍱🍳🍗🍒🍎.\nChoosing unsaturated oils and spreads, such as sunflower or rapeseed, and eating them in small amounts.\nDrinking plenty of fluids.\nTry to avoid relying on high-calorie foods full of saturated fat and sugar.';
    }   
  }

}
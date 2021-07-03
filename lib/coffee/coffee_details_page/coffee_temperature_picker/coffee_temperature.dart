enum CoffeeTemperature {
  HOT,
  COLD,
}

class CoffeeTemperatureModel {
  final CoffeeTemperature temperature;
  final String label;

  CoffeeTemperatureModel(this.temperature, this.label);
}
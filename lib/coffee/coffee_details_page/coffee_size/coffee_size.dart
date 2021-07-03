enum CoffeeSize {
  SMALL,
  MEDIUM,
  LARGE,
}

class CoffeeSizeModel {
  final CoffeeSize size;
  final String label;
  final String imageAsset;

  CoffeeSizeModel(this.size, this.label, this.imageAsset);
}

enum Challenge {
  BATMAN,
  COFFEE,
}

extension ChallengePresentation on Challenge {
  String get stringValue {
    switch(this) {
      case Challenge.BATMAN:
        return "Batman";
      case Challenge.COFFEE:
        return "Coffee Shop";
    }
  }
}
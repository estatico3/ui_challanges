enum Challenge {
  COFFEE,
}

extension ChallengePresentation on Challenge {
  String get stringValue {
    switch(this) {

      case Challenge.COFFEE:
        return "Coffee Shop";
    }
  }
}
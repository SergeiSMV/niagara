extension ReturnPriceString on double {
  String get priceString {
    final formattedNumber = toString();
    return formattedNumber.endsWith('.0')
        ? formattedNumber.replaceAll('.0', '')
        : formattedNumber;
  }
}

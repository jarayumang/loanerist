String formatNumberWithCommas(int number) {
  if (number < 1000) {
    return number.toString();
  }
  String formattedString = '';
  String numberString = number.toString();
  int commaCount = 0;
  for (int i = numberString.length - 1; i >= 0; i--) {
    formattedString = numberString[i] + formattedString;
    commaCount++;
    if (commaCount == 3 && i > 0) {
      formattedString = ',$formattedString';
      commaCount = 0;
    }
  }
  return formattedString;
}
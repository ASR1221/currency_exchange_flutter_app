double hexStringToDouble(String hexString) {
  // Remove the "0x" prefix from the hexadecimal string
  hexString = hexString.replaceAll("0x", "");

  // Parse the hexadecimal string to an integer
  int intValue = int.parse(hexString, radix: 16);

  // Convert the integer to a double
  double doubleValue = intValue.toDouble();

  return doubleValue;
}
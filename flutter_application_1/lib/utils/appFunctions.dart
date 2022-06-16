//Useful functions
class AppFunctions {
//Convert an int into a rounded an separated string
  static String convertNumber(int number) {
    String convertedNumber = "";

    convertedNumber +=
        number.toString().substring(0, number.toString().length - 3);
    convertedNumber += " 000";

    return convertedNumber;
  }
}

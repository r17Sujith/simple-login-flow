abstract class ValidationUtil{

  static String? validateMobile(String value) {
    final RegExp mobileExp = RegExp(r'^\d{10}$');
    if (value.isEmpty) {
      return "Please enter a mobile number";
    } else if (!mobileExp.hasMatch(value)) {
      return "Please enter a valid 10-digit mobile number";
    } else {
      return null;
    }
  }

  static String? validateNameAndEmail(String name, String email) {
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    final RegExp emailExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    if (name.isEmpty) {
      return "Please enter your name";
    } else if (!nameExp.hasMatch(name)) {
      return "Please enter a valid name";
    }

    if (email.isEmpty) {
      return "Please enter an email address";
    } else if (!emailExp.hasMatch(email)) {
      return "Please enter a valid email address";
    }

    return null;
  }

}
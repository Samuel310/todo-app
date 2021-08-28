class FormValidator {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return 'Enter a valid email';
    }
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 7) {
      return 'Password must contain atleast 7 characters';
    }
    final bool hasUppercase = value.contains(RegExp(r'[A-Z]'));
    final bool hasDigits = value.contains(RegExp(r'[0-9]'));
    final bool hasLowercase = value.contains(RegExp(r'[a-z]'));
    final bool hasSpecialCharacters = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    if (!hasUppercase) {
      return 'Atleast one upper case letter [A-Z] is required';
    } else if (!hasLowercase) {
      return 'Atleast one lower letter [a-z] is required';
    } else if (!hasDigits) {
      return 'Atleast one digit [0-9] is required';
    } else if (!hasSpecialCharacters) {
      return 'Atleast one special character [!@#%] is required';
    }
  }

  static String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title cannot be empty';
    }
  }

  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description cannot be empty';
    }
  }
}

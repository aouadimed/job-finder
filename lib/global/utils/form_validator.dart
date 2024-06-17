abstract class FormValidator {
  const FormValidator._();

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter your email address.';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
        .hasMatch(email)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password.';
    }
    if (password.length < 5) {
      return 'Password must be at least 5 characters long.'; 
    }
    return null;
  }

    static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Please enter your username.';
    }
    if (username.length < 5) {
      return 'username must be at least 5 characters long.'; 
    }
    return null;
  }
}

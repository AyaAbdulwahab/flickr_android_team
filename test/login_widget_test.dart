import 'package:email_validator/email_validator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flickr/Views/login.dart';


void main() {
test('Login test',(){
  /// -------------- Email Validations -------------- ///
  /// If no Email is entered, show an error message
  var result = EValidator.validate("");
  expect(result, "Required");
  /// If email field isn't empty, return null
  result = EValidator.validate("Anything");
  expect(result,null);
  /// If entered value isn't an email, return false
   var check = EmailValidator.validate("hello");
  expect(check, false);
  /// If entered value is in email format, return true
   check = EmailValidator.validate("name@domain.com");
   expect(check, true);
});


}
import 'package:flickr/Views/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'test.dart';

import 'package:flickr/main.dart';

void main() {
  test('SignUp Test', () {
    ///=========Name Validations(First & Last Name)===========
    /// If the user didn't enter a value show an error msg
    var result = NameValidation.validate("");
    expect(result, "Required");

    /// any other value will return null
    result = NameValidation.validate("aya");
    expect(result, null);

    ///===============Age Validations=========================
    /// If the user didn't enter a value show an error msg
    result = AgeValidation.validate("");
    expect(result, "Required");

    /// If the user entered a string instead of a number
    result = AgeValidation.validate("a");
    expect(result, "Please enter a valid no");

    ///================ Boundary values ======================
    /// Flickr parse the decimals into integers(age<13)
    result = AgeValidation.validate("12.9");
    expect(result, "In order to sign up you must be 13 or older");

    ///Any value >=13 would e accepted and returns null
    result = AgeValidation.validate("13.1");
    expect(result, null);

    //If the user has exactly 13 years, return null
    result = AgeValidation.validate("13");
    expect(result, null);

    ///================Email Validations====================
    /// If the user didn't enter a value show an error msg
    result = EmailValidation.validate("");
    expect(result, "Required");

    /// If the user entered a valid email
    result = EmailValidation.validate("aya@gmail.com");
    expect(result, null);

    ///Invalid email
    result = EmailValidation.validate("aya");
    expect(result, 'Invalid email');
    //Valid email containing leading & trailing whitespace
    result = EmailValidation.validate(" aya@gmail.com ");
    expect(result, null);

    ///================Password Validations=================
    /// If the user didn't enter a value show an error msg
    result = PasswordValidation.validate("");
    expect(result, "Required");

    /// If the password conatins a leading space show an error msg
    result = PasswordValidation.validate(" aaaaaaaaaaaaa");
    expect(result, "Invalid Password");

    /// If the password is less than 12 characters show an error msg
    result = PasswordValidation.validate("aa");
    expect(result, "Invalid Password");

    /// Valid password
    result = PasswordValidation.validate("aaaaaaaaaaaaaa");
    expect(result, null);

    ///   Boundary value
    /// If the password is exactly 12 characters
    result = PasswordValidation.validate("aaaaaaaaaaaa");
    expect(result, null);
  });
}

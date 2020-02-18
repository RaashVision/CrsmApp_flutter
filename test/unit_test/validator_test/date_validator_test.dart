
import 'dart:math';

import 'package:ESmile/interfaces/i_validator.dart';
import 'package:ESmile/locator.dart';
import 'package:ESmile/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {

  //setup depencies injection
   //Dependecy injectiion
   TestWidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  IValidator iValidator = locator<IValidator>();


//This for the empty title
  test('Empty/Null Date', () {
    var result = iValidator.validatorDate(null);
    expect(result, 'Date cannot be empty!');
  });

//This to test the maximum length then allowed settings
    test('Invalid Date input', () {
    var result = iValidator.validatorDate(DateTime.now());
    expect(result, 'Please input correct format of date');
  });

  //This to test correct input of title
    test('Valid date test', () {
    var result = iValidator.validatorDate(DateTime.now());
    expect(result, null);
  });


 
}
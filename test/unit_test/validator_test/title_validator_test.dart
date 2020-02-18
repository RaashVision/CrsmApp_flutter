
import 'dart:math';

import 'package:ESmile/interfaces/i_validator.dart';
import 'package:ESmile/locator.dart';
import 'package:ESmile/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {

TestWidgetsFlutterBinding.ensureInitialized();
  //setup depencies injection
   //Dependecy injectiion
  setupLocator();
   
  IValidator iValidator = locator<IValidator>();

   String randomString(int length) {
   var rand = new Random();
   var codeUnits = new List.generate(
      length, 
      (index){
         return rand.nextInt(33)+89;
      }
   );
   
   return new String.fromCharCodes(codeUnits);
}

//This for the empty title
  test('Empty Title', () {
    var result = iValidator.validatorTitle('');
    expect(result, 'Title cannot be empty!');
  });

//This to test the maximum length then allowed settings
    test('Title more then the max length', () {
    var result = iValidator.validatorTitle(randomString(Settings.maxlength+1));
    expect(result, 'Cannot more then ${Settings.maxlength} characters');
  });

  //This to test correct input of title
    test('Valid title test', () {
    var result = iValidator.validatorTitle(randomString(Settings.maxlength));
    expect(result, null);
  });


 
}
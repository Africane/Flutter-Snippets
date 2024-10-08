import 'dart:async';
import 'package:login_bloc/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc with Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // Add data to the stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);

  // Combine streams for form validation
  Stream<bool> get submitValid => Rx.combineLatest2(email, password, (e, p) {
    return e.isNotEmpty && p.isNotEmpty;
  });

  // Change data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  // Submit the form
  submit() {
     final validEmail = _email.value;
     final validPassword = _password.value;

     print('Email is $validEmail');
     print('Password is $validPassword');
  }

  // Cleaning up controllers
  void dispose() {
    _email.close();
    _password.close();
  }
}

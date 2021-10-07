import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'sample_state.dart';

class SampleCubit extends Cubit<CubitState> {
  SampleCubit() : super(Initial());

  var _nameController = BehaviorSubject<String>();
  Stream<String> get nameStream => _nameController.stream;

  updateName(String text) {
    if (text.length < 4) {
      _nameController.sink.addError("Please enter your full name here");
    } else {
      _nameController.sink.add(text);
    }
  }

  var _phoneNumberController = BehaviorSubject<String>();
  Stream<String> get phoneNumberStream => _phoneNumberController.stream;

  updatePhone(String text) {
    if (text.length != 10) {
      _phoneNumberController.sink.addError("Please enter your 10 digit phone number here");
    } else {
      _phoneNumberController.sink.add(text);
    }
  }

  void onNext(){
    print("Phone number = " + _phoneNumberController.value.toString());
    print("Name = " + _nameController.value.toString());
  }


  Stream<bool> get buttonValid => Rx.combineLatest2(
      nameStream, phoneNumberStream,  (a, b) => true);
}

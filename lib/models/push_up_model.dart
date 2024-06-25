
import 'package:flutter_bloc/flutter_bloc.dart';

enum PushUpState{
  neutral, 
  init, 
  complete

}


class PushCounter extends Cubit<PushUpState>{
  PushCounter() : super(PushUpState.neutral);
  int counter = 0 ; 

  void setPushUpState(PushUpState current){
    emit (current);
  }

  void incrementar(){
    counter++;
    emit(state);
  }

  void reset(){
    counter = 0;
    emit(state);
  }
}
import 'package:bloc/bloc.dart';

///CounterCubit là class sẽ khởi tạo 2 phương thức:
///1: Gia tăng - thêm 1 vào state
///2: Giảm - trừ 1 vào state
///Loại trạng thái mà CounterCubit đang quản lý chỉ là một int và trạng thái ban đầu là 0.

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  /// add 1 to state
  void increment() => emit(state + 1);

  ///subtract 1 from the state
  void decrement() => emit(state - 1);
}

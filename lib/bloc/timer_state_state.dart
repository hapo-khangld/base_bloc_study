part of 'timer_state_bloc.dart';

/// Bắt đầu, ta xác định TimerStates mà TimerBloc có thể ở trong đó.
/// Khí đó, trạng thái của TimerBloc có thể là các trường hợp sau:
/// Mỗi trạng thái này sẽ có hàm ý về thao tác và giao diện người dùng đang thực hiện.
/// ----------------------------------------------------------
/// Tất cả các TimerStates mở rộng lớp cơ sở trừu tượng TimerState có thuộc
/// tính thời lượng. Điều này là do bất kể TimerBloc có ở trạng thái nào, ta muốn biết còn
/// lại bao nhiêu thời gian, Ngoài ra, TimerState mở rộng Equatable để tối ứu hóa mã bằng cách
/// đảm bảo rằng ứng dụng không kích hoạt việc reBuild nếu có trạng thái tương tự xảy ra.
abstract class TimerStateState extends Equatable {
  final int duration;
  const TimerStateState(this.duration);

  @override
  List<Object> get props => [duration];
}

/// 1: TimerStateInitial: Trạng thái sẵn sàng đếm ngược.
/// Nếu ở trạng thái này, người dùng có thể bắt đầu hẹn giờ.
class TimerStateInitial extends TimerStateState {
  const TimerStateInitial(int duration) : super(duration);

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}

/// 3: TimerRunPause: Tạm dừng ở một số thời gian còn lại.
/// Nếu ở trạng thái này, người dùng có thể tiếp tục hẹn giờ và đặt lại bộ hẹn giờ.
class TimerRunPause extends TimerStateState {
  const TimerRunPause(int duration) : super(duration);

  @override
  String toString() => 'TimerRunPause { duration: $duration }';
}

///2: TimerRunInProgress: Trạng thái đang trong quá trình đếm ngược.
/// Nếu ở trạng thái này, ngươi dùng có thể tạm dừng và đặt lại bộ hẹn giờ
/// cũng như xem thời lượng còn lại.
class TimerRunInProgress extends TimerStateState {
  const TimerRunInProgress(int duration) : super(duration);

  @override
  String toString() => 'TimerRunInProgress { duration: $duration }';
}

/// 4: TimerRunComplete: Trạng thái hoàn thành với thời lượng còn lại = 0.
/// Nếu ở trang thái này, người dùng sẽ có thể đặt lại bộ hẹn giờ.
class TimerRunComplete extends TimerStateState {
  const TimerRunComplete() : super(0);
}

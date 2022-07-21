part of 'timer_state_bloc.dart';

/// Ở timerEvent: ta sẽ xử lý các sự kiện.

abstract class TimerStateEvent extends Equatable {
  const TimerStateEvent();

  @override
  List<Object> get props => [];
}

/// TimerStarted: Thông báo cho TimerBloc rằng bộ hẹn giờ đã được khởi động.
class TimerStarted extends TimerStateEvent {
  const TimerStarted({required this.duration});
  final int duration;
}

/// TimerPasesd: Thông báo cho TimerBloc rằng bộ hẹn giờ đã được tạm dừng.
class TimerPaused extends TimerStateEvent {
  const TimerPaused();
}

/// TimerResumed: Thông báo cho TimerBloc rằng hẹn giờ đã được tiếp tục.
class TimerResumed extends TimerStateEvent {
  const TimerResumed();
}

/// TimerReset: Thông báo cho TimerBloc rằng bộ hẹn giờ đã được đặt lại về trạng thái ban đầu.
class TimerReset extends TimerStateEvent {
  const TimerReset();
}

/// TimerTicked: Thông báo cho TimerBloc rằng đã có một đánh dấu đã xảy ra và nó cần
/// cập nhật lại trạng thái của nó cho phù hợp.
class TimerTicked extends TimerStateEvent {
  final int duration;
  const TimerTicked({required this.duration});

  @override
  List<Object> get props => [duration];
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../ticker.dart';

part 'timer_state_event.dart';
part 'timer_state_state.dart';

/// Đầu tiên, ta cần xác định trạng thái ban đầu của TimerBloc.
/// Ở trường hợp này, ta muốn TimerBloc bắt đầu ở trạng thái TimerInitial
/// với thời lượng đắt trước là 1p (60s)
/// --------------------------------------
/// Bây giờ, bắt đầu với việc triển khai các sự kiện. Để cải thiện hiệu năng, ta sẽ chia
/// nhỏ các trình quản lý sự kiệ thành chức năng trợ giúp riêng.
/// 1 - TimerStarted.
/// 2 - TimerTicked.
/// 3 - TimerPaused.
/// 4 - TimerResumed.

class TimerStateBloc extends Bloc<TimerStateEvent, TimerStateState> {
  static const int _duration = 60;
  final Ticker _ticker;
  StreamSubscription<int>? _tickerSubscription;
  TimerStateBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const TimerStateInitial(_duration)) {
    on<TimerStarted>(_onStarted);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerReset>(_onReset);
    on<TimerTicked>(_onTicked);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  /// Nếu TimerBloc nhận được sự kiện TimerStarted, nó sẽ đẩy trạng thái TimerRunInProgress với thời
  /// lượng bắt đầu. Ngoài ra, ta sử dụng _tickerSubcription mở, ta cần phải hủy nó để phân bổ bộ nhớ. Ta cần ghi
  /// đè phương thức đóng trên TimerBloc để có thể hủy _tickerSubscription khi TimerBloc được đóng lại.
  /// Cuối cùng, ta nghe luồng _ticker.tick và trên mỗi lần đánh dấu, ta thêm một sự kiện TimerTicked với thời
  /// lượng còn lại.
  void _onStarted(TimerStarted event, Emitter<TimerStateState> emit) {
    emit(TimerRunInProgress(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(TimerTicked(duration: duration)));
  }

  /// Ta sẽ kiểm tra xem trong trạng thái của TimerBloc là TimerRunInProgress, thì khi đó
  /// ta có thể tạm dừng _tickerSubscription và đẩy trạng thái TimerRunPause với thời lượng hẹn giờ
  /// hiện tại.
  void _onPaused(TimerPaused event, Emitter<TimerStateState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause(state.duration));
    }
  }

  /// Trình xử lý sự kiện của TimerResumed giống với TimerPaused. Nếu TimerBloc có trạng thái là
  /// TimerRunPaused và nó nhận được sự kiện TimerResumed, thì nó sẽ tiếp tục _tickerSubscription
  /// và đẩy trạng thái TimerRunInProgress với thời lượng hiệ tại.
  void _onResumed(TimerResumed event, Emitter<TimerStateState> emit) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }
  }

  /// Nếu TimerBloc nhận được sự kiện TimerReset, nó cần phải hủy _tickerSubscription hiện tại để nó
  /// không thông báo về bất kỳ tích tắc bổ sung nào và đẩy trạng thái TimerInitial với thòi lượng ban đầu.
  void _onReset(TimerReset event, Emitter<TimerStateState> emit) {
    _tickerSubscription?.cancel();
    emit(const TimerStateInitial(_duration));
  }

  /// Mỗi lần nhận được sự kiện TimerTicked, nếu thời lượng của tick > 0,
  /// ta cần đẩy trạng thái TimerRunInProgress được cập nhật với thời lượng mới.
  /// Nếu thời lượng của tick  = 0, bộ đếm thời gian đã kết thúc và ta cần đẩy về trạng thái TimerunComplete.
  void _onTicked(TimerTicked event, Emitter<TimerStateState> emit) {
    emit(event.duration > 0
        ? TimerRunInProgress(event.duration)
        : const TimerRunComplete());
  }
}

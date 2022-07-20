/// Đây là mã nguồn dữ liệu của app. Nó sẽ phơi bày một luồng về
/// việc chúng ta có thể dăng ký và lắng nghe.

/// Tất cả những gì hàm này thực hiện là  hiển thị một hàm tích lấy ra số tick(giây)
/// mà chúng ta muốn và trả về một luồng phát ra các giây còn lại mỗi giây. Tiếp theo, chsng ta cần tạo
/// TimerBloc của chúng ta sẽ sử dụng Ticker.
class Ticker {
  const Ticker();

  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}

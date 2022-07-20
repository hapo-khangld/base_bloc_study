# base_bloc_study

A new Flutter project.

## Getting Started

## Kiến trúc của dự án:

├── lib
│   ├── app.dart
│   ├── counter
│   │   ├── counter.dart
│   │   ├── cubit
│   │   │   └── counter_cubit.dart
│   │   └── view
│   │       ├── counter_page.dart
│   │       └── counter_view.dart
│   ├── counter_observer.dart
│   └── main.dart
├── pubspec.lock
├── pubspec.yaml

- Đầu tiên, ta tạo một BlocObserver nhằm mục đích quan sát tất cả các thay dổi trạng thái của ứng dụng.
- Bước 2: trở lại main.dart để thay đổi void main(), sử dụng BlocOverrides.runZoned()
- Bước 3: Tạo một class CounterApp - nó giống với MyApp(). class này chỉ định home sẽ là Counterpage().
- Bước 4: Tạo CounterPage() - chịu trách nhiệm tạo COunterCubit và cung cấp nó cho UI: CounterView().
# Hãy chú ý việc tách rời việc tạo Cubit với việc sử dụng Cubit, nó giúp cho mã code có thể kiểm
# tra và tái sử dụng nhiều hơn.
- Bước 5: Tạo CounterCubit() - chịu trách nhiệm thực hiện việc thay đổi State.
- Bước 6: Tạo CounterView() - đây là class thiết kế UI và chịu trách nhiệm hiển thị việc tăng hay giảm ở 2 floatingButton.
- Bước 7: Tạo counter.dart - đưa ra / đề xuất tất cả các phần công khai mà counter có thể truy cập.

export 'cubit/counter_cubit.dart';
export 'view/counter_page.dart';

///Xây dựng counter. dart nhằm mục đích xuất ra tất cả các phần công khai có thể truy cập
///Việc này nhằm mục đích tách lớp Presentation ra khỏi lớp business logic.
///-- Bản thân CounterView không hề biết điều gì xảy ra khi người dùng bấm nút,
///nó chỉ biết thông báo cho CounterCubit rằng người dùng vừa bấm nút nào.
///Hơn nữa, CounterCubit cũng không hề biết điều gì đang xảy ra với trạng thái,
///nó chỉ đơn giản là thực hiện EMIT, phát ra trang thái mới để đáp ứng với
///các phương thức vừa được gọi.

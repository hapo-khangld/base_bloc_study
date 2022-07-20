import 'package:base_bloc_study/counter/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// CounterView chịu trách nhiệm hiển thị số lượng bộ đếm hiện tại và
/// hiển thị 2 FloatingActionButton để tăng hoặc giảm bộ đếm
/// ==> Nói chung, CounterView được sinh ra để hiển thị UI
///
/// Tại đây, ta sử dụng BlocBuilder để bọc tiện ích Text nhằm mục đích cập
/// nhật văn bản bất cứ khi nào trạng thái CounterCubit thay đổi.
/// Ngoài ra, sử dụng context.read<CouonterCubit>() để tra cứu phiên bản
/// CounterCubit gần nhất.
///
/// Mặt khác, chỉ duy nhất tiện ích Text() được bao bọc trong một BlocBuilder
/// vì đó là widget duy nhất cần được rebuild lại với các sự thay đổi của
/// CounterCubit. Việc này tránh việc gói các Widget không cần thiết mà không cần phải
/// xây dựng lại khi trạng thái thay đổi.

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Counter App'),
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            return Text(
              '$state',
              style: textTheme.headline2,
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            key: const Key('counterView_increment_floatingActionButton'),
            onPressed: () => context.read<CounterCubit>().increment(),
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            key: const Key('counterView_decrement_floatingActionButton'),
            child: const Icon(Icons.remove),
            onPressed: () => context.read<CounterCubit>().decrement(),
          ),
        ],
      ),
    );
  }
}

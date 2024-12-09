import 'package:flutter/material.dart';
import 'package:tob/tob.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter State Management with Tob',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen>
    implements StateObserver {
  late StateNotifier<int> _counterNotifier;

  @override
  void initState() {
    super.initState();
    _counterNotifier = StateNotifier<int>(0);
    _counterNotifier
        .addObserver(this); // Đăng ký observer để nhận thông báo thay đổi state
  }

  @override
  void dispose() {
    _counterNotifier
        .removeObserver(this); // Hủy đăng ký observer khi widget bị hủy
    super.dispose();
  }

  @override
  void onStateChanged() {
    setState(() {}); // Cập nhật UI khi state thay đổi
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter with tob"),
      ),
      body: Center(
        child: Text(
          'Counter: ${_counterNotifier.value}', // Hiển thị giá trị của counter
          style: const TextStyle(fontSize: 32),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _counterNotifier
              .update(_counterNotifier.value + 1); // Cập nhật giá trị counter
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

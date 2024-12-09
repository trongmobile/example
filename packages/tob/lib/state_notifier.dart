import 'state.dart';
import 'state_observer.dart';

class StateNotifier<T> {
  final TobState<T> _state;
  final List<StateObserver> _observers = [];

  StateNotifier(T initialValue) : _state = TobState<T>(initialValue);

  // Lấy giá trị state hiện tại
  T get value => _state.value;

  // Đăng ký observer
  void addObserver(StateObserver observer) {
    _observers.add(observer);
  }

  // Hủy đăng ký observer
  void removeObserver(StateObserver observer) {
    _observers.remove(observer);
  }

  // Cập nhật giá trị state
  void update(T newValue) {
    if (_state.value != newValue) {
      _state.value = newValue;
      _notifyObservers();
    }
  }

  // Thông báo cho tất cả observers khi state thay đổi
  void _notifyObservers() {
    for (var observer in _observers) {
      observer.onStateChanged();
    }
  }

  // Cập nhật state bất đồng bộ
  Future<void> updateAsync(Future<T> futureValue) async {
    T newValue = await futureValue;
    _state.value = newValue;
    _notifyObservers();
  }

  // Reset state về giá trị mặc định
  void reset() {
    _state.value = (_state.value.runtimeType == int ? 0 : '') as T;
    _notifyObservers();
  }
}

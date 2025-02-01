part of 'ganti_password_cubit.dart';

class GantiPasswordState extends Equatable {
  final GantiPasswordStatus status;
  final String msg;
  const GantiPasswordState({
    this.status = GantiPasswordStatus.initial,
    this.msg = '',
  });

  GantiPasswordState copyWith({
    GantiPasswordStatus? status,
    String? msg,
  }) {
    return GantiPasswordState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
    );
  }

  @override
  List<Object> get props => [
        status,
        msg,
      ];
}

enum GantiPasswordStatus { initial, loading, success, failure }

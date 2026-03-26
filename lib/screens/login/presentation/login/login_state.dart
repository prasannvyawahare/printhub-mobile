import 'package:equatable/equatable.dart';

enum AuthStatus {
  initial,
  loading,
  success,
  failure,
}

class LoginState extends Equatable {
  final AuthStatus status;
  final String? email;
  final String? name;
  final String? error;

  const LoginState({
    required this.status,
    this.email,
    this.name,
    this.error,
  });

  factory LoginState.initial() {
    return const LoginState(status: AuthStatus.initial);
  }

  LoginState copyWith({
    AuthStatus? status,
    String? email,
    String? name,
    String? error,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      name: name ?? this.name,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, email, name, error];
}

import 'package:equatable/equatable.dart';

class Response<T> extends Equatable {
  final bool success;
  final T? data;
  final String? message;
  final int? statusCode;

  const Response({
    required this.success,
    this.data,
    this.message,
    this.statusCode,
  });

  factory Response.success(T data, {String? message}) {
    return Response(
      success: true,
      data: data,
      message: message,
      statusCode: 200,
    );
  }

  factory Response.error(String message, {int? statusCode}) {
    return Response(
      success: false,
      message: message,
      statusCode: statusCode ?? 400,
    );
  }

  factory Response.loading() {
    return const Response(
      success: false,
      message: 'Loading...',
    );
  }

  @override
  List<Object?> get props => [success, data, message, statusCode];
}


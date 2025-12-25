import 'package:equatable/equatable.dart';

class ApiResponse<T> extends Equatable {
  final bool success;
  final T? data;
  final String? message;
  final int? statusCode;

  const ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.statusCode,
  });

  factory ApiResponse.success(T data, {int? statusCode}) {
    return ApiResponse(
      success: true,
      data: data,
      statusCode: statusCode ?? 200,
    );
  }

  factory ApiResponse.error(String message, {int? statusCode}) {
    return ApiResponse(
      success: false,
      message: message,
      statusCode: statusCode ?? 500,
    );
  }

  factory ApiResponse.toModel(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>)? fromJson,
  ) {
    return ApiResponse(
      success: json['success'] ?? false,
      data: json['data'] != null && fromJson != null
          ? fromJson(json['data'])
          : null,
      message: json['message'],
      statusCode: json['statusCode'],
    );
  }

  @override
  List<Object?> get props => [success, data, message, statusCode];
}

class PagedList<T> extends Equatable {
  final List<T> items;
  final int currentPage;
  final int totalPage;
  final int pageSize;
  final int totalCount;

  const PagedList({
    required this.items,
    required this.currentPage,
    required this.totalPage,
    required this.pageSize,
    required this.totalCount,
  });

  @override
  List<Object?> get props => [
    items,
    currentPage,
    totalPage,
    pageSize,
    totalCount,
  ];

  factory PagedList.toModel(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final itemsJson = json['items'] as List? ?? [];

    final itemsList = itemsJson
        .map((e) => fromJsonT(e as Map<String, dynamic>))
        .toList();

    return PagedList<T>(
      items: itemsList,
      currentPage: json['currentPage'] ?? 1,
      totalPage: json['totalPage'] ?? 1,
      pageSize: json['pageSize'] ?? 0,
      totalCount: json['totalCount'] ?? 0,
    );
  }
}

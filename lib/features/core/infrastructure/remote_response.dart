import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_response.freezed.dart';

@freezed
class RemoteResponse<T> with _$RemoteResponse<T> {
  const factory RemoteResponse.withNewData(T data) = _WithNewData<T>;
  const factory RemoteResponse.failure({
    int? errorCode,
    String? message,
  }) = _Failure<T>;

  const RemoteResponse._();
}

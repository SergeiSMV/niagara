part of '../../../core.dart';

/// Обработчик запросов.
@injectable
class RequestHandler {
  const RequestHandler(this._dio);

  final Dio _dio;

  /// Отправляет запрос и возвращает результат.
  /// В случае ошибки возвращает [Failure].
  Future<Either<Failure, D>> sendRequest<D, T>({
    required Future<Response<dynamic>> Function(Dio dio) request,
    required D Function(T) converter,
    required Failure Function(String error) failure,
    bool useDecode = false,
  }) async {
    try {
      final response = await request(_dio);
      if (response.data == null) return Left(failure('no data'));

      final data = (useDecode
          ? jsonDecode(response.data.toString())
          : response.data!) as Map<String, dynamic>;

      // Проверяем, есть ли ошибка в ответе сервера и возвращаем ее
      // в виде объекта [Failure].
      final error = data['error'] as String?;
      if (error != null && error.isNotEmpty) return Left(failure(error));

      // Получаем данные ответа сервера и конвертируем их в объект [T].
      final responseData = (data['response'] ?? data) as T?;

      if (responseData == null) return Left(failure('no data'));

      final res = await compute<T, D>(converter, responseData);
      return Right(res);
    } on Failure catch (e) {
      return Left(failure(e.toString()));
    }
  }
}

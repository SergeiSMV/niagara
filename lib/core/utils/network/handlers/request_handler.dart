part of '../../../core.dart';

/// Обработчик запросов.
@injectable
class RequestHandler {
  const RequestHandler({
    required Dio dio,
  }) : _dio = dio;

  final Dio _dio;

  /// Отправляет запрос и возвращает результат.
  /// В случае ошибки возвращает [Failure].
  Future<Either<Failure, D>> sendRequest<D>({
    required Future<Response<Map<String, dynamic>>> Function(Dio dio) request,
    required D Function(Map<String, dynamic>) converter,
    required Failure Function(String error) failure,
    bool useCompute = false,
  }) async {
    try {
      final response = await request(_dio);
      if (response.data == null) return Left(failure('no data'));

      // Проверяем, есть ли ошибка в ответе сервера и возвращаем ее
      // в виде объекта [Failure].
      final error = response.data!['error'] as String?;
      if (error != null && error.isNotEmpty) return Left(failure(error));

      // Получаем данные ответа сервера и конвертируем их в объект [R].
      final responseData = response.data!['response'] as Map<String, dynamic>?;

      if (responseData == null) return Left(failure('no data'));

      final res = useCompute
          ? await compute<Map<String, dynamic>, D>(converter, responseData)
          : converter(responseData);
      return Right(res);
    } catch (e) {
      return Left(failure(e.toString()));
    }
  }
}

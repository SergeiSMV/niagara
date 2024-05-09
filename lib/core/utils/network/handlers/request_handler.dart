part of '../../../core.dart';

/// Обработчик запросов.
@injectable
class RequestHandler {
  const RequestHandler(this._dio);

  final Dio _dio;

  /// Отправляет запрос и возвращает результат.
  /// В случае ошибки возвращает [Failure].
  Future<Either<Failure, Result>> sendRequest<Result, Type>({
    required Future<Response<dynamic>> Function(Dio dio) request,
    required Result Function(Type) converter,
    required Failure Function(String error) failure,
  }) async {
    try {
      final data = (await request(_dio)).data;
      if (data == null) return Left(failure('no data'));

      Type? result;

      // Определяем тип данных ответа сервера и обрабатываем их.
      if (data is Map<String, dynamic>) {
        // Проверяем, есть ли ошибка в ответе сервера и возвращаем ее
        // в виде объекта [Failure].
        final error = data['error'] as String?;
        if (error != null && error.isNotEmpty) return Left(failure(error));

        // Получаем данные ответа сервера и конвертируем их в объект [T].
        final responseData = (data['response']) as Type?;
        if (responseData == null) return Left(failure('no data'));

        result = responseData;
      } else if (data is String) {
        // Если ответ сервера - строка, то декодируем ее и возвращаем.
        result = jsonDecode(data) as Type;
      } else if (data is bool) {
        // Если ответ сервера - булево значение, то возвращаем его.
        result = data as Type;
      }

      if (result != null) {
        return Right(await compute<Type, Result>(converter, result));
      } else {
        return Left(failure('failed to convert data'));
      }
    } catch (e) {
      return Left(failure(e.toString()));
    }
  }
}

library core;

import 'dart:async';
import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/api_constants.dart';
import 'package:niagara_app/core/utils/constants/keys_constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart' hide Response;

part 'common/data/datasources/device_id_datasource.dart';
part 'common/data/datasources/token_local_datasource.dart';
part 'common/data/datasources/token_remote_datasource.dart';
part 'common/data/repositories/token_repository.dart';
part 'common/domain/repositories/i_token_repository.dart';
part 'dependencies/module.dart';
part 'utils/failures/failures.dart';
part 'utils/logger/logger.dart';
part 'utils/network/handlers/request_handler.dart';
part 'utils/network/interceptors/auth_interceptor.dart';
part 'utils/network/interceptors/error_interceptor.dart';
part 'utils/repository/base_repository.dart';
part 'utils/services/permissions_service.dart';
part 'utils/usecase/usecase.dart';

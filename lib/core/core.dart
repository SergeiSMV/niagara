library core;

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/common/data/models/token.dart';
import 'package:niagara_app/core/utils/constants/api_constants.dart';
import 'package:niagara_app/core/utils/extensions/failure_ext.dart';
import 'package:niagara_app/core/utils/logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:uuid/uuid.dart';

part 'common/data/datasources/token_local_datasource.dart';
part 'common/data/datasources/token_remote_datasource.dart';
part 'common/data/repositories/token_repository.dart';
part 'common/domain/entities/token.dart';
part 'common/domain/repositories/token_repository.dart';
part 'common/domain/usecases/check_token.dart';
part 'common/domain/usecases/get_token.dart';
part 'dependencies/module.dart';
part 'utils/errors/failures.dart';
part 'utils/handlers/request_handler.dart';
part 'utils/usecase/usecase.dart';

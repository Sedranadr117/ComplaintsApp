import 'package:complaint_app/core/databases/api/api_consumer.dart';
import 'package:complaint_app/core/databases/api/dio_consumer.dart';
import 'package:complaint_app/features/complaints/domain/repositories/complaints_repository.dart';
import 'package:complaint_app/features/complaints/domain/usecases/add_complaints.dart';
import 'package:get_it/get_it.dart';
import 'package:complaint_app/features/complaints/domain/usecases/get_all_complaint.dart';
import 'package:complaint_app/features/complaints/data/repositories/complaints_repository_impl.dart';
import 'package:complaint_app/features/complaints/data/datasources/complaints_remote_data_source.dart';
import 'package:complaint_app/core/connection/network_info.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => Dio());

  // Network info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // API Consumer
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));

  // Data sources
  sl.registerLazySingleton(() => ComplaintsRemoteDataSource(api: sl()));

  // Repository
  sl.registerLazySingleton<ComplaintRepository>(
    () => ComplaintRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAllComplaint(repository: sl()));
  sl.registerLazySingleton(() => AddComplaint(repository: sl()));
}

import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/supabase_service.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/data/repositories/mock_auth_repository.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/bloc/login/login_bloc.dart';
import '../../features/auth/presentation/bloc/signup/signup_bloc.dart';
import '../../features/jobs/data/datasources/job_remote_data_source.dart';
import '../../features/jobs/data/repositories/job_repository_impl.dart';
import '../../features/jobs/data/repositories/mock_job_repository.dart';
import '../../features/jobs/domain/repositories/job_repository.dart';
import '../../features/jobs/presentation/bloc/home/home_bloc.dart';
import '../../features/jobs/presentation/bloc/job_details/job_details_bloc.dart';
import '../../features/preparation/data/repositories/preparation_repository_impl.dart';
import '../../features/preparation/domain/repositories/preparation_repository.dart';
import '../../features/preparation/presentation/bloc/preparation_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Services
  await SupabaseService.initialize();
  // Only register client if initialized, otherwise we rely on Mocks which don't use it
  try {
    sl.registerLazySingleton<SupabaseClient>(() => SupabaseService.client);
  } catch (e) {
    print('SupabaseClient not registered: $e');
  }

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(supabaseClient: sl()),
  );

  // Repositories
  // Using MockAuthRepository for testing/demo purposes if backend is not configured
  sl.registerLazySingleton<AuthRepository>(
    // () => MockAuthRepository(), 
    () => AuthRepositoryImpl(remoteDataSource: sl()), // Uncomment for real backend
  );

  // BLoCs
  sl.registerFactory(() => LoginBloc(authRepository: sl()));
  sl.registerFactory(() => SignupBloc(authRepository: sl()));

  // Jobs Feature
  // sl.registerLazySingleton<JobRemoteDataSource>(
  //   () => JobRemoteDataSource(supabaseClient: sl()),
  // );
  sl.registerLazySingleton<JobRepository>(
     () => MockJobRepository(),
    // () => JobRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerFactory(() => HomeBloc(jobRepository: sl()));
  sl.registerFactory(() => JobDetailsBloc(jobRepository: sl()));

  // Preparation Feature
  sl.registerLazySingleton<PreparationRepository>(
    () => PreparationRepositoryImpl(),
  );
  sl.registerFactory(() => PreparationBloc(repository: sl()));
}

import 'package:ezdu/data/datasources/class_remote_ds.dart';
import 'package:ezdu/data/datasources/feed_remote_ds.dart';
import 'package:ezdu/data/datasources/leaderboard_remote_ds.dart';
import 'package:ezdu/data/datasources/lesson_remote_ds.dart';
import 'package:ezdu/data/datasources/notification_remote_ds.dart';
import 'package:ezdu/data/datasources/question_remote_ds.dart';
import 'package:ezdu/data/datasources/quiz_remote_ds.dart';
import 'package:ezdu/data/datasources/subject_remote_ds.dart';
import 'package:ezdu/data/datasources/user_progress_ds.dart';
import 'package:ezdu/data/datasources/user_quest_remote_ds.dart';
import 'package:ezdu/data/datasources/user_remote_ds.dart';
import 'package:ezdu/data/repositories/archive_repository.dart';
import 'package:ezdu/data/repositories/auth_repository.dart';
import 'package:ezdu/data/repositories/classRepository.dart';
import 'package:ezdu/data/repositories/feed_repository.dart';
import 'package:ezdu/data/repositories/leaderboard_repository.dart';
import 'package:ezdu/data/repositories/lesson_repository.dart';
import 'package:ezdu/data/repositories/notification_repository.dart';
import 'package:ezdu/data/repositories/question_repository.dart';
import 'package:ezdu/data/repositories/quiz_repository.dart';
import 'package:ezdu/data/repositories/subject_repository.dart';
import 'package:ezdu/data/repositories/user_progress_repository.dart';
import 'package:ezdu/data/repositories/user_quest_repository.dart';
import 'package:ezdu/data/repositories/user_repository.dart';
import 'package:ezdu/features/archive/datasources/archive_remote_ds.dart';
import 'package:ezdu/features/auth/datasources/auth_remote_ds.dart';
import 'package:ezdu/features/play/datasources/play_quiz_remote_ds.dart';
import 'package:ezdu/services/dio_client.dart';
import 'package:ezdu/services/storage_service.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<StorageService>(() => StorageService());

  //auth
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      remoteDataSource: sl(),
      storageService: sl(),
      dioClient: sl(),
    ),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl()),
  );

  // user
  sl.registerLazySingleton<UserRepository>(() => UserRepository(sl()));
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSource(sl()),
  );

  // class
  sl.registerLazySingleton<ClassRepository>(
    () => ClassRepository(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ClassRemoteDataSource>(
    () => ClassRemoteDataSource(sl()),
  );

  // subject
  sl.registerLazySingleton<SubjectRepository>(
    () => SubjectRepository(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<SubjectRemoteDataSource>(
    () => SubjectRemoteDataSource(sl()),
  );

  // lesson
  sl.registerLazySingleton<LessonRepository>(
    () => LessonRepository(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<LessonRemoteDataSource>(
    () => LessonRemoteDataSource(sl()),
  );

  // question
  sl.registerLazySingleton<QuestionRepository>(
    () => QuestionRepository(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<QuestionRemoteDataSource>(
    () => QuestionRemoteDataSource(sl()),
  );

  // archive
  sl.registerLazySingleton<ArchiveRepository>(
    () => ArchiveRepository(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ArchiveRemoteDataSource>(
    () => ArchiveRemoteDataSource(sl()),
  );

  // quiz
  sl.registerLazySingleton<QuizRepository>(
    () => QuizRepository(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<QuizRemoteDataSource>(
    () => QuizRemoteDataSource(sl()),
  );

  // progress
  sl.registerLazySingleton<UserProgressRepository>(
    () => UserProgressRepository(sl(), sl()),
  );
  sl.registerLazySingleton<PlayQuizRemoteDataSource>(
    () => PlayQuizRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<UserProgressRemoteDataSource>(
    () => UserProgressRemoteDataSource(sl()),
  );

  // quiz
  sl.registerLazySingleton<LeaderboardRepository>(
    () => LeaderboardRepository(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<LeaderboardRemoteDataSource>(
    () => LeaderboardRemoteDataSource(sl()),
  );

  // notification
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepository(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSource(sl()),
  );

  // feed
  sl.registerLazySingleton<FeedRepository>(
    () => FeedRepository(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<FeedRemoteDataSource>(
    () => FeedRemoteDataSource(sl()),
  );

  // user quest
  sl.registerLazySingleton<UserQuestRepository>(
    () => UserQuestRepository(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<UserQuestRemoteDataSource>(
    () => UserQuestRemoteDataSource(sl()),
  );

  print('Dependency Injection initialized.');
}

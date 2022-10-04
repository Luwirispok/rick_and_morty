import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/failures.dart';

//абстрактный класс, который создаст шаблон для остальных UseCases
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

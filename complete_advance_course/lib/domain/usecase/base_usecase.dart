import 'package:complete_advance_course/data/network/failure.dart';
import 'package:dartz/dartz.dart';

// generic class
abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
  
}

import 'package:complete_advance_course/app/extensions.dart';
import 'package:complete_advance_course/data/responses/responses.dart';
import 'package:complete_advance_course/domain/model/model.dart';

const EMPTY = "";
const ZERO = 0;

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id?.onEmpty() ?? EMPTY,
        this?.name?.onEmpty() ?? EMPTY,
        this?.numOfNotifications?.onZero() ?? ZERO);
  }
}

extension ContactResponseMapper on ContactResponse? {
  Contact toDomain() {
    return Contact(this?.email?.onEmpty() ?? EMPTY,
        this?.phone?.onEmpty() ?? EMPTY, this?.link?.onEmpty() ?? EMPTY);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
        this?.customer?.toDomain(), this?.contects?.toDomain());
  }
}

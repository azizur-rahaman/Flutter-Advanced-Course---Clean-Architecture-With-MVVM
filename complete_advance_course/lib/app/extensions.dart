// extensions on string

import 'package:complete_advance_course/data/mapper/mapper.dart';

extension NonNullString on String? {
  String onEmpty() {
    if (this == null) {
      return EMPTY;
    } else {
      return this!;
    }
  }
}

extension NonNullInt on int? {
  int onZero() {
    if (this == null) {
      return ZERO;
    } else {
      return this!;
    }
  }
}

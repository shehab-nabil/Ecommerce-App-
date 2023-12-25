import '../../app/constants.dart';
import '../../app/extension.dart';
import '../response/responses.dart';
import '../../domain/models/models.dart';

extension CustomerRsponseMapper on CustomerResponse? {
  CustomerModel toDomain() {
    return CustomerModel(
        this?.id.orEmpty() ?? Constants.empty,
        this?.name.orEmpty() ?? Constants.empty,
        this?.numOfNotifications.orZero() ?? Constants.zero);
  }
}

extension ContactsRsponseMapper on ContactsResponse? {
  ContactsModel toDomain() {
    return ContactsModel(
        this?.phone.orEmpty() ?? Constants.empty,
        this?.email.orEmpty() ?? Constants.empty,
        this?.link.orEmpty() ?? Constants.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  AuthenticationModel toDomain() {
    return AuthenticationModel(
        this?.customer.toDomain(), this?.contacts.toDomain());
  }
}

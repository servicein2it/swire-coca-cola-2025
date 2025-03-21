import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "department" field.
  String? _department;
  String get department => _department ?? '';
  bool hasDepartment() => _department != null;

  // "My_calendar" field.
  List<DocumentReference>? _myCalendar;
  List<DocumentReference> get myCalendar => _myCalendar ?? const [];
  bool hasMyCalendar() => _myCalendar != null;

  // "QR_code" field.
  String? _qRCode;
  String get qRCode => _qRCode ?? '';
  bool hasQRCode() => _qRCode != null;

  // "favorite" field.
  List<DocumentReference>? _favorite;
  List<DocumentReference> get favorite => _favorite ?? const [];
  bool hasFavorite() => _favorite != null;

  // "Photo" field.
  String? _photo;
  String get photo => _photo ?? '';
  bool hasPhoto() => _photo != null;

  // "OfficeBasedCountry" field.
  String? _officeBasedCountry;
  String get officeBasedCountry => _officeBasedCountry ?? '';
  bool hasOfficeBasedCountry() => _officeBasedCountry != null;

  // "Check_in_Date" field.
  String? _checkInDate;
  String get checkInDate => _checkInDate ?? '';
  bool hasCheckInDate() => _checkInDate != null;

  // "Check_out_Date" field.
  String? _checkOutDate;
  String get checkOutDate => _checkOutDate ?? '';
  bool hasCheckOutDate() => _checkOutDate != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "Activity" field.
  String? _activity;
  String get activity => _activity ?? '';
  bool hasActivity() => _activity != null;

  // "Polo_shirts_Size" field.
  String? _poloShirtsSize;
  String get poloShirtsSize => _poloShirtsSize ?? '';
  bool hasPoloShirtsSize() => _poloShirtsSize != null;

  // "activityurl" field.
  String? _activityurl;
  String get activityurl => _activityurl ?? '';
  bool hasActivityurl() => _activityurl != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  void _initializeFields() {
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _department = snapshotData['department'] as String?;
    _myCalendar = getDataList(snapshotData['My_calendar']);
    _qRCode = snapshotData['QR_code'] as String?;
    _favorite = getDataList(snapshotData['favorite']);
    _photo = snapshotData['Photo'] as String?;
    _officeBasedCountry = snapshotData['OfficeBasedCountry'] as String?;
    _checkInDate = snapshotData['Check_in_Date'] as String?;
    _checkOutDate = snapshotData['Check_out_Date'] as String?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _activity = snapshotData['Activity'] as String?;
    _poloShirtsSize = snapshotData['Polo_shirts_Size'] as String?;
    _activityurl = snapshotData['activityurl'] as String?;
    _email = snapshotData['email'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? department,
  String? qRCode,
  String? photo,
  String? officeBasedCountry,
  String? checkInDate,
  String? checkOutDate,
  String? phoneNumber,
  String? activity,
  String? poloShirtsSize,
  String? activityurl,
  String? email,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'department': department,
      'QR_code': qRCode,
      'Photo': photo,
      'OfficeBasedCountry': officeBasedCountry,
      'Check_in_Date': checkInDate,
      'Check_out_Date': checkOutDate,
      'phone_number': phoneNumber,
      'Activity': activity,
      'Polo_shirts_Size': poloShirtsSize,
      'activityurl': activityurl,
      'email': email,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.department == e2?.department &&
        listEquality.equals(e1?.myCalendar, e2?.myCalendar) &&
        e1?.qRCode == e2?.qRCode &&
        listEquality.equals(e1?.favorite, e2?.favorite) &&
        e1?.photo == e2?.photo &&
        e1?.officeBasedCountry == e2?.officeBasedCountry &&
        e1?.checkInDate == e2?.checkInDate &&
        e1?.checkOutDate == e2?.checkOutDate &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.activity == e2?.activity &&
        e1?.poloShirtsSize == e2?.poloShirtsSize &&
        e1?.activityurl == e2?.activityurl &&
        e1?.email == e2?.email;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.department,
        e?.myCalendar,
        e?.qRCode,
        e?.favorite,
        e?.photo,
        e?.officeBasedCountry,
        e?.checkInDate,
        e?.checkOutDate,
        e?.phoneNumber,
        e?.activity,
        e?.poloShirtsSize,
        e?.activityurl,
        e?.email
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}

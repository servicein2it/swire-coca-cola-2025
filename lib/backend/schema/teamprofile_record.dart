import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TeamprofileRecord extends FirestoreRecord {
  TeamprofileRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "team_name" field.
  String? _teamName;
  String get teamName => _teamName ?? '';
  bool hasTeamName() => _teamName != null;

  // "team_position" field.
  String? _teamPosition;
  String get teamPosition => _teamPosition ?? '';
  bool hasTeamPosition() => _teamPosition != null;

  // "team_year" field.
  String? _teamYear;
  String get teamYear => _teamYear ?? '';
  bool hasTeamYear() => _teamYear != null;

  // "team_country" field.
  String? _teamCountry;
  String get teamCountry => _teamCountry ?? '';
  bool hasTeamCountry() => _teamCountry != null;

  // "country" field.
  List<String>? _country;
  List<String> get country => _country ?? const [];
  bool hasCountry() => _country != null;

  // "department_team" field.
  String? _departmentTeam;
  String get departmentTeam => _departmentTeam ?? '';
  bool hasDepartmentTeam() => _departmentTeam != null;

  // "team_group" field.
  String? _teamGroup;
  String get teamGroup => _teamGroup ?? '';
  bool hasTeamGroup() => _teamGroup != null;

  void _initializeFields() {
    _photoUrl = snapshotData['photo_url'] as String?;
    _teamName = snapshotData['team_name'] as String?;
    _teamPosition = snapshotData['team_position'] as String?;
    _teamYear = snapshotData['team_year'] as String?;
    _teamCountry = snapshotData['team_country'] as String?;
    _country = getDataList(snapshotData['country']);
    _departmentTeam = snapshotData['department_team'] as String?;
    _teamGroup = snapshotData['team_group'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('teamprofile');

  static Stream<TeamprofileRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TeamprofileRecord.fromSnapshot(s));

  static Future<TeamprofileRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TeamprofileRecord.fromSnapshot(s));

  static TeamprofileRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TeamprofileRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TeamprofileRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TeamprofileRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TeamprofileRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TeamprofileRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTeamprofileRecordData({
  String? photoUrl,
  String? teamName,
  String? teamPosition,
  String? teamYear,
  String? teamCountry,
  String? departmentTeam,
  String? teamGroup,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'photo_url': photoUrl,
      'team_name': teamName,
      'team_position': teamPosition,
      'team_year': teamYear,
      'team_country': teamCountry,
      'department_team': departmentTeam,
      'team_group': teamGroup,
    }.withoutNulls,
  );

  return firestoreData;
}

class TeamprofileRecordDocumentEquality implements Equality<TeamprofileRecord> {
  const TeamprofileRecordDocumentEquality();

  @override
  bool equals(TeamprofileRecord? e1, TeamprofileRecord? e2) {
    const listEquality = ListEquality();
    return e1?.photoUrl == e2?.photoUrl &&
        e1?.teamName == e2?.teamName &&
        e1?.teamPosition == e2?.teamPosition &&
        e1?.teamYear == e2?.teamYear &&
        e1?.teamCountry == e2?.teamCountry &&
        listEquality.equals(e1?.country, e2?.country) &&
        e1?.departmentTeam == e2?.departmentTeam &&
        e1?.teamGroup == e2?.teamGroup;
  }

  @override
  int hash(TeamprofileRecord? e) => const ListEquality().hash([
        e?.photoUrl,
        e?.teamName,
        e?.teamPosition,
        e?.teamYear,
        e?.teamCountry,
        e?.country,
        e?.departmentTeam,
        e?.teamGroup
      ]);

  @override
  bool isValidKey(Object? o) => o is TeamprofileRecord;
}

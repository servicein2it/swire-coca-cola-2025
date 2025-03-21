import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SessionRecord extends FirestoreRecord {
  SessionRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "session_id" field.
  String? _sessionId;
  String get sessionId => _sessionId ?? '';
  bool hasSessionId() => _sessionId != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "session_name" field.
  String? _sessionName;
  String get sessionName => _sessionName ?? '';
  bool hasSessionName() => _sessionName != null;

  // "session_description" field.
  String? _sessionDescription;
  String get sessionDescription => _sessionDescription ?? '';
  bool hasSessionDescription() => _sessionDescription != null;

  // "session_speaker" field.
  String? _sessionSpeaker;
  String get sessionSpeaker => _sessionSpeaker ?? '';
  bool hasSessionSpeaker() => _sessionSpeaker != null;

  // "session_date" field.
  String? _sessionDate;
  String get sessionDate => _sessionDate ?? '';
  bool hasSessionDate() => _sessionDate != null;

  // "session_time" field.
  String? _sessionTime;
  String get sessionTime => _sessionTime ?? '';
  bool hasSessionTime() => _sessionTime != null;

  // "date" field.
  List<String>? _date;
  List<String> get date => _date ?? const [];
  bool hasDate() => _date != null;

  // "date_number" field.
  int? _dateNumber;
  int get dateNumber => _dateNumber ?? 0;
  bool hasDateNumber() => _dateNumber != null;

  // "position" field.
  String? _position;
  String get position => _position ?? '';
  bool hasPosition() => _position != null;

  void _initializeFields() {
    _sessionId = snapshotData['session_id'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _sessionName = snapshotData['session_name'] as String?;
    _sessionDescription = snapshotData['session_description'] as String?;
    _sessionSpeaker = snapshotData['session_speaker'] as String?;
    _sessionDate = snapshotData['session_date'] as String?;
    _sessionTime = snapshotData['session_time'] as String?;
    _date = getDataList(snapshotData['date']);
    _dateNumber = castToType<int>(snapshotData['date_number']);
    _position = snapshotData['position'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Session');

  static Stream<SessionRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SessionRecord.fromSnapshot(s));

  static Future<SessionRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SessionRecord.fromSnapshot(s));

  static SessionRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SessionRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SessionRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SessionRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SessionRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SessionRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSessionRecordData({
  String? sessionId,
  String? photoUrl,
  String? sessionName,
  String? sessionDescription,
  String? sessionSpeaker,
  String? sessionDate,
  String? sessionTime,
  int? dateNumber,
  String? position,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'session_id': sessionId,
      'photo_url': photoUrl,
      'session_name': sessionName,
      'session_description': sessionDescription,
      'session_speaker': sessionSpeaker,
      'session_date': sessionDate,
      'session_time': sessionTime,
      'date_number': dateNumber,
      'position': position,
    }.withoutNulls,
  );

  return firestoreData;
}

class SessionRecordDocumentEquality implements Equality<SessionRecord> {
  const SessionRecordDocumentEquality();

  @override
  bool equals(SessionRecord? e1, SessionRecord? e2) {
    const listEquality = ListEquality();
    return e1?.sessionId == e2?.sessionId &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.sessionName == e2?.sessionName &&
        e1?.sessionDescription == e2?.sessionDescription &&
        e1?.sessionSpeaker == e2?.sessionSpeaker &&
        e1?.sessionDate == e2?.sessionDate &&
        e1?.sessionTime == e2?.sessionTime &&
        listEquality.equals(e1?.date, e2?.date) &&
        e1?.dateNumber == e2?.dateNumber &&
        e1?.position == e2?.position;
  }

  @override
  int hash(SessionRecord? e) => const ListEquality().hash([
        e?.sessionId,
        e?.photoUrl,
        e?.sessionName,
        e?.sessionDescription,
        e?.sessionSpeaker,
        e?.sessionDate,
        e?.sessionTime,
        e?.date,
        e?.dateNumber,
        e?.position
      ]);

  @override
  bool isValidKey(Object? o) => o is SessionRecord;
}

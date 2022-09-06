/// identityId : 107969136049704
/// identity : "代理人"

class ScUserIdentity {
  ScUserIdentity({
    String? identityId,
    String? identity,
  }) {
    _identityId = identityId;
    _identity = identity;
  }

  ScUserIdentity.fromJson(dynamic json) {
    _identityId = json['identityId'];
    _identity = json['identity'];
  }

  String? _identityId;
  String? _identity;

  ScUserIdentity copyWith({
    String? identityId,
    String? identity,
  }) =>
      ScUserIdentity(
        identityId: identityId ?? _identityId,
        identity: identity ?? _identity,
      );

  String? get identityId => _identityId;

  String? get identity => _identity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['identityId'] = _identityId;
    map['identity'] = _identity;
    return map;
  }

  @override
  String toString() {
    return 'ScUserIdentity{_identityId: $_identityId, _identity: $_identity}';
  }
}

class RemoveMemberRequest {
  const RemoveMemberRequest({
    required this.groupId,
    required this.requestingUserId,
    required this.targetUserId,
  });

  factory RemoveMemberRequest.fromJson(Map<String, dynamic> json) =>
      RemoveMemberRequest(
        groupId: json['groupId'] as String,
        requestingUserId: json['requestingUserId'] as String,
        targetUserId: json['targetUserId'] as String,
      );

  final String groupId;
  final String requestingUserId;
  final String targetUserId;

  RemoveMemberRequest copyWith({
    String? groupId,
    String? requestingUserId,
    String? targetUserId,
  }) {
    return RemoveMemberRequest(
      groupId: groupId ?? this.groupId,
      requestingUserId: requestingUserId ?? this.requestingUserId,
      targetUserId: targetUserId ?? this.targetUserId,
    );
  }
}

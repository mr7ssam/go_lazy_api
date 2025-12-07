class DeleteGroupRequest {
  const DeleteGroupRequest({
    required this.groupId,
    required this.userId,
  });

  final String groupId;
  final String userId;

  DeleteGroupRequest copyWith({
    String? groupId,
    String? userId,
  }) {
    return DeleteGroupRequest(
      groupId: groupId ?? this.groupId,
      userId: userId ?? this.userId,
    );
  }
}

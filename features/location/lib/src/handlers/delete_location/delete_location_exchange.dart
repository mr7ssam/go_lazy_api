/// Request to delete a saved location.
class DeleteLocationRequest {
  const DeleteLocationRequest({
    required this.locationId,
    this.userId,
    this.groupId,
  });

  final int locationId;
  final String? userId;
  final String? groupId;
}

/// Response confirming deletion.
class DeleteLocationResponse {
  const DeleteLocationResponse({required this.message});

  final String message;

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}

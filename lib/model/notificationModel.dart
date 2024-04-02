// ignore: file_names
class NotificationResponse {
  final int success;
  final int total;
  final NotificationData notifications;

  NotificationResponse({
    required this.success,
    required this.total,
    required this.notifications,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      success: json['success'] as int,
      total: json['total'] as int,
      notifications: NotificationData.fromJson(json['notifications']),
    );
  }
}

class NotificationData {
  final int currentPage;
  final List<NotificationItem> data;

  NotificationData({
    required this.currentPage,
    required this.data,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      currentPage: json['current_page'] as int,
      data: (json['data'] as List)
          .map((item) => NotificationItem.fromJson(item))
          .toList(),
    );
  }
}

class NotificationItem {
  final int id;
  final int notificationFrom;
  final String title;
  final String message;
  final String notificationType;
  final int notificationTo;
  final String notificationToType;
  final int orderId;
  final int isReaded;
  final String icon;
  final String createdAt;
  final String updatedAt;

  NotificationItem({
    required this.id,
    required this.notificationFrom,
    required this.title,
    required this.message,
    required this.notificationType,
    required this.notificationTo,
    required this.notificationToType,
    required this.orderId,
    required this.isReaded,
    required this.icon,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'] as int,
      notificationFrom: json['notification_from'] as int,
      title: json['title'] as String,
      message: json['message'] as String,
      notificationType: json['notification_type'] as String,
      notificationTo: json['notification_to'] as int,
      notificationToType: json['notification_to_type'] as String,
      orderId: json['order_id'] as int,
      isReaded: json['is_readed'] as int,
      icon: json['icon'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }
}

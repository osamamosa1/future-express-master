part of 'notification_cubit.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationsNewOrder extends NotificationState {}

class MessageReceivedState extends NotificationState {
  final RemoteMessage message;

  const MessageReceivedState(this.message);
}

class NotificationFetched extends NotificationState {
  final List<NotificationItem> notifications;

  const NotificationFetched(this.notifications);

  @override
  List<Object> get props => [notifications];
}

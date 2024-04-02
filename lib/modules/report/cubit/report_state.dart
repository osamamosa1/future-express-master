part of 'report_cubit.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

class ClientSuccess extends ReportState {}

class ClientLoad extends ReportState {}

class ClientLoadFailed extends ReportState {}

class ReportLoading extends ReportState {}

class ReportLoadSuccess extends ReportState {}

class ReportLoadFailed extends ReportState {}

class SendReportLoading extends ReportState {}

class SendReportLoadSuccess extends ReportState {}

class SendReportLoadFailed extends ReportState {}

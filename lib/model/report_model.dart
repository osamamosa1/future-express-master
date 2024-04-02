class ReportEntry {
  final int id;
  final String delegateCode;
  final String delegateCity;
  final String? clientName;
  final String delegateName;
  final int recipient;
  final int received;
  final int returned;
  final double total;
  final String date;

  ReportEntry({
    required this.id,
    required this.delegateCode,
    required this.delegateCity,
    required this.clientName,
    required this.delegateName,
    required this.recipient,
    required this.received,
    required this.returned,
    required this.total,
    required this.date,
  });

  factory ReportEntry.fromJson(Map<String, dynamic> json) {
    return ReportEntry(
      id: json['id'],
      delegateCode: json['delegate_code'],
      delegateCity: json['delegate_city'],
      clientName: json['client_name'],
      delegateName: json['delegate_name'],
      recipient: json['Recipient'],
      received: json['Received'],
      returned: json['Returned'],
      total: double.parse(json['total']),
      date: json['date'],
    );
  }
}

class ReportResponse {
  final List<ReportEntry> data;

  ReportResponse({required this.data});

  factory ReportResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> reportData = json['data'];
    List<ReportEntry> reportEntries =
        reportData.map((item) => ReportEntry.fromJson(item)).toList();
    return ReportResponse(data: reportEntries);
  }
}

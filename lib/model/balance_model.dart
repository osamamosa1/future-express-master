class BalanceEntry {
  final int id;
  final String description;
  final double debtor;
  final double creditor;
  final String order;
  final String date;

  BalanceEntry({
    required this.id,
    required this.description,
    required this.debtor,
    required this.creditor,
    required this.order,
    required this.date,
  });

  factory BalanceEntry.fromJson(Map<String, dynamic> json) {
    return BalanceEntry(
      id: json['id'] ?? '',
      description: json['description'] ?? '',
      debtor: double.parse(json['debtor'] ?? '0'),
      creditor: double.parse(json['creditor'] ?? '0'),
      order: json['order'] ?? '',
      date: json['date'] ?? '',
    );
  }
}

class BalanceResponse {
  final List<BalanceEntry> balance;

  BalanceResponse({required this.balance});

  factory BalanceResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> balanceData = json['balance'];
    List<BalanceEntry> balanceEntries =
        balanceData.map((item) => BalanceEntry.fromJson(item)).toList();
    return BalanceResponse(balance: balanceEntries);
  }
}

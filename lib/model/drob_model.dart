class DropItems {
  int? id;
  String? title;
  int? isOtp;

  DropItems({
    this.id,
    this.title,
    this.isOtp,
  });

  DropItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isOtp = json['is_otp']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['is_otp'] = isOtp;

    return data;
  }
}

class Details {
  Map<dynamic, dynamic>? data;
  int dayOrder = 1;

  Details._privateConstructor();

  static final Details _instance = Details._privateConstructor();

  factory Details() {
    return _instance;
  }

  void setData(Map<dynamic, dynamic> data) {
    this.data = data;
  }

  Map<dynamic, dynamic> getData() {
    return data!;
  }

  void setDayOrder(int day) {
    dayOrder = day;
  }

  int getDayOrder() {
    return dayOrder;
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Exchange {
  final double exchange; //환율
  final String date; //기준 날짜
  final String time; //기준 시간

  Exchange({
    required this.exchange,
    required this.date,
    required this.time,
  });
}

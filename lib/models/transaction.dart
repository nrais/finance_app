class TransactionModel {
  final String title;
  final String amount;
  final String category;
  final DateTime date;

  TransactionModel(this.title, this.amount, this.category, {DateTime? date})
    : date = date ?? DateTime.now();
}

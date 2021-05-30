import 'package:equatable/equatable.dart';

class PaymentMethodUsed extends Equatable {

  const PaymentMethodUsed({
    this.type = '',
    this.account = ''
  });
  
  final String type;
  final String account;

  static const empty = PaymentMethodUsed(type: '', account: '');

  bool get isEmpty => this == PaymentMethodUsed.empty;

  bool get isNotEmpty => this != PaymentMethodUsed.empty;

  @override
  List<Object?> get props => [type, account];

  factory PaymentMethodUsed.fromJson(Map<String, dynamic>? json) {
    return PaymentMethodUsed(
      type: json?['type'],
      account: json?['account']
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'account': account
    };
  }
}
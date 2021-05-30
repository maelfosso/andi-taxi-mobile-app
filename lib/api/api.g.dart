// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<UserCode> SignUpClient(name, phone) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'name': name, 'phoneNumber': phone};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserCode>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/auth/signup/client',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserCode.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserCode> SignUpDriver(name, phoneNumber, rcIdentificationNumber,
      residenceAddress, realResidenceAddress, car) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'name': name,
      'phoneNumber': phoneNumber,
      'rcIdentificationNumber': rcIdentificationNumber,
      'residenceAddress': residenceAddress,
      'realResidenceAddress': realResidenceAddress,
      'car': car
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserCode>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/auth/signup/driver',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserCode.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserCode> SignIn(phoneNumber) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'phoneNumber': phoneNumber};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserCode>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/auth/signin',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserCode.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserToken> SignCode(phoneNumber, code) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'phoneNumber': phoneNumber, 'code': code};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserToken>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/auth/signcode',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserToken.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<UserPosition>> GetLastLocations() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<UserPosition>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/booking/last-locations',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => UserPosition.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Car>> GetTaxiAround(position) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'position': position};
    final _result = await _dio.fetch<List<dynamic>>(_setStreamType<List<Car>>(
        Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/booking/taxi-around',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Car.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<double>> CalculateCostTime(from, to, distance) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'from': from, 'to': to, 'distance': distance};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<double>>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/booking/cost-time',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!.cast<double>();
    return value;
  }

  @override
  Future<List<PaymentMethodUsed>> GetPaymentMethodsUsed() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<PaymentMethodUsed>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/booking/payment-methods-used',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) =>
            PaymentMethodUsed.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}

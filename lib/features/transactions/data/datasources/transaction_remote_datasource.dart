import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';
import '../models/transaction_model.dart';

abstract class TransactionRemoteDataSource {
  Future<List<TransactionModel>> getTransactions();

  Future<TransactionModel> addTransaction(Map<String, dynamic> data);

  Future<void> deleteTransaction(String id);
}

@Injectable(as: TransactionRemoteDataSource)
class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final Dio dio;

  TransactionRemoteDataSourceImpl(this.dio);

  @override
  Future<List<TransactionModel>> getTransactions() async {
    try {
      final response = await dio.get('/transactions');
      return (response.data as List)
          .map((e) => TransactionModel.fromJson(e))
          .toList();
    } on DioException {
      throw const ServerException();
    }
  }

  @override
  Future<TransactionModel> addTransaction(Map<String, dynamic> data) async {
    try {
      final response = await dio.post('/transactions', data: data);
      return TransactionModel.fromJson(response.data);
    } on DioException {
      throw const ServerException();
    }
  }

  @override
  Future<void> deleteTransaction(String id) async {
    try {
      await dio.delete('/transactions/$id');
    } on DioException {
      throw const ServerException();
    }
  }
}

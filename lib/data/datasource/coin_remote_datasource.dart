import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/network/dio_client.dart';
import 'package:flutter_application_1/data/datasource/coin_datasource.dart';
import 'package:flutter_application_1/data/dtos/crypto_dto.dart';
import 'package:flutter_application_1/data/mappers/crypto_mapper.dart';
import 'package:flutter_application_1/domain/entities/crypto.dart';

class CoinRemoteDatasource extends CoinDatasource {
  final Dio dioClient;
  CoinRemoteDatasource({required this.dioClient});
  @override
  Future<List<CryptoEntity>> getCoinList() async {
    try {
      var response = await dioClient.get(
          'https://rest.coincap.io/v3/assets?apiKey=658ec474b1f482e18ab745c9b26c4cb4a9a4f31486679c749c0e65b8d9b1ab25');
      List<CryptoDTO> cryptoList = response.data['data']
          .map<CryptoDTO>(
              (jsonMapObject) => CryptoDTO.fromMapJson(jsonMapObject))
          .toList();

      return CryptoMapper.toDomainList(cryptoList);
    } catch (DioError) {
      throw Exception('Failed to load coin list');
    }
  }
}

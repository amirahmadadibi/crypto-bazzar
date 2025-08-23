class CryptoDTO {
  String id;
  String name;
  String symbol;
  String changePercent24hr;
  String priceUsd;
  String marketCapUsd;
  String rank;

  CryptoDTO(
    this.id,
    this.name,
    this.symbol,
    this.changePercent24hr,
    this.priceUsd,
    this.marketCapUsd,
    this.rank,
  );

  factory CryptoDTO.fromMapJson(Map<String, dynamic> jsonMapObject) {
    return CryptoDTO(
      jsonMapObject['id'],
      jsonMapObject['name'],
      jsonMapObject['symbol'],
      jsonMapObject['changePercent24Hr'],
      jsonMapObject['priceUsd'],
      jsonMapObject['marketCapUsd'],
      jsonMapObject['rank'],
    );
  }
}

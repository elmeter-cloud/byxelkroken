class KrokStep {
  final KrokType type;
  final String title;
  final String? imageProceedTo;
  final String imageNearby;
  final String promptNearby;
  final String? qrData;

  KrokStep({
    this.type = KrokType.visit,
    required this.title,
    required this.imageNearby,
    this.imageProceedTo,
    required this.promptNearby,
    this.qrData,
  });
}

enum KrokType {
  visit,
  qrVoucher,
}
class BetterPlayerVideoConstraint {
  final int? width;
  final int? height;
  final int? bitrate;

  const BetterPlayerVideoConstraint({this.width, this.height, this.bitrate});

  Map<String, int> toMap() {
    return {
      'width': width ?? 0,
      'height': height ?? 0,
      'bitrate': bitrate ?? 0,
    };
  }
}

class Song
{
  final String name;
  final String artistName;
  final String duration;

  Song({this.name, this.artistName, this.duration});

  String get songName => name;
  String get by => artistName;
  String get length => duration;
}
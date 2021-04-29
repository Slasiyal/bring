extension StringExt on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach => this.splitMapJoin(RegExp(r'\w+'),onMatch: (m)=> '${m.group(0)}'.substring(0,1).toUpperCase() +'${m.group(0)}'.substring(1).toLowerCase() ,onNonMatch: (n)=> ' ');
}
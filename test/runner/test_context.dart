class TestContext {
  final String operatingSystem;
  final String puppeteerUrl;

  TestContext({required this.puppeteerUrl, required this.operatingSystem});

  factory TestContext.fromJson(Map<String, dynamic> json) => TestContext(
        puppeteerUrl: json['puppeteerUrl']! as String,
        operatingSystem: json['operatingSystem']! as String,
      );

  Map<String, dynamic> toJson() => {
        'puppeteerUrl': puppeteerUrl,
        'operatingSystem': operatingSystem,
      };
}

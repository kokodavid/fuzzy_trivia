enum Endpoints {
  basic('/api/questions?limit=10'),
  premium('');

  final String path;

  const Endpoints(this.path);
}

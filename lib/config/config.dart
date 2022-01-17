String get apiUrl => const String.fromEnvironment(
      'API_URL',
      defaultValue: 'http://localhost/api/',
    );

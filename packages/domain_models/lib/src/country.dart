enum Country {
  sierraLeone(
    name: 'Sierra Leone',
    flag: '🇸🇱',
    code: '+232',
    maxLength: 8,
    networkCodeLength: 2,
    networkCodes: [
      '76',
      '77',
      '78',
      '79',
      '75',
      '74',
      '73',
      '30',
      '31',
      '33',
      '34',
      '88',
      '99',
      '90',
    ],
  ),
  nigeria(
    name: 'Nigeria',
    flag: '🇳🇬',
    code: '+234',
    maxLength: 10,
    networkCodeLength: 3,
    networkCodes: ['803', '805', '806', '807', '703', '705'],
  ),
  ghana(
    name: 'Ghana',
    flag: '🇬🇭',
    code: '+233',
    maxLength: 9,
    networkCodeLength: 2,
    networkCodes: ['24', '54', '55', '20', '50'],
  ),
  unitedStates(
    name: 'United States',
    flag: '🇺🇸',
    code: '+1',
    maxLength: 10,
    networkCodeLength: 3,
  ),
  unitedKingdom(
    name: 'United Kingdom',
    flag: '🇬🇧',
    code: '+44',
    maxLength: 10,
    networkCodeLength: 4,
  ),
  canada(
    name: 'Canada',
    flag: '🇨🇦',
    code: '+1',
    maxLength: 10,
    networkCodeLength: 3,
  );

  const Country({
    required this.name,
    required this.flag,
    required this.code,
    required this.maxLength,
    this.networkCodeLength = 0,
    this.networkCodes,
  });

  final String name;
  final String flag;
  final String code;
  final int maxLength;
  final int networkCodeLength;
  final List<String>? networkCodes;
}

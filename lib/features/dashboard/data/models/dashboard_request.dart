/// Request model for dashboard-related API calls.
/// This model handles data that needs to be sent to the server.
///
/// Usage Example:
/// ```dart
/// // Create request for refreshing dashboard data
/// final request = DashboardRequest(
///   userId: 'user123',
///   forceRefresh: true,
///   includeTransactions: true,
/// );
///
/// // Convert to JSON for API call
/// final jsonData = request.toJson();
/// await apiClient.post('/dashboard/refresh', data: jsonData);
/// ```
class DashboardRequest {
  /// User identifier for the request
  final String userId;

  /// Whether to force refresh data from server (bypass cache)
  final bool forceRefresh;

  /// Whether to include recent transactions in the response
  final bool includeTransactions;

  /// Number of recent transactions to include (default: 10)
  final int transactionLimit;

  /// Date range for data retrieval (optional)
  final DateTime? startDate;
  final DateTime? endDate;

  const DashboardRequest({
    required this.userId,
    this.forceRefresh = false,
    this.includeTransactions = true,
    this.transactionLimit = 10,
    this.startDate,
    this.endDate,
  });

  /// Creates a DashboardRequest from JSON data.
  /// This method handles incoming request data parsing.
  ///
  /// Parameters:
  /// - [json]: Map containing request data from client
  ///
  /// Returns:
  /// - [DashboardRequest]: Parsed request instance
  ///
  /// Usage Example:
  /// ```dart
  /// final requestData = jsonDecode(requestBody);
  /// final request = DashboardRequest.fromJson(requestData);
  /// ```
  factory DashboardRequest.fromJson(Map<String, dynamic> json) {
    return DashboardRequest(
      userId: json['user_id']?.toString() ?? '',
      forceRefresh: json['force_refresh'] == true,
      includeTransactions: json['include_transactions'] ?? true,
      transactionLimit: json['transaction_limit'] ?? 10,
      startDate: json['start_date'] != null
          ? DateTime.tryParse(json['start_date'].toString())
          : null,
      endDate: json['end_date'] != null
          ? DateTime.tryParse(json['end_date'].toString())
          : null,
    );
  }

  /// Converts DashboardRequest to JSON format.
  /// This method prepares request data for API calls.
  ///
  /// Returns:
  /// - [Map<String, dynamic>]: JSON representation of request data
  ///
  /// Usage Example:
  /// ```dart
  /// final request = DashboardRequest(userId: 'user123');
  /// final jsonData = request.toJson();
  /// await apiClient.get('/dashboard', queryParameters: jsonData);
  /// ```
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'user_id': userId,
      'force_refresh': forceRefresh,
      'include_transactions': includeTransactions,
      'transaction_limit': transactionLimit,
    };

    // Add date range if provided
    if (startDate != null) {
      json['start_date'] = startDate!.toIso8601String();
    }
    if (endDate != null) {
      json['end_date'] = endDate!.toIso8601String();
    }

    return json;
  }

  /// Creates a copy of DashboardRequest with updated fields.
  /// This method enables immutable updates to request parameters.
  ///
  /// Parameters:
  /// - [userId]: Optional new user ID
  /// - [forceRefresh]: Optional new force refresh flag
  /// - [includeTransactions]: Optional new include transactions flag
  /// - [transactionLimit]: Optional new transaction limit
  /// - [startDate]: Optional new start date
  /// - [endDate]: Optional new end date
  ///
  /// Returns:
  /// - [DashboardRequest]: New instance with updated fields
  ///
  /// Usage Example:
  /// ```dart
  /// final originalRequest = DashboardRequest(userId: 'user123');
  /// final updatedRequest = originalRequest.copyWith(
  ///   forceRefresh: true,
  ///   transactionLimit: 20,
  /// );
  /// ```
  DashboardRequest copyWith({
    String? userId,
    bool? forceRefresh,
    bool? includeTransactions,
    int? transactionLimit,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return DashboardRequest(
      userId: userId ?? this.userId,
      forceRefresh: forceRefresh ?? this.forceRefresh,
      includeTransactions: includeTransactions ?? this.includeTransactions,
      transactionLimit: transactionLimit ?? this.transactionLimit,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  /// Validates the request data for completeness and correctness.
  /// This method ensures all required fields are present and valid.
  ///
  /// Returns:
  /// - [bool]: True if request is valid, false otherwise
  ///
  /// Usage Example:
  /// ```dart
  /// final request = DashboardRequest(userId: 'user123');
  /// if (!request.isValid) {
  ///   throw ValidationException('Invalid request data');
  /// }
  /// ```
  bool get isValid {
    // Check required fields
    if (userId.isEmpty) return false;

    // Check transaction limit is positive
    if (transactionLimit <= 0) return false;

    // Check date range is valid
    if (startDate != null && endDate != null) {
      if (startDate!.isAfter(endDate!)) return false;
    }

    return true;
  }

  /// Gets query parameters for HTTP GET requests.
  /// This method formats the request data as URL query parameters.
  ///
  /// Returns:
  /// - [Map<String, String>]: Query parameters for HTTP requests
  ///
  /// Usage Example:
  /// ```dart
  /// final request = DashboardRequest(userId: 'user123');
  /// final queryParams = request.getQueryParameters();
  /// final response = await httpClient.get('/dashboard', queryParameters: queryParams);
  /// ```
  Map<String, String> getQueryParameters() {
    final params = <String, String>{
      'user_id': userId,
      'force_refresh': forceRefresh.toString(),
      'include_transactions': includeTransactions.toString(),
      'transaction_limit': transactionLimit.toString(),
    };

    // Add date range if provided
    if (startDate != null) {
      params['start_date'] = startDate!.toIso8601String();
    }
    if (endDate != null) {
      params['end_date'] = endDate!.toIso8601String();
    }

    return params;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardRequest &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          forceRefresh == other.forceRefresh &&
          includeTransactions == other.includeTransactions &&
          transactionLimit == other.transactionLimit &&
          startDate == other.startDate &&
          endDate == other.endDate;

  @override
  int get hashCode =>
      userId.hashCode ^
      forceRefresh.hashCode ^
      includeTransactions.hashCode ^
      transactionLimit.hashCode ^
      startDate.hashCode ^
      endDate.hashCode;

  @override
  String toString() {
    return 'DashboardRequest{userId: $userId, forceRefresh: $forceRefresh, includeTransactions: $includeTransactions, transactionLimit: $transactionLimit, startDate: $startDate, endDate: $endDate}';
  }
}



import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quickthink/screens/category/services/state/apiService.dart';

final apiState = ChangeNotifierProvider((_) => ApiCallService());
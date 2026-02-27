import 'package:restaurant_app/data/model/restaurant/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant/restaurant_list_response.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

// Mock class
class MockApiServices extends Mock implements ApiServices {}

void main() {
  late RestaurantListProvider provider;
  late MockApiServices mockApiServices;

  setUp(() {
    mockApiServices = MockApiServices();
    provider = RestaurantListProvider(mockApiServices);
  });

  group('RestaurantListProvider', () {
    test('State awal harus RestaurantListNoneState', () {
      expect(provider.resultState, isA<RestaurantListNoneState>());
    });

    test('Harus mengembalikan daftar restoran ketika API berhasil', () async {
      final fakeResponse = RestaurantListResponse(
        error: false,
        message: '',
        count: 1,
        restaurants: [
          Restaurant(
            id: '1',
            name: 'Test Resto',
            description: 'restaurant desc',
            pictureId: '1',
            city: 'Medan',
            rating: 4.1,
          ),
        ],
      );

      when(
        () => mockApiServices.getRestaurantList(),
      ).thenAnswer((_) async => fakeResponse);

      await provider.fetchRestaurantList();

      expect(provider.resultState, isA<RestaurantListLoadedState>());

      final state = provider.resultState as RestaurantListLoadedState;
      expect(state.data.length, 1);
      expect(state.data.first.name, 'Test Resto');
    });

    test(
      'Harus mengembalikan error ketika pengambilan data API gagal',
      () async {
        final fakeResponse = RestaurantListResponse(
          error: true,
          message: 'Terjadi Kesalahan',
          restaurants: [],
          count: 1,
        );

        when(
          () => mockApiServices.getRestaurantList(),
        ).thenAnswer((_) async => fakeResponse);

        await provider.fetchRestaurantList();

        expect(provider.resultState, isA<RestaurantListErrorState>());

        final state = provider.resultState as RestaurantListErrorState;
        expect(state.error, 'Terjadi Kesalahan');
      },
    );
  });
}

//
//  FetchCodingTestTests.swift
//  FetchCodingTestTests
//
//  Created by Weijian Zeng on 5/25/23.
//

import XCTest
@testable import FetchCodingTest

final class FetchCodingTestTests: XCTestCase {
    var mealListViewModel: MealListViewModel!
    var mealDetailViewModel: MealDetailViewModel!
    var mockNetworkFetcher: MockNetworkFetcher!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        mealDetailViewModel = MealDetailViewModel(networkFetcher: mockNetworkFetcher)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mealListViewModel = nil
         mealDetailViewModel = nil
         mockNetworkFetcher = nil
    }

    func testMealListViewModelFetchesMeals() throws {
        let mealSummary = MealSummary(strMeal: "Test Meal", idMeal: "1")
        let mealListResponse = MealListResponse(meals: [mealSummary])

        do {
            mockNetworkFetcher.data = try JSONEncoder().encode(mealListResponse)
        } catch {
            XCTFail("Encoding failed: \(error)")
        }

        mealListViewModel.fetchMeals()

        XCTAssertEqual(mealListViewModel.meals.first?.strMeal, mealSummary.strMeal)
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            mockNetworkFetcher.data = Data(count: 10_000)
            mealDetailViewModel.fetchMealDetail(id: "1")
        }
    }

}

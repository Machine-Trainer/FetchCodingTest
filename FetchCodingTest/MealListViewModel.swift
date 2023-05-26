//
//  MealListViewModel.swift
//  FetchCodingTest
//
//  Created by Weijian Zeng on 5/25/23.
//

import Foundation
class MealListViewModel: ObservableObject {
    @Published var meals = [MealSummary]()

    func fetchMeals() {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert")
        else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                do {
                    let mealList = try JSONDecoder().decode(MealListResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.meals = mealList.meals.sorted { $0.strMeal < $1.strMeal }
                    }
                } catch {
                    print("Failed to decode: \(error)")
                }
            }
        }.resume()
    }
}

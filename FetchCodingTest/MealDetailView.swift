//
//  MealDetailView.swift
//  FetchCodingTest
//
//  Created by Weijian Zeng on 5/25/23.
//

import Foundation
import SwiftUI
class MealDetailViewModel: ObservableObject {
    @Published var meal: Meal?

    func fetchMealDetail(id: String) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                do {
                    let mealDetail = try JSONDecoder().decode(MealDetailResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.meal = mealDetail.meals.first
                    }
                } catch {
                    print("Failed to decode: \(error)")
                }
            }
        }.resume()
    }
}

struct MealDetailView: View {
    @ObservedObject var viewModel = MealDetailViewModel()
    let id: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20){
                if let meal = viewModel.meal {
                    Text(meal.strMeal)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .font(.largeTitle)
                    AsyncImage(url: meal.strMealThumb) { image in image
                            .resizable()
                            .frame(maxWidth: 300, maxHeight: 300)
                    } placeholder: {
                        // Placeholder view
                    }
                    Divider()
                    Text("Ingredients/Measurements: ")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    ForEach(meal.ingredientsAndMeasures, id: \.0) { ingredient, measure in
                        Text("\(ingredient) - \(measure)")
                    }
                    Divider()
                    Text("Instuctions:")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(meal.strInstructions).multilineTextAlignment(.center)
                } else {
                    Text("Loading...")
                }
            }
        }
        .onAppear {
            viewModel.fetchMealDetail(id: id)
        }
    }
}

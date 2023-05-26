//
//  MealListView.swift
//  FetchCodingTest
//
//  Created by Weijian Zeng on 5/25/23.
//

import Foundation
import SwiftUI
struct MealListView: View {
    @ObservedObject var viewModel = MealListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.meals) { meal in
                NavigationLink(destination: MealDetailView(id: meal.idMeal)) {
                    Text(meal.strMeal)
                }
            }
            .onAppear {
                viewModel.fetchMeals()
            }
            .navigationTitle("Dessert Meals")
        }
    }
}

//
//  MockNetworkFetcher.swift
//  FetchCodingTestTests
//
//  Created by Weijian Zeng on 5/26/23.
//

import XCTest
import FetchCodingTest
import Foundation
struct Meal: Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: URL
    let strInstructions: String
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    //... keep adding strIngredient up to 20 as per API documentation
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    //... keep adding strMeasure up to 20 as per API documentation
    var id: String {
        return idMeal
    }
    var ingredientsAndMeasures: [(String, String)] {
        var result = [(String, String)]()
        if let ingredient = strIngredient1, let measure = strMeasure1 {
            if(!ingredient.isEmpty && !measure.isEmpty){
                result.append((ingredient, measure))
            }
        }
        if let ingredient = strIngredient2, let measure = strMeasure2 {
            if(!ingredient.isEmpty && !measure.isEmpty){
                result.append((ingredient, measure))
            }
        }
        if let ingredient = strIngredient3, let measure = strMeasure3 {
            if(!ingredient.isEmpty && !measure.isEmpty){
                result.append((ingredient, measure))
            }
        }
        if let ingredient = strIngredient4, let measure = strMeasure4 {
            if(!ingredient.isEmpty && !measure.isEmpty){
                result.append((ingredient, measure))
            }
        }
        if let ingredient = strIngredient5, let measure = strMeasure5 {
            if(!ingredient.isEmpty && !measure.isEmpty){
                result.append((ingredient, measure))
            }
        }
        if let ingredient = strIngredient6, let measure = strMeasure6 {
            if(!ingredient.isEmpty && !measure.isEmpty){
                result.append((ingredient, measure))
            }
        }
        if let ingredient = strIngredient7, let measure = strMeasure7 {
            if(!ingredient.isEmpty && !measure.isEmpty){
                result.append((ingredient, measure))
            }
        }
        if let ingredient = strIngredient8, let measure = strMeasure8 {
            if(!ingredient.isEmpty && !measure.isEmpty){
                result.append((ingredient, measure))
            }
        }
        if let ingredient = strIngredient9, let measure = strMeasure9 {
            if(!ingredient.isEmpty && !measure.isEmpty){
                result.append((ingredient, measure))
            }
        }
        if let ingredient = strIngredient10, let measure = strMeasure10 {
            if(!ingredient.isEmpty && !measure.isEmpty){
                result.append((ingredient, measure))
            }
        }
        if let ingredient = strIngredient11, let measure = strMeasure11 {
            if(!ingredient.isEmpty && !measure.isEmpty){
                result.append((ingredient, measure))
            }
        }
        if let ingredient = strIngredient12, let measure = strMeasure12 {
            if(!ingredient.isEmpty && !measure.isEmpty){
                result.append((ingredient, measure))
            }
        }
        if let ingredient = strIngredient13, let measure = strMeasure13 {
            if(!ingredient.isEmpty && !measure.isEmpty){
                result.append((ingredient, measure))
            }
        }
        if let ingredient = strIngredient14, let measure = strMeasure14 {
            if(!ingredient.isEmpty && !measure.isEmpty){
                result.append((ingredient, measure))
            }
        }
        if let ingredient = strIngredient15, let measure = strMeasure15 {
            if(!ingredient.isEmpty && !measure.isEmpty){
                result.append((ingredient, measure))
            }
        }
        if let ingredient = strIngredient16, let measure = strMeasure16 {
            if(!ingredient.isEmpty && !measure.isEmpty){
                result.append((ingredient, measure))
            }
        }
        if let ingredient = strIngredient17, let measure = strMeasure17 {
            if(!ingredient.isEmpty && !measure.isEmpty){
                result.append((ingredient, measure))
            }
        }
        if let ingredient = strIngredient18, let measure = strMeasure18 {
            if(!ingredient.isEmpty && !measure.isEmpty){
                result.append((ingredient, measure))
            }
        }
        if let ingredient = strIngredient19, let measure = strMeasure19 {
            if(!ingredient.isEmpty && !measure.isEmpty){
                result.append((ingredient, measure))
            }
        }
        if let ingredient = strIngredient20, let measure = strMeasure20 {
            if(!ingredient.isEmpty && !measure.isEmpty){
                result.append((ingredient, measure))
            }
        }
        //... keep adding ingredients and measures up to 20 as per API documentation
        return result
    }
}
struct MealListResponse: Codable {
    let meals: [MealSummary]
}

struct MealSummary: Codable, Identifiable {
    let strMeal: String
    let idMeal: String

    var id: String {
        return idMeal
    }
}

struct MealDetailResponse: Codable {
    let meals: [Meal]
}

protocol NetworkFetcher {
    func fetchData(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: NetworkFetcher {
    func fetchData(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = dataTask(with: url, completionHandler: completion)
        task.resume()
    }
}


class MealDetailViewModel: ObservableObject {
    @Published var meal: Meal?
    var networkFetcher: NetworkFetcher
    
    init(networkFetcher: NetworkFetcher = URLSession.shared) {
        self.networkFetcher = networkFetcher
    }

    func fetchMealDetail(id: String) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else { return }

        networkFetcher.fetchData(with: url) { data, _, _ in
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
        }
    }
}

class MockNetworkFetcher: NetworkFetcher {
    var data: Data?
    var error: Error?
    
    func fetchData(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completion(data, nil, error)
    }
}

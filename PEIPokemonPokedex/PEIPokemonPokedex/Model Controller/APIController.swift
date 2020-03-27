//
//  APIController.swift
//  PEIPokemonPokedex
//
//  Created by Austin Potts on 3/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case noToken
    case badURL
    case noData
    case noDecode
    case otherError(Error)
    case badStatusCode
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delet = "DELETE"
}

@objc
class APIController: NSObject {
    
    // Create URL
    let allPokemonBaseURL = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=964")!
    
    // ObjC properties
    @objc var allPokemon: [PEIPokemon] = []
    @objc var abilities: [String] = []
    
    // Create shared singleton
    @objc(sharedController) static let shared = APIController()
    
    // MARK: - Fetch
    @objc
    func fetchAllPokemon(completion: @escaping ([PEIPokemon]?, Error?) -> Void) {
        
        // Create request
        var request = URLRequest(url: allPokemonBaseURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // open url session with request
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            // error handle
            if let error = error {
                NSLog("Error fetching pokemon: \(error)")
                completion(nil, error)
                return
            }
            
            // get data
            guard let data = data else {
                NSLog("No data returned from dataTask")
                completion(nil, error)
                return
            }
            
            // decode data 
            do {
                if let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let results = jsonDict["results"] as? [[String: String]] {
                        for pokemon in results {
                            let pokemonObject = PEIPokemon(dictionary: pokemon)
                            self.allPokemon.append(pokemonObject)
                        }
                    }
                    completion(self.allPokemon, nil)
                }
            } catch let error as NSError {
                NSLog("Failed to load pokemon data: \(error)")
                completion(nil, error)
            }
        }.resume()
    }
    
    // MARK: - Get
    @objc func fillInDetails(for pokemon: PEIPokemon) {
        guard let urlStr = pokemon.pokemonURL else { return }
        guard let baseURL = URL(string: urlStr) else { return }
        var request = URLRequest(url: baseURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching pokemon details: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from dataTask")
                return
            }
            
            do {
                if let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let abilities = jsonDict["abilities"] as? [[String: Any]],
                        let id = jsonDict["id"] as? Int,
                        let sprites = jsonDict["sprites"] as? [String: Any],
                        let frontSprite = sprites["front_default"] {
                        
                        pokemon.spriteURL = frontSprite as? String
                        pokemon.pokemonID = "\(id)"
                        pokemon.getAbilitiesAsString(abilities)
                        
                        self.fetchSprite(from: frontSprite as? String) { (data, error) in
                            guard let imageData = data else { return }
                            let spriteImage = UIImage(data: imageData)
                            pokemon.pokemonSprite = spriteImage
                        }
                    }
                }
            } catch {
                NSLog("Error decoding json")
                return
            }
        }.resume()
    }
    
    // MARK: - Fetch
    func fetchSprite(from imageURL: String?, completion: @escaping(Data?, Error?) -> Void) {
        guard let imageURLStr = imageURL else { return }
        guard let imageURL = URL(string: imageURLStr) else { return }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (imageData, _, error) in
            
            if let error = error {
                completion(nil, error)
                NSLog("Error fetching image: \(error)")
                return
            }
            
            guard let data = imageData else {
                completion(nil, error)
                NSLog("No data provided for image: \(imageURL)")
                return
            }
            completion(data, nil)
        }.resume()
    }
    
}


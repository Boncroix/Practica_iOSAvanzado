//
//  File.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 25/2/24.
//


import Foundation
/*
class PeopleUseCase {
    static let shared = PeopleUseCase()

    private let repository = PeopleRepository()
    private let networkService = NetworkService()
    private let localStorage = LocalStorage()

    func fetchPeople(completion: @escaping ([Person]) -> Void) {
        // Intenta obtener las personas de la memoria local
        let locallyStoredPeople = localStorage.getLocally()
        if !locallyStoredPeople.isEmpty {
            // Si hay personas almacenadas localmente, las devuelve
            completion(locallyStoredPeople)
        } else {
            // Si no hay personas almacenadas localmente, obtiene los datos de la red
            networkService.fetchDataFromAPI { [weak self] fetchedPeople in
                // Guarda las personas obtenidas de la red localmente
                self?.localStorage.saveLocally(fetchedPeople)
                // Devuelve las personas obtenidas de la red
                completion(fetchedPeople)
            }
        }
    }

    func addPerson(_ person: Person) {
        repository.addPerson(person)
    }
}
*/

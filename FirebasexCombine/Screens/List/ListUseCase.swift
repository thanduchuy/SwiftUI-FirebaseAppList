//
//  ListUseCase.swift
//  FirebasexCombine
//
//  Created by than.duc.huy on 20/07/2021.
//

import Foundation
import Combine

protocol ListUseCaseType {
    func getAllDataList(child: String) -> Future<[Note], Never>
    func addDataList(content: String) -> Future<Void, Never>
    func removeDataList(note: Note) -> Future<Void, Never>
}

struct ListUseCase: ListUseCaseType {
    let repository = NoteRepository()
    func getAllDataList(child: String) -> Future<[Note], Never> {
        return repository.getAllDataOfChildNote(child: child)
    }

    func addDataList(content: String) -> Future<Void, Never> {
        return repository.addDataChildNote(note: Note(content: content, timeAdd: Date()))
    }

    func removeDataList(note: Note) -> Future<Void, Never> {
        return repository.removeDataChildNote(note: note)
    }
}

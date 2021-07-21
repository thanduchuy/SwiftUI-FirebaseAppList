//
//  NoteRepository.swift
//  FirebasexCombine
//
//  Created by than.duc.huy on 20/07/2021.
//

import Foundation
import Combine

protocol NoteRepositoryType {
    func getAllDataOfChildNote(child: String) -> Future<[Note], Never>
    func addDataChildNote(note: Note) -> Future<Void, Never>
    func removeDataChildNote(note: Note) -> Future<Void, Never>
}

struct NoteRepository: NoteRepositoryType {
    func getAllDataOfChildNote(child: String) -> Future<[Note], Never> {
        FireBaseService.share.getAllDataOfChildNote(child: child)
    }

    func addDataChildNote(note: Note) -> Future<Void, Never> {
        FireBaseService.share.addDateChildNote(note: note)
    }

    func removeDataChildNote(note: Note) -> Future<Void, Never> {
        FireBaseService.share.removeDataChildNote(element: note)
    }
}

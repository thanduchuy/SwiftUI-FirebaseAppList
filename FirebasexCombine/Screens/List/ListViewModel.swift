//
//  ListViewModel.swift
//  FirebasexCombine
//
//  Created by than.duc.huy on 20/07/2021.
//

import Foundation
import Combine

struct ListViewModel {
    var usecase: ListUseCaseType
}

extension ListViewModel: BaseViewModel {
    struct Input {
        let loadTrigger: AnyPublisher<Void, Never>
        let contentNoteTrigger: AnyPublisher<String, Never>
        let addNoteTrigger: AnyPublisher<Void, Never>
        let removeNoteTrigger: AnyPublisher<Note, Never>
    }

    struct Output {
        let notes: AnyPublisher<[Note], Never>
        let addValueSuccess: AnyPublisher<Void, Never>
        let removeValueSuccess: AnyPublisher<Void, Never>
    }

    func bind(_ input: Input) -> Output {
        let notes = input.loadTrigger
            .flatMap {
                usecase.getAllDataList(child: "note")
            }
            .eraseToAnyPublisher()

        let addValueSuccess = input.addNoteTrigger
            .map {_ in Date()}
            .combineLatest(input.contentNoteTrigger)
            .removeDuplicates {
                $0.0 == $1.0
            }
            .map {$0.1}
            .flatMap {
                usecase.addDataList(content: $0)
            }
            .eraseToAnyPublisher()

        let removeValueSuccess = input.removeNoteTrigger
            .dropFirst()
            .flatMap {
                usecase.removeDataList(note: $0)
            }
            .eraseToAnyPublisher()


        return Output(notes: notes, addValueSuccess: addValueSuccess, removeValueSuccess: removeValueSuccess)
    }
}

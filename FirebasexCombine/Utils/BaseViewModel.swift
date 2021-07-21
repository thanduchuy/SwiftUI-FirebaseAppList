//
//  BaseViewModel.swift
//  FirebasexCombine
//
//  Created by than.duc.huy on 20/07/2021.
//

import Foundation
import Combine

protocol BaseViewModel {
    associatedtype Output
    associatedtype Input

    func bind(_ input: Input) -> Output
}

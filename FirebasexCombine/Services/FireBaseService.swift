//
//  FireBaseService.swift
//  FirebasexCombine
//
//  Created by than.duc.huy on 20/07/2021.
//

import Foundation
import Combine
import Firebase
import CodableFirebase

struct FireBaseService {
    static let share = FireBaseService()

    func getAllDataOfChildNote<T: Decodable, E: Error>(child: String) -> Future<[T], E> {
        return Future({ promise in
            Database.database().reference().child(child).observeSingleEvent(of: .value) { snapshot in
                var data: [T] = []
                for note in snapshot.children {
                    guard let snap = note as? DataSnapshot,
                          let value = snap.value else { return }
                    do {
                        let model = try FirebaseDecoder().decode(T.self, from: value)
                        data.append(model)
                    } catch let error {
                        print("ERROR: \(error)")
                        promise(.failure(error as! E))
                    }
                }

                promise(.success(data))
            }
        })
    }

    func addDateChildNote<E: Error>(note: Note) -> Future<Void, E> {
        return Future { promise in
            let docData = try! FirebaseEncoder().encode(note)
            Database.database().reference().child("note").childByAutoId().setValue(docData) { error, _ in
                if let error = error {
                    promise(.failure(error as! E))
                } else {
                    promise(.success(()))
                }
            }
        }
    }

    func removeDataChildNote<E: Error>(element: Note) -> Future<Void, E> {
        return Future ({ promise in
            Database.database().reference().child("note").observeSingleEvent(of: .value) { snapshot in
                for note in snapshot.children {
                    guard let snap = note as? DataSnapshot,
                          let value = snap.value as? [String: AnyObject] else { return }
                    if let content = value["content"] as? String,
                       element.content == content {
                        Database.database().reference().child("note").child(snap.key).removeValue { error, _ in
                            if let error = error {
                                promise(.failure(error as! E))
                            } else {
                                promise(.success(()))
                            }
                        }
                        break
                    }
                }
            }
        })
    }
}

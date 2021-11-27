//
//  Array+Identifiable.swift
//  Array+Identifiable
//
//  Created by Trevor Schmidt on 9/9/21.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching targetElement: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == targetElement.id {
                return index
            }
        }
        return nil
    }
}



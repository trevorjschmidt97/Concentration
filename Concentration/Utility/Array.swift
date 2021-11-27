//
//  Array.swift
//  Array
//
//  Created by Trevor Schmidt on 9/14/21.
//

import Foundation

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        }
        return nil
    }
}

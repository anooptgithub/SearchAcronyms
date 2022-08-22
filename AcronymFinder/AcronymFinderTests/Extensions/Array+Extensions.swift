//
//  Array+Extensions.swift
//  AcronymFinderTests
//
//  Created by Anoop Thomas on 8/21/22.
//

import Foundation

extension Array where Element: Comparable {
    
    /// Checks if the the specified elements are contained in the array in the same order.
    func containsInOrder(_ elements: [Element]) -> Bool {
        var startIndex = 0
        var result = true

        for element in elements {
            
            // Check if element is available in the sub-array from the current start index
            var elementFound = false
            for index in startIndex..<count {
                if self[index] == element {
                    startIndex = index + 1 // Advance the startIndex to be one after the current elements index
                    elementFound = true
                    break
                }
            }

            if elementFound == false {
                result = false
                break
            }
        }
        
        return result
    }
    
    func doesNotContainAny(_ elements: [Element]) -> Bool {
        return filter(elements.contains).isEmpty
    }
}

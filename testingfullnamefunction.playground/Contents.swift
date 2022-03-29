import UIKit

func isValidFullName(input: String) -> Bool {
    let fullName = input.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
//    let firstName = String(fullName.first ?? "")
//    let lastName = String(fullName.last ?? "")
    
    if fullName.count != 2 {
        return false
    } else {
        return true
    }
}

isValidFullName(input: "Nadia")
isValidFullName(input: "Nadia Nadia")
isValidFullName(input: "Nadia ")
isValidFullName(input: "Nadia Hello Bye Siddiqah")
isValidFullName(input: "Nadia Hello Siddiqah")

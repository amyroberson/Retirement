//
//  main.swift
//  Retirement
//
//  Created by Amy Roberson on 12/23/16.
//  Copyright © 2016 Amy Roberson. All rights reserved.
//

import Foundation

enum FileError: Error{
    case noSupportDirectory
}

func getIntFromUser(prompt: String) -> Int {
    print(prompt)
    var x: Int?
    while x == nil {
        if let y = readLine(strippingNewline: true),
            let tmpNumber = Int(y){
            x = tmpNumber
        } else {
            print("That was not a valid number, \(prompt)")
        }
    }
    return x!
}

func getStringFromTheUser(prompt: String) -> String {
    print(prompt)
    var input: String?
    while input == nil {
        if let newInput = readLine(strippingNewline: true){
            input = newInput
        } else {
            print("That was not a valid answer, \(prompt)")
        }
    }
    return input!
}

func evaluateYN(input: String) -> Bool {
    let string = input.lowercased()
    if string.hasPrefix("y"){
        return true
    } else {
        return false
    }
}

func toJSON(people: [String: Person]) throws -> Data {
    var dictionary: [String: [String: Any]] = [:]
    for (name, information) in people {
        let inerDictionary = information.toDictionary()
        dictionary[name] = inerDictionary
    }
    let jsonRepresentation = try JSONSerialization.data(withJSONObject: dictionary, options: [])
    return jsonRepresentation
}



func getRetirementInformation(name: String) -> Person {
    let age = getIntFromUser(prompt: "Hello \(name), what is your current age?")
    let retirementAge = getIntFromUser(prompt: "What age would you like to retire?")
    let newPerson = Person(name: name, age: age, ageToRetire: retirementAge)
    return newPerson
}

func getHistoryFilePath() throws -> URL {
    guard let supportDir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
        throw FileError.noSupportDirectory
    }
    var supportFile = supportDir.appendingPathComponent("Retirement")
    try FileManager.default.createDirectory(at: supportFile, withIntermediateDirectories: true, attributes: nil)
    supportFile = supportFile.appendingPathComponent("history.json")
    return supportFile
    
}

func loadHistory() -> [String: Person] {
    var people : [String: Person] = [:]
    do{
        let file = try getHistoryFilePath()
        if FileManager.default.fileExists(atPath: file.path) {
            let jsonData = try Data(contentsOf: file)
            guard let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:[String:Any]] else {
              return people
            }
            
            for (name, person) in jsonObject {
                let newPerson = Person(dictionary: person)
                people[name] = newPerson
            }
        }
    } catch {
        print("Error Loading History")
    }
    return people
}

func saveHistory(people: [String: Person]){
    do{
        let data = try toJSON(people: people)
        let file = try getHistoryFilePath()
        try data.write(to: file, options: NSData.WritingOptions.atomic)
    } catch{
        print("Error Saving History")
    }
}


func runRetirementInformation() {
    var people: [String: Person] = [:]
    people = loadHistory()
    let newName = getStringFromTheUser(prompt: "What is your name?")
    if people[newName] == nil {
        people[newName] = getRetirementInformation(name: newName)
        
    } else {
        let answer = getStringFromTheUser(prompt: "Hello \(newName), are you \(people[newName]!.age) and plan to retire at \(people[newName]!.retirementAge)? (y/n)")
        if !evaluateYN(input: answer) {
            people[newName] = getRetirementInformation(name: newName)
        }
    }
    
    print("You have \(people[newName]!.yearsTillRetirement()) years left until you can retire.")
    print("\(newName), it is \(Util.getCurrentYear()), so you can retire in \(people[newName]!.calculateYearOfRetirement()).")
    
    saveHistory(people: people)
}

print("Welcome to Retirement Calculator!")
runRetirementInformation()

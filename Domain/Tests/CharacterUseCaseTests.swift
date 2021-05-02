//
//  CharacterUseCaseTests.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import XCTest
@testable import Domain

final class CharacterUseCaseTests: XCTestCase {
    
    private static var allCharacters: [Character]?
    
    override class func setUp() {
        super.setUp()
        
        let json = """
        [
            {
                "id": 0,
                "name": null,
                "description": null
            },
            {
                "id": 1,
                "name": "A",
                "description": "D"
            },
            {
                "id": 2,
                "name": "B",
                "description": "D"
            }
        ]
        """
        
        let decoder = JSONDecoder()
        let characters = try! decoder.decode([Character].self, from: json.data(using: .utf8)!)
        CharacterUseCaseTests.allCharacters = characters
    }
    
    override class func tearDown() {
        super.tearDown()
        
        CharacterUseCaseTests.allCharacters = nil
    }

    func testGetCharactersWithZeroLimit() {
        let expectation = self.expectation(description: "Should reveive empty list of characters.")
        let useCase = CharacterUseCase(repository: CharacterRepoMock(characters: []))
        XCTAssertNoThrow(try useCase.getCharacters(limit: 0, completion: { result in
            expectation.fulfill()
            switch result {
            case .success(let page):
                XCTAssertTrue(page.entities.isEmpty)
            default:
                XCTFail("Should be success.")
            }
        }))
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetAllCharacters() {
        let expectation = self.expectation(description: "Should reveive all characters.")
        let useCase = CharacterUseCase(repository: CharacterRepoMock(characters: CharacterUseCaseTests.allCharacters!))
        XCTAssertNoThrow(try useCase.getCharacters(limit: PageLimit.max, completion: { result in
            expectation.fulfill()
            switch result {
            case .success(let page):
                XCTAssertTrue(page.entities.count == CharacterUseCaseTests.allCharacters!.count)
                XCTAssertTrue(page.total == CharacterUseCaseTests.allCharacters!.count)
                var index = Character.ID(0)
                for character in page.entities {
                    XCTAssertTrue(index == character.id)
                    index += 1
                }
            default:
                XCTFail("Should be success.")
            }
        }))
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetSingleCharacterPage() {
        let expectation = self.expectation(description: "Should reveive 1 character.")
        let useCase = CharacterUseCase(repository: CharacterRepoMock(characters: CharacterUseCaseTests.allCharacters!))
        XCTAssertNoThrow(try useCase.getCharacters(limit: 1, completion: { result in
            expectation.fulfill()
            switch result {
            case .success(let page):
                XCTAssertTrue(page.entities.count == 1)
                XCTAssertTrue(page.total == CharacterUseCaseTests.allCharacters!.count)
            default:
                XCTFail("Should be success.")
            }
        }))
        wait(for: [expectation], timeout: 1)
    }
    
    private func getCharactersWithNextPage(useCase: CharacterUseCaseInterface, firstPage: Page<Character>, expectation: XCTestExpectation) {
        XCTAssertNoThrow(try useCase.getCombinedCharacters(nextAfter: firstPage, limit: PageLimit.max, completion: { result in
            expectation.fulfill()
            switch result {
            case .success(let page):
                XCTAssertTrue(page.entities.count == CharacterUseCaseTests.allCharacters!.count)
                XCTAssertTrue(page.total == CharacterUseCaseTests.allCharacters!.count)
                XCTAssertTrue(firstPage.entities.count == 1)
            default:
                XCTFail("Should be success.")
            }
        }))
    }
    
    func testGetAllCharactersWithNextPage() {
        let expectation = self.expectation(description: "Should reveive all characters in a final page.")
        let useCase = CharacterUseCase(repository: CharacterRepoMock(characters: CharacterUseCaseTests.allCharacters!))
        XCTAssertNoThrow(try useCase.getCharacters(limit: 1, completion: { [weak self, weak useCase] result in
            switch result {
            case .success(let page):
                XCTAssertTrue(page.entities.count == 1)
                XCTAssertTrue(page.total == CharacterUseCaseTests.allCharacters!.count)
                self?.getCharactersWithNextPage(useCase: useCase!, firstPage: page, expectation: expectation)
            default:
                XCTFail("Should be success.")
            }
        }))
        wait(for: [expectation], timeout: 1)
    }
    
    static var allTests = [
        ("testGetCharactersWithZeroLimit", testGetCharactersWithZeroLimit),
        ("testGetAllCharacters", testGetAllCharacters),
        ("testGetSingleCharacterPage", testGetSingleCharacterPage),
        ("testGetAllCharactersWithNextPage", testGetAllCharactersWithNextPage)
    ]
}

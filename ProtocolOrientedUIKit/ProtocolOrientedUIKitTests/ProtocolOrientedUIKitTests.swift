//
//  ProtocolOrientedUIKitTests.swift
//  ProtocolOrientedUIKitTests
//
//  Created by Barış Dilekçi on 5.10.2024.
//

import XCTest
@testable import ProtocolOrientedUIKit

final class ProtocolOrientedUIKitTests: XCTestCase {
    
    private var sut : UserListViewModel!
    private var userService : MockUserService!
    private var output : MockUserViewModelOutput!
    
    override func setUpWithError() throws {
        userService = MockUserService()
        sut = UserListViewModel(userService: userService)
        output = MockUserViewModelOutput()
        sut.output = output
    }
    
    override func tearDownWithError() throws {
        sut = nil
        userService = nil
        //try super.tearDownWithError()
    }
    
    func testUpdateView_whenAPISuccess_showsEmailNameUserName() throws {
        let mockUser = User(id: 1, name: "John", username: "john123", email: "john@gmail.com")
        userService.fetchUserMockResult = .success(mockUser)
        sut.fetchUser()
        
        XCTAssertEqual(output.updateViewArray.count, 1)
        XCTAssertEqual(output.updateViewArray.first?.userName, "john123")
        
        
    }
    
    func testUpdateView_whenAPIFailure_showsNoUserFound() throws {
        
        userService.fetchUserMockResult = .failure(NSError())
        
        sut.fetchUser()
        
        XCTAssertEqual(output.updateViewArray.count, 1)
        XCTAssertEqual(output.updateViewArray.first?.name, "No user")
        
        
    }
    
}

class MockUserService : UserService {
    var fetchUserMockResult : Result<ProtocolOrientedUIKit.User, Error>?
    func fetch(completion: @escaping (Result<ProtocolOrientedUIKit.User, any Error>) -> Void) {
        if let result = fetchUserMockResult {
            completion(result)
        }
    }
}
class MockUserViewModelOutput : UserViewModelProtocol {
    var updateViewArray : [(name:String, email:String, userName:String)] = []
    func updateView(name: String, email: String, userName: String) {
        updateViewArray.append((name,email,userName))
    }
}

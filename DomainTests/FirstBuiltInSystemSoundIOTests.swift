//
//  FirstBuiltInSystemSoundIOTests.swift
//  Telephone
//
//  Copyright (c) 2008-2015 Alexey Kuznetsov
//
//  Telephone is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  Telephone is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//

@testable import Domain
import DomainTestDoubles
import XCTest

class FirstBuiltInSystemSoundIOTests: XCTestCase {
    private var factory: SystemAudioDeviceTestFactory!

    override func setUp() {
        super.setUp()
        factory = SystemAudioDeviceTestFactory()
    }

    func testInputIsTheFirstBuiltInInputDevice() {
        let sut = try! FirstBuiltInSystemSoundIO(devices: factory.all)

        XCTAssertEqual(sut.input, factory.firstBuiltInInput)
    }

    func testOutputIsTheFirstBuiltInOutputDevice() {
        let sut = try! FirstBuiltInSystemSoundIO(devices: factory.all)

        XCTAssertEqual(sut.output, factory.firstBuiltInOutput)
    }

    func testThrowsIfCanNotFindBuiltInInput() {
        assertThrowsWhenCreatedWithDevices([factory.firstBuiltInOutput])
    }

    func testThrowsIfCanNotFindBuiltInOutput() {
        assertThrowsWhenCreatedWithDevices([factory.firstBuiltInInput])
    }

    private func assertThrowsWhenCreatedWithDevices(devices: [SystemAudioDevice]) {
        var didThrow = false

        do {
            _ = try FirstBuiltInSystemSoundIO(devices: devices)
        } catch Error.SystemAudioDeviceNotFoundError {
            didThrow = true
        } catch {

        }

        XCTAssertTrue(didThrow)
    }
}

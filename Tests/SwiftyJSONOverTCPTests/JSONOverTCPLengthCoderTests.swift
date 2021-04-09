import Foundation
@testable import SwiftyJSONOverTCP
import XCTest

class JSONOverTCPLengthCoderTests: XCTestCase {

    // MARK: - Encoding

    func testEncoding_lengthTooLarge_shouldThrowInvalidPayloadSizeError() {
        XCTAssertThrowsError(try JOTLengthCoder.encode(length: UInt(UInt32.max) + 1))
    }

    func testEncoding_zeroLength_shouldReturn4Zeros() throws  {
        let bytes = try JOTLengthCoder.encode(length: 0)
        XCTAssertEqual(bytes, [0x0, 0x0, 0x0, 0x0])
    }

    func testEncoding_shouldReturnBigEndianZeros() throws {
        let bytes = try JOTLengthCoder.encode(length: 3735928559)
        XCTAssertEqual(bytes, [0xDE, 0xAD, 0xBE, 0xEF])
    }

    func testEncoding_maximumLength_shouldReturn40xFFBytes() throws {
        let bytes = try JOTLengthCoder.encode(length: UInt(UInt32.max))
        XCTAssertEqual(bytes, [0xFF, 0xFF, 0xFF, 0xFF])
    }

    // MARK: - Decoding

    func testDecoding_invalid_shouldThrowInvalidPayloadSizeError() {
        XCTAssertNil(JOTLengthCoder.decodeLength(from: []))
    }

    func testDecoding_zeroLength_shouldReturn4Zeros() throws  {
        let decoded = JOTLengthCoder.decodeLength(from: [0x0, 0x0, 0x0, 0x0])
        XCTAssertEqual(decoded, 0)
    }

    func testDecoding_shouldReturnBigEndianZeros() throws {
        let decoded = JOTLengthCoder.decodeLength(from: [0xDE, 0xAD, 0xBE, 0xEF])
        XCTAssertEqual(decoded, 3735928559)
    }

    func testDecoding_maximumLength_shouldReturn40xFFBytes() throws {
        let decoded = JOTLengthCoder.decodeLength(from: [0xFF, 0xFF, 0xFF, 0xFF])
        XCTAssertEqual(decoded, UInt32.max)
    }
}

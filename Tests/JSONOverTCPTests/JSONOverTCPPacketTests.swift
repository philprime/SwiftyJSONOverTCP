import Foundation
import XCTest
@testable import JSONOverTCP

class JSONOverTCPPacketTests: XCTestCase {

    func testEncoding_emptyData_shouldReturn5Bytes() throws {
        let data = Data([])
        let packet = JSONOverTCPPacket(data: data)
        let encoded = try packet.encode()
        XCTAssertEqual(encoded.map { $0 }, [
            JSONOverTCPPacket.MagicByte, // Magic Byte
            0x0, 0x0, 0x0, 0x0, // Length
            // Data
        ])
    }

    func testEncoding_nonEmptyData_shouldReturnBytes() throws {
        let data = Data([0x11, 0x11, 0x11, 0x11])
        let packet = JSONOverTCPPacket(data: data)
        let encoded = try packet.encode()
        XCTAssertEqual(encoded.map { $0 }, [
            JSONOverTCPPacket.MagicByte, // Magic Byte
            0x0, 0x0, 0x0, 4, // Length
            0x11, 0x11, 0x11, 0x11 // Data
        ])
    }

    func testEncoding_tooLargeData_shouldThrowError() throws {
        let data = Data(repeating: 0x11, count: Int(UInt32.max) + 1)
        let packet = JSONOverTCPPacket(data: data)
        XCTAssertThrowsError(try packet.encode())
    }
}

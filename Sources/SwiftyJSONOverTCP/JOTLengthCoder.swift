import Foundation

public class JOTLengthCoder {

    public static func encode(length: UInt) throws -> [UInt8] {
        guard length >= 0 && length <= UInt32.max else {
            throw SwiftyJSONOverTCPError.invalidPayloadSize
        }
        let length = UInt32(length)
        return withUnsafeBytes(of: length.bigEndian, Array.init)
    }

    public static func decodeLength(from bytes: [UInt8]) -> UInt32? {
        guard bytes.count == 4 else {
            return nil
        }
        var data = Data(bytes)
        return UInt32(bigEndian: withUnsafeBytes(of: &data) { ptr in
            return ptr.load(as: UInt32.self)
        })
    }

}

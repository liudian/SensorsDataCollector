// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: SensorsData.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct SensorsDataCollector_Vector3f {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var x: Float = 0

  var y: Float = 0

  var z: Float = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct SensorsDataCollector_IMUData {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var rotationRate: SensorsDataCollector_Vector3f {
    get {return _rotationRate ?? SensorsDataCollector_Vector3f()}
    set {_rotationRate = newValue}
  }
  /// Returns true if `rotationRate` has been explicitly set.
  var hasRotationRate: Bool {return self._rotationRate != nil}
  /// Clears the value of `rotationRate`. Subsequent reads from it will return its default value.
  mutating func clearRotationRate() {self._rotationRate = nil}

  var acceleration: SensorsDataCollector_Vector3f {
    get {return _acceleration ?? SensorsDataCollector_Vector3f()}
    set {_acceleration = newValue}
  }
  /// Returns true if `acceleration` has been explicitly set.
  var hasAcceleration: Bool {return self._acceleration != nil}
  /// Clears the value of `acceleration`. Subsequent reads from it will return its default value.
  mutating func clearAcceleration() {self._acceleration = nil}

  var gravity: SensorsDataCollector_Vector3f {
    get {return _gravity ?? SensorsDataCollector_Vector3f()}
    set {_gravity = newValue}
  }
  /// Returns true if `gravity` has been explicitly set.
  var hasGravity: Bool {return self._gravity != nil}
  /// Clears the value of `gravity`. Subsequent reads from it will return its default value.
  mutating func clearGravity() {self._gravity = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _rotationRate: SensorsDataCollector_Vector3f? = nil
  fileprivate var _acceleration: SensorsDataCollector_Vector3f? = nil
  fileprivate var _gravity: SensorsDataCollector_Vector3f? = nil
}

struct SensorsDataCollector_IMUSampler {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var samplingRate: Int32 = 0

  var data: [SensorsDataCollector_IMUData] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct SensorsDataCollector_AudioSampler {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var type: SensorsDataCollector_AudioSampler.TypeEnum = .aac

  var data: Data = SwiftProtobuf.Internal.emptyData

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum TypeEnum: SwiftProtobuf.Enum {
    typealias RawValue = Int
    case aac // = 0
    case UNRECOGNIZED(Int)

    init() {
      self = .aac
    }

    init?(rawValue: Int) {
      switch rawValue {
      case 0: self = .aac
      default: self = .UNRECOGNIZED(rawValue)
      }
    }

    var rawValue: Int {
      switch self {
      case .aac: return 0
      case .UNRECOGNIZED(let i): return i
      }
    }

  }

  init() {}
}

#if swift(>=4.2)

extension SensorsDataCollector_AudioSampler.TypeEnum: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [SensorsDataCollector_AudioSampler.TypeEnum] = [
    .aac,
  ]
}

#endif  // swift(>=4.2)

struct SensorsDataCollector_SensorsData {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var audio: SensorsDataCollector_AudioSampler {
    get {return _audio ?? SensorsDataCollector_AudioSampler()}
    set {_audio = newValue}
  }
  /// Returns true if `audio` has been explicitly set.
  var hasAudio: Bool {return self._audio != nil}
  /// Clears the value of `audio`. Subsequent reads from it will return its default value.
  mutating func clearAudio() {self._audio = nil}

  var imu: SensorsDataCollector_IMUSampler {
    get {return _imu ?? SensorsDataCollector_IMUSampler()}
    set {_imu = newValue}
  }
  /// Returns true if `imu` has been explicitly set.
  var hasImu: Bool {return self._imu != nil}
  /// Clears the value of `imu`. Subsequent reads from it will return its default value.
  mutating func clearImu() {self._imu = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _audio: SensorsDataCollector_AudioSampler? = nil
  fileprivate var _imu: SensorsDataCollector_IMUSampler? = nil
}

struct SensorsDataCollector_LabeledSensorsData {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var label: String = String()

  var sensorsData: SensorsDataCollector_SensorsData {
    get {return _sensorsData ?? SensorsDataCollector_SensorsData()}
    set {_sensorsData = newValue}
  }
  /// Returns true if `sensorsData` has been explicitly set.
  var hasSensorsData: Bool {return self._sensorsData != nil}
  /// Clears the value of `sensorsData`. Subsequent reads from it will return its default value.
  mutating func clearSensorsData() {self._sensorsData = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _sensorsData: SensorsDataCollector_SensorsData? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "sensors_data_collector"

extension SensorsDataCollector_Vector3f: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Vector3f"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "x"),
    2: .same(proto: "y"),
    3: .same(proto: "z"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularFloatField(value: &self.x)
      case 2: try decoder.decodeSingularFloatField(value: &self.y)
      case 3: try decoder.decodeSingularFloatField(value: &self.z)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.x != 0 {
      try visitor.visitSingularFloatField(value: self.x, fieldNumber: 1)
    }
    if self.y != 0 {
      try visitor.visitSingularFloatField(value: self.y, fieldNumber: 2)
    }
    if self.z != 0 {
      try visitor.visitSingularFloatField(value: self.z, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: SensorsDataCollector_Vector3f, rhs: SensorsDataCollector_Vector3f) -> Bool {
    if lhs.x != rhs.x {return false}
    if lhs.y != rhs.y {return false}
    if lhs.z != rhs.z {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension SensorsDataCollector_IMUData: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".IMUData"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "rotationRate"),
    2: .same(proto: "acceleration"),
    3: .same(proto: "gravity"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._rotationRate)
      case 2: try decoder.decodeSingularMessageField(value: &self._acceleration)
      case 3: try decoder.decodeSingularMessageField(value: &self._gravity)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._rotationRate {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if let v = self._acceleration {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }
    if let v = self._gravity {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: SensorsDataCollector_IMUData, rhs: SensorsDataCollector_IMUData) -> Bool {
    if lhs._rotationRate != rhs._rotationRate {return false}
    if lhs._acceleration != rhs._acceleration {return false}
    if lhs._gravity != rhs._gravity {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension SensorsDataCollector_IMUSampler: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".IMUSampler"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "samplingRate"),
    2: .same(proto: "data"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularInt32Field(value: &self.samplingRate)
      case 2: try decoder.decodeRepeatedMessageField(value: &self.data)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.samplingRate != 0 {
      try visitor.visitSingularInt32Field(value: self.samplingRate, fieldNumber: 1)
    }
    if !self.data.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.data, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: SensorsDataCollector_IMUSampler, rhs: SensorsDataCollector_IMUSampler) -> Bool {
    if lhs.samplingRate != rhs.samplingRate {return false}
    if lhs.data != rhs.data {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension SensorsDataCollector_AudioSampler: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".AudioSampler"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "type"),
    2: .same(proto: "data"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularEnumField(value: &self.type)
      case 2: try decoder.decodeSingularBytesField(value: &self.data)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.type != .aac {
      try visitor.visitSingularEnumField(value: self.type, fieldNumber: 1)
    }
    if !self.data.isEmpty {
      try visitor.visitSingularBytesField(value: self.data, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: SensorsDataCollector_AudioSampler, rhs: SensorsDataCollector_AudioSampler) -> Bool {
    if lhs.type != rhs.type {return false}
    if lhs.data != rhs.data {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension SensorsDataCollector_AudioSampler.TypeEnum: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "AAC"),
  ]
}

extension SensorsDataCollector_SensorsData: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".SensorsData"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "audio"),
    2: .same(proto: "imu"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._audio)
      case 2: try decoder.decodeSingularMessageField(value: &self._imu)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._audio {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if let v = self._imu {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: SensorsDataCollector_SensorsData, rhs: SensorsDataCollector_SensorsData) -> Bool {
    if lhs._audio != rhs._audio {return false}
    if lhs._imu != rhs._imu {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension SensorsDataCollector_LabeledSensorsData: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".LabeledSensorsData"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "label"),
    2: .same(proto: "sensorsData"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.label)
      case 2: try decoder.decodeSingularMessageField(value: &self._sensorsData)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.label.isEmpty {
      try visitor.visitSingularStringField(value: self.label, fieldNumber: 1)
    }
    if let v = self._sensorsData {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: SensorsDataCollector_LabeledSensorsData, rhs: SensorsDataCollector_LabeledSensorsData) -> Bool {
    if lhs.label != rhs.label {return false}
    if lhs._sensorsData != rhs._sensorsData {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
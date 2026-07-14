// Auto-generated. Do not edit!

// (in-package corrosion_detector.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class Detection3D {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.class_id = null;
      this.score = null;
      this.x = null;
      this.y = null;
      this.z = null;
      this.width = null;
      this.height = null;
      this.area_px = null;
      this.area_real = null;
      this.is_corrosion = null;
    }
    else {
      if (initObj.hasOwnProperty('class_id')) {
        this.class_id = initObj.class_id
      }
      else {
        this.class_id = '';
      }
      if (initObj.hasOwnProperty('score')) {
        this.score = initObj.score
      }
      else {
        this.score = 0.0;
      }
      if (initObj.hasOwnProperty('x')) {
        this.x = initObj.x
      }
      else {
        this.x = 0.0;
      }
      if (initObj.hasOwnProperty('y')) {
        this.y = initObj.y
      }
      else {
        this.y = 0.0;
      }
      if (initObj.hasOwnProperty('z')) {
        this.z = initObj.z
      }
      else {
        this.z = 0.0;
      }
      if (initObj.hasOwnProperty('width')) {
        this.width = initObj.width
      }
      else {
        this.width = 0.0;
      }
      if (initObj.hasOwnProperty('height')) {
        this.height = initObj.height
      }
      else {
        this.height = 0.0;
      }
      if (initObj.hasOwnProperty('area_px')) {
        this.area_px = initObj.area_px
      }
      else {
        this.area_px = 0.0;
      }
      if (initObj.hasOwnProperty('area_real')) {
        this.area_real = initObj.area_real
      }
      else {
        this.area_real = 0.0;
      }
      if (initObj.hasOwnProperty('is_corrosion')) {
        this.is_corrosion = initObj.is_corrosion
      }
      else {
        this.is_corrosion = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Detection3D
    // Serialize message field [class_id]
    bufferOffset = _serializer.string(obj.class_id, buffer, bufferOffset);
    // Serialize message field [score]
    bufferOffset = _serializer.float64(obj.score, buffer, bufferOffset);
    // Serialize message field [x]
    bufferOffset = _serializer.float64(obj.x, buffer, bufferOffset);
    // Serialize message field [y]
    bufferOffset = _serializer.float64(obj.y, buffer, bufferOffset);
    // Serialize message field [z]
    bufferOffset = _serializer.float64(obj.z, buffer, bufferOffset);
    // Serialize message field [width]
    bufferOffset = _serializer.float64(obj.width, buffer, bufferOffset);
    // Serialize message field [height]
    bufferOffset = _serializer.float64(obj.height, buffer, bufferOffset);
    // Serialize message field [area_px]
    bufferOffset = _serializer.float64(obj.area_px, buffer, bufferOffset);
    // Serialize message field [area_real]
    bufferOffset = _serializer.float64(obj.area_real, buffer, bufferOffset);
    // Serialize message field [is_corrosion]
    bufferOffset = _serializer.bool(obj.is_corrosion, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Detection3D
    let len;
    let data = new Detection3D(null);
    // Deserialize message field [class_id]
    data.class_id = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [score]
    data.score = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [x]
    data.x = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [y]
    data.y = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [z]
    data.z = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [width]
    data.width = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [height]
    data.height = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [area_px]
    data.area_px = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [area_real]
    data.area_real = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [is_corrosion]
    data.is_corrosion = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.class_id);
    return length + 69;
  }

  static datatype() {
    // Returns string type for a message object
    return 'corrosion_detector/Detection3D';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b60e816205b8d91f0f0e4b9f112e2720';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string class_id
    float64 score
    float64 x  # Metros
    float64 y  # Metros
    float64 z  # Metros
    float64 width
    float64 height
    float64 area_px
    float64 area_real
    bool is_corrosion # Valor en bool per a poder distingir entre cas de corrosio i de xarxa
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Detection3D(null);
    if (msg.class_id !== undefined) {
      resolved.class_id = msg.class_id;
    }
    else {
      resolved.class_id = ''
    }

    if (msg.score !== undefined) {
      resolved.score = msg.score;
    }
    else {
      resolved.score = 0.0
    }

    if (msg.x !== undefined) {
      resolved.x = msg.x;
    }
    else {
      resolved.x = 0.0
    }

    if (msg.y !== undefined) {
      resolved.y = msg.y;
    }
    else {
      resolved.y = 0.0
    }

    if (msg.z !== undefined) {
      resolved.z = msg.z;
    }
    else {
      resolved.z = 0.0
    }

    if (msg.width !== undefined) {
      resolved.width = msg.width;
    }
    else {
      resolved.width = 0.0
    }

    if (msg.height !== undefined) {
      resolved.height = msg.height;
    }
    else {
      resolved.height = 0.0
    }

    if (msg.area_px !== undefined) {
      resolved.area_px = msg.area_px;
    }
    else {
      resolved.area_px = 0.0
    }

    if (msg.area_real !== undefined) {
      resolved.area_real = msg.area_real;
    }
    else {
      resolved.area_real = 0.0
    }

    if (msg.is_corrosion !== undefined) {
      resolved.is_corrosion = msg.is_corrosion;
    }
    else {
      resolved.is_corrosion = false
    }

    return resolved;
    }
};

module.exports = Detection3D;

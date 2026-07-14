// Auto-generated. Do not edit!

// (in-package corrosion_detector.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class CoordinatesError {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.x_err = null;
      this.y_err = null;
      this.z_err = null;
      this.total_error = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('x_err')) {
        this.x_err = initObj.x_err
      }
      else {
        this.x_err = 0.0;
      }
      if (initObj.hasOwnProperty('y_err')) {
        this.y_err = initObj.y_err
      }
      else {
        this.y_err = 0.0;
      }
      if (initObj.hasOwnProperty('z_err')) {
        this.z_err = initObj.z_err
      }
      else {
        this.z_err = 0.0;
      }
      if (initObj.hasOwnProperty('total_error')) {
        this.total_error = initObj.total_error
      }
      else {
        this.total_error = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CoordinatesError
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [x_err]
    bufferOffset = _serializer.float64(obj.x_err, buffer, bufferOffset);
    // Serialize message field [y_err]
    bufferOffset = _serializer.float64(obj.y_err, buffer, bufferOffset);
    // Serialize message field [z_err]
    bufferOffset = _serializer.float64(obj.z_err, buffer, bufferOffset);
    // Serialize message field [total_error]
    bufferOffset = _serializer.float64(obj.total_error, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CoordinatesError
    let len;
    let data = new CoordinatesError(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [x_err]
    data.x_err = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [y_err]
    data.y_err = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [z_err]
    data.z_err = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [total_error]
    data.total_error = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 32;
  }

  static datatype() {
    // Returns string type for a message object
    return 'corrosion_detector/CoordinatesError';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f51f162e146a2cd618e4c2bc2935431c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    std_msgs/Header header
    
    # Coordenadas del error (posicion ground_truth - posicion calculada)
    float64 x_err 
    float64 y_err
    float64 z_err
    
    # Distancia euclídea entre los 2 puntos en 3 dimensiones
    float64 total_error
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new CoordinatesError(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.x_err !== undefined) {
      resolved.x_err = msg.x_err;
    }
    else {
      resolved.x_err = 0.0
    }

    if (msg.y_err !== undefined) {
      resolved.y_err = msg.y_err;
    }
    else {
      resolved.y_err = 0.0
    }

    if (msg.z_err !== undefined) {
      resolved.z_err = msg.z_err;
    }
    else {
      resolved.z_err = 0.0
    }

    if (msg.total_error !== undefined) {
      resolved.total_error = msg.total_error;
    }
    else {
      resolved.total_error = 0.0
    }

    return resolved;
    }
};

module.exports = CoordinatesError;

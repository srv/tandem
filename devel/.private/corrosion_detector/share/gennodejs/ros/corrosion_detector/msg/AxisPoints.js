// Auto-generated. Do not edit!

// (in-package corrosion_detector.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class AxisPoints {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.major_axis_p1 = null;
      this.major_axis_p2 = null;
      this.minor_axis_p1 = null;
      this.minor_axis_p2 = null;
      this.orientation = null;
      this.major_axis_len = null;
      this.minor_axis_len = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('major_axis_p1')) {
        this.major_axis_p1 = initObj.major_axis_p1
      }
      else {
        this.major_axis_p1 = new geometry_msgs.msg.Point();
      }
      if (initObj.hasOwnProperty('major_axis_p2')) {
        this.major_axis_p2 = initObj.major_axis_p2
      }
      else {
        this.major_axis_p2 = new geometry_msgs.msg.Point();
      }
      if (initObj.hasOwnProperty('minor_axis_p1')) {
        this.minor_axis_p1 = initObj.minor_axis_p1
      }
      else {
        this.minor_axis_p1 = new geometry_msgs.msg.Point();
      }
      if (initObj.hasOwnProperty('minor_axis_p2')) {
        this.minor_axis_p2 = initObj.minor_axis_p2
      }
      else {
        this.minor_axis_p2 = new geometry_msgs.msg.Point();
      }
      if (initObj.hasOwnProperty('orientation')) {
        this.orientation = initObj.orientation
      }
      else {
        this.orientation = 0.0;
      }
      if (initObj.hasOwnProperty('major_axis_len')) {
        this.major_axis_len = initObj.major_axis_len
      }
      else {
        this.major_axis_len = 0.0;
      }
      if (initObj.hasOwnProperty('minor_axis_len')) {
        this.minor_axis_len = initObj.minor_axis_len
      }
      else {
        this.minor_axis_len = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AxisPoints
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [major_axis_p1]
    bufferOffset = geometry_msgs.msg.Point.serialize(obj.major_axis_p1, buffer, bufferOffset);
    // Serialize message field [major_axis_p2]
    bufferOffset = geometry_msgs.msg.Point.serialize(obj.major_axis_p2, buffer, bufferOffset);
    // Serialize message field [minor_axis_p1]
    bufferOffset = geometry_msgs.msg.Point.serialize(obj.minor_axis_p1, buffer, bufferOffset);
    // Serialize message field [minor_axis_p2]
    bufferOffset = geometry_msgs.msg.Point.serialize(obj.minor_axis_p2, buffer, bufferOffset);
    // Serialize message field [orientation]
    bufferOffset = _serializer.float64(obj.orientation, buffer, bufferOffset);
    // Serialize message field [major_axis_len]
    bufferOffset = _serializer.float64(obj.major_axis_len, buffer, bufferOffset);
    // Serialize message field [minor_axis_len]
    bufferOffset = _serializer.float64(obj.minor_axis_len, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AxisPoints
    let len;
    let data = new AxisPoints(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [major_axis_p1]
    data.major_axis_p1 = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset);
    // Deserialize message field [major_axis_p2]
    data.major_axis_p2 = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset);
    // Deserialize message field [minor_axis_p1]
    data.minor_axis_p1 = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset);
    // Deserialize message field [minor_axis_p2]
    data.minor_axis_p2 = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset);
    // Deserialize message field [orientation]
    data.orientation = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [major_axis_len]
    data.major_axis_len = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [minor_axis_len]
    data.minor_axis_len = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 120;
  }

  static datatype() {
    // Returns string type for a message object
    return 'corrosion_detector/AxisPoints';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c40b075900f16fe11733d8a1bb7afb1b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    std_msgs/Header header
    
    # List of 2D points
    geometry_msgs/Point major_axis_p1
    geometry_msgs/Point major_axis_p2
    geometry_msgs/Point minor_axis_p1
    geometry_msgs/Point minor_axis_p2
    
    # Orientation of the axis (yaw in radians)
    float64 orientation
    
    # Axis lenghts
    float64 major_axis_len
    float64 minor_axis_len
    
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
    
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new AxisPoints(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.major_axis_p1 !== undefined) {
      resolved.major_axis_p1 = geometry_msgs.msg.Point.Resolve(msg.major_axis_p1)
    }
    else {
      resolved.major_axis_p1 = new geometry_msgs.msg.Point()
    }

    if (msg.major_axis_p2 !== undefined) {
      resolved.major_axis_p2 = geometry_msgs.msg.Point.Resolve(msg.major_axis_p2)
    }
    else {
      resolved.major_axis_p2 = new geometry_msgs.msg.Point()
    }

    if (msg.minor_axis_p1 !== undefined) {
      resolved.minor_axis_p1 = geometry_msgs.msg.Point.Resolve(msg.minor_axis_p1)
    }
    else {
      resolved.minor_axis_p1 = new geometry_msgs.msg.Point()
    }

    if (msg.minor_axis_p2 !== undefined) {
      resolved.minor_axis_p2 = geometry_msgs.msg.Point.Resolve(msg.minor_axis_p2)
    }
    else {
      resolved.minor_axis_p2 = new geometry_msgs.msg.Point()
    }

    if (msg.orientation !== undefined) {
      resolved.orientation = msg.orientation;
    }
    else {
      resolved.orientation = 0.0
    }

    if (msg.major_axis_len !== undefined) {
      resolved.major_axis_len = msg.major_axis_len;
    }
    else {
      resolved.major_axis_len = 0.0
    }

    if (msg.minor_axis_len !== undefined) {
      resolved.minor_axis_len = msg.minor_axis_len;
    }
    else {
      resolved.minor_axis_len = 0.0
    }

    return resolved;
    }
};

module.exports = AxisPoints;

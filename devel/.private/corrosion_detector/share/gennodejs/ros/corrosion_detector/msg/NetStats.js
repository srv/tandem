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

class NetStats {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.scale_m_per_px = null;
      this.median_hole_area_px = null;
      this.median_hole_area_m2 = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('scale_m_per_px')) {
        this.scale_m_per_px = initObj.scale_m_per_px
      }
      else {
        this.scale_m_per_px = 0.0;
      }
      if (initObj.hasOwnProperty('median_hole_area_px')) {
        this.median_hole_area_px = initObj.median_hole_area_px
      }
      else {
        this.median_hole_area_px = 0.0;
      }
      if (initObj.hasOwnProperty('median_hole_area_m2')) {
        this.median_hole_area_m2 = initObj.median_hole_area_m2
      }
      else {
        this.median_hole_area_m2 = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type NetStats
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [scale_m_per_px]
    bufferOffset = _serializer.float32(obj.scale_m_per_px, buffer, bufferOffset);
    // Serialize message field [median_hole_area_px]
    bufferOffset = _serializer.float32(obj.median_hole_area_px, buffer, bufferOffset);
    // Serialize message field [median_hole_area_m2]
    bufferOffset = _serializer.float32(obj.median_hole_area_m2, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type NetStats
    let len;
    let data = new NetStats(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [scale_m_per_px]
    data.scale_m_per_px = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [median_hole_area_px]
    data.median_hole_area_px = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [median_hole_area_m2]
    data.median_hole_area_m2 = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'corrosion_detector/NetStats';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f0b14b7f5d4cea4e0f0d1ef78c891d2e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    
    # Escala calculada (metros/pixel)
    float32 scale_m_per_px
    
    # Área mediana de los hexágonos (en píxeles cuadrados)
    float32 median_hole_area_px
    
    # (Opcional) Área mediana en metros cuadrados (por si la quiere directa)
    float32 median_hole_area_m2
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
    const resolved = new NetStats(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.scale_m_per_px !== undefined) {
      resolved.scale_m_per_px = msg.scale_m_per_px;
    }
    else {
      resolved.scale_m_per_px = 0.0
    }

    if (msg.median_hole_area_px !== undefined) {
      resolved.median_hole_area_px = msg.median_hole_area_px;
    }
    else {
      resolved.median_hole_area_px = 0.0
    }

    if (msg.median_hole_area_m2 !== undefined) {
      resolved.median_hole_area_m2 = msg.median_hole_area_m2;
    }
    else {
      resolved.median_hole_area_m2 = 0.0
    }

    return resolved;
    }
};

module.exports = NetStats;

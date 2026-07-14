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

class BoundingBox {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.class_id = null;
      this.score = null;
      this.x = null;
      this.y = null;
      this.w = null;
      this.h = null;
      this.corr_x = null;
      this.corr_y = null;
      this.std_x = null;
      this.std_y = null;
      this.area = null;
      this.width = null;
      this.height = null;
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
      if (initObj.hasOwnProperty('w')) {
        this.w = initObj.w
      }
      else {
        this.w = 0.0;
      }
      if (initObj.hasOwnProperty('h')) {
        this.h = initObj.h
      }
      else {
        this.h = 0.0;
      }
      if (initObj.hasOwnProperty('corr_x')) {
        this.corr_x = initObj.corr_x
      }
      else {
        this.corr_x = 0.0;
      }
      if (initObj.hasOwnProperty('corr_y')) {
        this.corr_y = initObj.corr_y
      }
      else {
        this.corr_y = 0.0;
      }
      if (initObj.hasOwnProperty('std_x')) {
        this.std_x = initObj.std_x
      }
      else {
        this.std_x = 0.0;
      }
      if (initObj.hasOwnProperty('std_y')) {
        this.std_y = initObj.std_y
      }
      else {
        this.std_y = 0.0;
      }
      if (initObj.hasOwnProperty('area')) {
        this.area = initObj.area
      }
      else {
        this.area = 0.0;
      }
      if (initObj.hasOwnProperty('width')) {
        this.width = initObj.width
      }
      else {
        this.width = 0;
      }
      if (initObj.hasOwnProperty('height')) {
        this.height = initObj.height
      }
      else {
        this.height = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type BoundingBox
    // Serialize message field [class_id]
    bufferOffset = _serializer.string(obj.class_id, buffer, bufferOffset);
    // Serialize message field [score]
    bufferOffset = _serializer.float64(obj.score, buffer, bufferOffset);
    // Serialize message field [x]
    bufferOffset = _serializer.float64(obj.x, buffer, bufferOffset);
    // Serialize message field [y]
    bufferOffset = _serializer.float64(obj.y, buffer, bufferOffset);
    // Serialize message field [w]
    bufferOffset = _serializer.float64(obj.w, buffer, bufferOffset);
    // Serialize message field [h]
    bufferOffset = _serializer.float64(obj.h, buffer, bufferOffset);
    // Serialize message field [corr_x]
    bufferOffset = _serializer.float64(obj.corr_x, buffer, bufferOffset);
    // Serialize message field [corr_y]
    bufferOffset = _serializer.float64(obj.corr_y, buffer, bufferOffset);
    // Serialize message field [std_x]
    bufferOffset = _serializer.float64(obj.std_x, buffer, bufferOffset);
    // Serialize message field [std_y]
    bufferOffset = _serializer.float64(obj.std_y, buffer, bufferOffset);
    // Serialize message field [area]
    bufferOffset = _serializer.float64(obj.area, buffer, bufferOffset);
    // Serialize message field [width]
    bufferOffset = _serializer.int16(obj.width, buffer, bufferOffset);
    // Serialize message field [height]
    bufferOffset = _serializer.int16(obj.height, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type BoundingBox
    let len;
    let data = new BoundingBox(null);
    // Deserialize message field [class_id]
    data.class_id = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [score]
    data.score = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [x]
    data.x = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [y]
    data.y = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [w]
    data.w = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [h]
    data.h = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [corr_x]
    data.corr_x = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [corr_y]
    data.corr_y = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [std_x]
    data.std_x = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [std_y]
    data.std_y = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [area]
    data.area = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [width]
    data.width = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [height]
    data.height = _deserializer.int16(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.class_id);
    return length + 88;
  }

  static datatype() {
    // Returns string type for a message object
    return 'corrosion_detector/BoundingBox';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ce1d7034235b18cb9d0c6436906febbb';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string class_id      # "0", "person", etc.
    float64 score        # Probabilidad (0.0 a 1.0)
    
    # Coordenadas NORMALIZADAS (0.0 a 1.0)
    # Es lo estándar en YOLO y facilita la vida al siguiente nodo
    float64 x            # Centro X
    float64 y            # Centro Y
    float64 w            # Ancho
    float64 h            # Alto
    
    # Coordenades normalitzades del Punt de corrosió
    float64 corr_x
    float64 corr_y
    float64 std_x
    float64 std_y
    float64 area
    int16 width
    int16 height
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new BoundingBox(null);
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

    if (msg.w !== undefined) {
      resolved.w = msg.w;
    }
    else {
      resolved.w = 0.0
    }

    if (msg.h !== undefined) {
      resolved.h = msg.h;
    }
    else {
      resolved.h = 0.0
    }

    if (msg.corr_x !== undefined) {
      resolved.corr_x = msg.corr_x;
    }
    else {
      resolved.corr_x = 0.0
    }

    if (msg.corr_y !== undefined) {
      resolved.corr_y = msg.corr_y;
    }
    else {
      resolved.corr_y = 0.0
    }

    if (msg.std_x !== undefined) {
      resolved.std_x = msg.std_x;
    }
    else {
      resolved.std_x = 0.0
    }

    if (msg.std_y !== undefined) {
      resolved.std_y = msg.std_y;
    }
    else {
      resolved.std_y = 0.0
    }

    if (msg.area !== undefined) {
      resolved.area = msg.area;
    }
    else {
      resolved.area = 0.0
    }

    if (msg.width !== undefined) {
      resolved.width = msg.width;
    }
    else {
      resolved.width = 0
    }

    if (msg.height !== undefined) {
      resolved.height = msg.height;
    }
    else {
      resolved.height = 0
    }

    return resolved;
    }
};

module.exports = BoundingBox;

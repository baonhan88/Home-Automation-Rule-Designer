//
//  Constant.swift
//  HomeAutomationRuleDesigner
//
//  Created by Nhan on 22/01/2018.
//  Copyright © 2018 SLab. All rights reserved.
//

import Foundation

public let kPropertyTypeList: [String] = ["number", "string", "boolean", "date"]
public let kOperatorTypeList: [String] = ["==", "!=", ">", ">=", "<", "<="]
//public let kConditionalElementTypeList: [String] = ["and", "or", "exists", "forall"]
public let kConditionalElementTypeList: [String] = ["and", "or", "accumulate"]
public let kAccumulateResultTypeList: [String] = ["intValue", "doubleValue"]
public let kAccumulateWindowTypeList: [String] = ["time", "length"]
public let kAccumulateCalculateTypeList: [String] = ["average", "min", "max", "count", "sum"]

public let kObjectTypeList: [String] = ["Light", "TemperatureSensor", "HumiditySensor", "Room", "FamilyMember", "Camera", "CameraOld", "DataMiningThermostat", "Thermostat", "Alarm", "MotionSensor"]

public let kLightPropertyList: [String] = ["id", "timestamp", "isOn", "productName", "name", "locatedAtRoomId", "color", "brightness", "colorTemperature", "alert", "effect"]
public let kLightPropertyTypeList: [String] = ["string", "number", "boolean", "string", "string", "string", "string", "number", "number", "string", "string"]

public let kTemperatureSensorPropertyList: [String] = ["id", "timestamp", "isOn", "productName", "name", "locatedAtRoomId", "isActive", "uiColorState", "value", "type", "temperatureValue"]
public let kTemperatureSensorPropertyTypeList: [String] = ["string", "number", "boolean", "string", "string", "string", "boolean", "string", "number", "string", "number"]

public let kHumiditySensorPropertyList: [String] = ["id", "timestamp", "isOn", "productName", "name", "locatedAtRoomId", "isActive", "uiColorState", "value", "type", "humidityValue"]
public let kHumiditySensorPropertyTypeList: [String] = ["string", "number", "boolean", "string", "string", "string", "boolean", "string", "number", "string", "number"]

public let kRoomPropertyList: [String] = ["id", "timestamp", "roomName", "roomType", "windowStatus", "doorStatus", "curtainStatus", "noiseIntensity", "lightIntensity", "temperature", "longtitude", "latitude"]
public let kRoomPropertyTypeList: [String] = ["string", "number", "string", "string", "string", "string", "string", "number", "number", "number", "number", "number"]

public let kFamilyMemberPropertyList: [String] = ["id", "timestamp", "name", "age", "gender", "dateOfBirth", "homeAddress", "occupation", "locatedAtRoomId", "activityId", "familyName", "doctorAdvisorName", "doctorAdvisorId", "healthStatus", "type"]
public let kFamilyMemberPropertyTypeList: [String] = ["string", "number", "string", "number", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string"]

public let kCameraPropertyList: [String] = ["id", "timestamp", "isOn", "productName", "name", "locatedAtRoomId", "alarmState", "isStreaming", "numOfSitting", "numOfStanding", "numOfLying", "numOfPeople"]
public let kCameraPropertyTypeList: [String] = ["string", "number", "boolean", "string", "string", "string", "string", "boolean", "number", "number", "number", "number"]

public let kCameraOldPropertyList: [String] = ["id", "timestamp", "isOn", "productName", "name", "locatedAtRoomId", "alarmState", "isStreaming", "numOfPeople"]
public let kCameraOldPropertyTypeList: [String] = ["string", "number", "boolean", "string", "string", "string", "string", "boolean", "number"]

public let kThermostatPropertyList: [String] = ["id", "timestamp", "isOn", "productName", "name", "locatedAtRoomId", "canCool", "canHeat", "hasFan", "hasLeaf", "humidity", "isTemperatureLocked", "isLockedMinRange", "isLockedMaxRange", "mode", "previousMode", "state", "currentTemperature", "temperatureSet", "isUsingEmergencyHeat", "isSunlightCorrectionEnabled", "isSunlightCorrectionActive"]
public let kThermostatPropertyTypeList: [String] = ["string", "number", "boolean", "string", "string", "string", "boolean", "boolean", "boolean", "boolean", "number", "boolean", "boolean", "boolean", "string", "string", "string", "number", "number", "boolean", "boolean", "boolean"]

public let kAlarmPropertyList: [String] = ["id", "timestamp", "isOn", "productName", "name", "locatedAtRoomId", "state", "tts"]
public let kAlarmPropertyTypeList: [String] = ["string", "number", "boolean", "string", "string", "string", "string", "string"]

public let kMotionSensorPropertyList: [String] = ["id", "timestamp", "isOn", "productName", "name", "locatedAtRoomId", "presence"]
public let kMotionSensorPropertyTypeList: [String] = ["string", "number", "boolean", "string", "string", "string", "boolean"]

//public let kDataMiningThermostatPropertyList: [String] = ["id", "timestamp", "temperature", "humidity", "temperatureSet"]
//public let kDataMiningThermostatPropertyTypeList: [String] = ["string", "number", "number", "number", "number"]
public let kDataMiningThermostatPropertyList: [String] = ["temperatureSet"]
public let kDataMiningThermostatPropertyTypeList: [String] = ["number"]

public let kRuleListKey = "rules"

public let kTargetRule = "rule"

public let kCommandTypeInsert = "insert"
public let kCommandTypeDelete = "delete"
public let kCommandTypeDeleteAll = "deleteAll"

public let kActionTypeInsert = "insert"
public let kActionTypeModify = "modify"
public let kActionTypeDelete = "delete"

//public let kSocketServerHost = "192.168.0.167" // Android S5
public let kSocketServerHost = "192.168.1.235" // odroid board
//public let kSocketServerHost = "192.168.1.186" // Raspberry Pi 3 board
public let kSocketServerPort = 5111
public let kSocketServerTimeout = 2500


# Install script for directory: /home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/rosuser/repo/tandem_vicent_ws/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
        file(MAKE_DIRECTORY "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
      endif()
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin")
        file(WRITE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin" "")
      endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/rosuser/repo/tandem_vicent_ws/install/_setup_util.py")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/rosuser/repo/tandem_vicent_ws/install" TYPE PROGRAM FILES "/home/rosuser/repo/tandem_vicent_ws/build/cola2_msgs/catkin_generated/installspace/_setup_util.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/rosuser/repo/tandem_vicent_ws/install/env.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/rosuser/repo/tandem_vicent_ws/install" TYPE PROGRAM FILES "/home/rosuser/repo/tandem_vicent_ws/build/cola2_msgs/catkin_generated/installspace/env.sh")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/rosuser/repo/tandem_vicent_ws/install/setup.bash;/home/rosuser/repo/tandem_vicent_ws/install/local_setup.bash")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/rosuser/repo/tandem_vicent_ws/install" TYPE FILE FILES
    "/home/rosuser/repo/tandem_vicent_ws/build/cola2_msgs/catkin_generated/installspace/setup.bash"
    "/home/rosuser/repo/tandem_vicent_ws/build/cola2_msgs/catkin_generated/installspace/local_setup.bash"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/rosuser/repo/tandem_vicent_ws/install/setup.sh;/home/rosuser/repo/tandem_vicent_ws/install/local_setup.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/rosuser/repo/tandem_vicent_ws/install" TYPE FILE FILES
    "/home/rosuser/repo/tandem_vicent_ws/build/cola2_msgs/catkin_generated/installspace/setup.sh"
    "/home/rosuser/repo/tandem_vicent_ws/build/cola2_msgs/catkin_generated/installspace/local_setup.sh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/rosuser/repo/tandem_vicent_ws/install/setup.zsh;/home/rosuser/repo/tandem_vicent_ws/install/local_setup.zsh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/rosuser/repo/tandem_vicent_ws/install" TYPE FILE FILES
    "/home/rosuser/repo/tandem_vicent_ws/build/cola2_msgs/catkin_generated/installspace/setup.zsh"
    "/home/rosuser/repo/tandem_vicent_ws/build/cola2_msgs/catkin_generated/installspace/local_setup.zsh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/rosuser/repo/tandem_vicent_ws/install/setup.fish;/home/rosuser/repo/tandem_vicent_ws/install/local_setup.fish")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/rosuser/repo/tandem_vicent_ws/install" TYPE FILE FILES
    "/home/rosuser/repo/tandem_vicent_ws/build/cola2_msgs/catkin_generated/installspace/setup.fish"
    "/home/rosuser/repo/tandem_vicent_ws/build/cola2_msgs/catkin_generated/installspace/local_setup.fish"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/rosuser/repo/tandem_vicent_ws/install/.rosinstall")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/rosuser/repo/tandem_vicent_ws/install" TYPE FILE FILES "/home/rosuser/repo/tandem_vicent_ws/build/cola2_msgs/catkin_generated/installspace/.rosinstall")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/cola2_msgs/msg" TYPE FILE FILES
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/BodyForceReq.msg"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/BodyVelocityReq.msg"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/Bool6Axis.msg"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/CaptainStateFeedback.msg"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/CaptainStatus.msg"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/DVL.msg"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/DVLBeam.msg"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/DecimalLatLon.msg"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/Float32Stamped.msg"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/FlsConfig.msg"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/GoalDescriptor.msg"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/ImageAcquisitionSettings.msg"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/KeyValue.msg"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/KeyValueArray.msg"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/MissionState.msg"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/NED.msg"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/NavSts.msg"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/RPY.msg"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/RecoveryAction.msg"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/SSSConfig.msg"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/SafetySupervisorStatus.msg"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/Setpoints.msg"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/msg/WorldWaypointReq.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/cola2_msgs/srv" TYPE FILE FILES
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/srv/Action.srv"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/srv/DigitalOutput.srv"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/srv/Goto.srv"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/srv/MaxJoyVelocity.srv"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/srv/Mission.srv"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/srv/Recovery.srv"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/srv/Section.srv"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/srv/String.srv"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/cola2_msgs/action" TYPE FILE FILES "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/action/Pilot.action")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/cola2_msgs/msg" TYPE FILE FILES
    "/home/rosuser/repo/tandem_vicent_ws/devel/.private/cola2_msgs/share/cola2_msgs/msg/PilotAction.msg"
    "/home/rosuser/repo/tandem_vicent_ws/devel/.private/cola2_msgs/share/cola2_msgs/msg/PilotActionGoal.msg"
    "/home/rosuser/repo/tandem_vicent_ws/devel/.private/cola2_msgs/share/cola2_msgs/msg/PilotActionResult.msg"
    "/home/rosuser/repo/tandem_vicent_ws/devel/.private/cola2_msgs/share/cola2_msgs/msg/PilotActionFeedback.msg"
    "/home/rosuser/repo/tandem_vicent_ws/devel/.private/cola2_msgs/share/cola2_msgs/msg/PilotGoal.msg"
    "/home/rosuser/repo/tandem_vicent_ws/devel/.private/cola2_msgs/share/cola2_msgs/msg/PilotResult.msg"
    "/home/rosuser/repo/tandem_vicent_ws/devel/.private/cola2_msgs/share/cola2_msgs/msg/PilotFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/cola2_msgs/cmake" TYPE FILE FILES "/home/rosuser/repo/tandem_vicent_ws/build/cola2_msgs/catkin_generated/installspace/cola2_msgs-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/rosuser/repo/tandem_vicent_ws/devel/.private/cola2_msgs/include/cola2_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/rosuser/repo/tandem_vicent_ws/devel/.private/cola2_msgs/share/roseus/ros/cola2_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/rosuser/repo/tandem_vicent_ws/devel/.private/cola2_msgs/share/common-lisp/ros/cola2_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/rosuser/repo/tandem_vicent_ws/devel/.private/cola2_msgs/share/gennodejs/ros/cola2_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/home/rosuser/miniconda3/envs/yolo_env/bin/python3" -m compileall "/home/rosuser/repo/tandem_vicent_ws/devel/.private/cola2_msgs/lib/python3/dist-packages/cola2_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/rosuser/repo/tandem_vicent_ws/devel/.private/cola2_msgs/lib/python3/dist-packages/cola2_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/rosuser/repo/tandem_vicent_ws/build/cola2_msgs/catkin_generated/installspace/cola2_msgs.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/cola2_msgs/cmake" TYPE FILE FILES "/home/rosuser/repo/tandem_vicent_ws/build/cola2_msgs/catkin_generated/installspace/cola2_msgs-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/cola2_msgs/cmake" TYPE FILE FILES
    "/home/rosuser/repo/tandem_vicent_ws/build/cola2_msgs/catkin_generated/installspace/cola2_msgsConfig.cmake"
    "/home/rosuser/repo/tandem_vicent_ws/build/cola2_msgs/catkin_generated/installspace/cola2_msgsConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/cola2_msgs" TYPE FILE FILES "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/package.xml")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/cola2_msgs" TYPE FILE FILES
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/LICENSE.txt"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/README.md"
    "/home/rosuser/repo/tandem_vicent_ws/src/cola2_msgs/CHANGELOG.md"
    )
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/rosuser/repo/tandem_vicent_ws/build/cola2_msgs/gtest/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/rosuser/repo/tandem_vicent_ws/build/cola2_msgs/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")

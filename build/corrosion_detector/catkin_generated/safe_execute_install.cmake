execute_process(COMMAND "/home/rosuser/repo/tandem_vicent_ws/build/corrosion_detector/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/rosuser/repo/tandem_vicent_ws/build/corrosion_detector/catkin_generated/python_distutils_install.sh) returned error code ")
endif()

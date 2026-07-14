#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/rosuser/repo/tandem_vicent_ws/src/corrosion_detector"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/rosuser/repo/tandem_vicent_ws/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/rosuser/repo/tandem_vicent_ws/install/lib/python3/dist-packages:/home/rosuser/repo/tandem_vicent_ws/build/corrosion_detector/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/rosuser/repo/tandem_vicent_ws/build/corrosion_detector" \
    "/home/rosuser/miniconda3/envs/yolo_env/bin/python3" \
    "/home/rosuser/repo/tandem_vicent_ws/src/corrosion_detector/setup.py" \
     \
    build --build-base "/home/rosuser/repo/tandem_vicent_ws/build/corrosion_detector" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/rosuser/repo/tandem_vicent_ws/install" --install-scripts="/home/rosuser/repo/tandem_vicent_ws/install/bin"

cmake_minimum_required(VERSION 3.22)
project(zoey-sos VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(At6 REQUIRED COMPONENTS Core Gui Qml Quick QuickControls2)
find_package(KF6Kirigami REQUIRED)

qt_policy(SET QTP0004 NEW)

add_executable(zoey-sos
    src/main.cpp
)

qt_add_qml_module(zoey-sos
    URI Zoey.Sos
    VERSION 1.0
    RESOURCE_PREFIX /
    QML_FILES
        qml/Main.qml
)

target_link_libraries(zoey-sos PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickControls2
    KF6::Kirigami
)

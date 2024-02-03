cmake_minimum_required(VERSION 3.16)

project(Telemetry1 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

#set(CMAKE_AUTOMOC ON)
#set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

qt_add_executable(appTelemetry1
    main.cpp
    Resources.qrc
)

qt_add_qml_module(appTelemetry1
    URI Telemetry1
    VERSION 1.0
    QML_FILES Main.qml
    RESOURCES Resources.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appTelemetry1 PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appTelemetry1
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appTelemetry1
    PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appTelemetry1
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)


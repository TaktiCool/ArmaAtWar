#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Adds a new Group to the MapGraphics-System

    Parameter(s):
    0: Group Name <STRING>
    1: Group Data <ARRAY>
    2: Group Layer <NUMBER>

    Remarks:
    Group Data is defined as <ARRAY> of GraphicsElements of following Structure:
    0: Class <STRING> (ICON | RECTANGLE | ELLIPSE | LINE | ARROW | POLYGON)
    1: Class Data <ARRAY>
        ICON:
            0: Texture <String>
            1: Color <Array> [r,g,b,a]
            2: Position <MapGraphicsPosition>
            3: Width <Number>
            4: Height <Number>
            5: Angle <Number>
            6: Text <String>
            7: Shadow <Boolean/Number>
            8: Text Size <Number>
            9: Font <String>
            10: Align <String>
        RECTANGLE:
            0: Center Position <MapGraphicsPosition>
            1: Width <Number | ['m','screen', NUMBER]>
            2: Height <Number | ['m','screen', NUMBER]>
            3: Angle <Number>
            4: Line Color <Array> [r,g,b,a]
            5: Fill Color <Array> [r,g,b,a]
        ELLIPSE:
            0: Center Position <MapGraphicsPosition>
            1: Width <Number | ['m','screen', NUMBER]>
            2: Height <Number | ['m','screen', NUMBER]>
            3: Angle <Number>
            4: Line Color <Array> [r,g,b,a]
            5: Fill Color <Array> [r,g,b,a]
        LINE:
            0: Position 1 <MapGraphicsPosition>
            1: Position 2 <MapGraphicsPosition>
            2: Line Color <Array> [r,g,b,a]
        ARROW:
            0: Position 1 <MapGraphicsPosition>
            1: Position 2 <MapGraphicsPosition>
            2: Line Color <Array> [r,g,b,a]
        POLYGON:
            0: Positions <Array> of MapGraphicsPosition
            1: Line Color <Array> [r,g,b,a]
    2: Code <Code> called every frame

    <MapGraphicsPosition>:
    OBJECT | POSITION3D | POSITION2D | [OBJECT | POSITION3D | POSITION2D,[ScreenOffsetX,ScreenOffsetY]]

    Returns:
    None
*/
params ["_groupName", "_groupData", ["_layer",0]];

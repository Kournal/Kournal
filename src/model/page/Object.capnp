@0xf3cc205a74b9f2a2;

#
# Kournal Binary Journal  main building block of any document – object
#
# Kournal
# Copyright (C) 2015  Marek Pikuła
# https://github.com/Kournal/Kournal
#
# This file is part of Kournal.
#
# Kournal is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation, either version 2 of the License, or (at your option) any later version.
#
# Kournal is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with Kournal.
# If not, see <http://www.gnu.org/licenses/>.
#

using Common = import "../Common.capnp";

struct Object @0xdc4eba3194719864 {
    # Main building block of journal

    union {
        imported :group {
            # There is some object painted on this page with declaration on some other

            page @0 :Common.PageCoords;                 # Coordinates of page imported from
            id @1 :UInt32;                              # ID of imported object
        }
        contained :group {
            # Object contained by this specific page

            id @2 :UInt32;                              # ID of object – unique for page
            startingPoint @3 :Common.F64Coords;         # Coordinates of startingPoint (can be treated differently
                                                        #   for different types of object)
            transform @4 :Transformation;               # Transformers of object
            renderPages @5 :List(Common.PageCoords);    # List of pages where object is also rendered
            layer @6 :Int32;                            # Layer ID

            union {
                # See documentation of structs

                stroke @7 :Stroke;
                shape @8 :Shape;
                text @9 :Text;
                image @10 :Image;
                document @11 :Document;
                math @12 :Math;
                link @13 :Link;
            }
        }
    }


    struct Stroke @0xfe02439054caf718 {
        # Basic stroke – free hand
        # Transformation recalculates values of points

        color @0 :UInt32;                   # RGBA color of stroke
        points @1 :List(StrokePoint);       # List of points
        type @2 :StrokeType;                # Type of stroke

        struct StrokePoint @0xe70fe9797511d775 {
            x @0 :Float32;                  # X coordinate of point
            y @1 :Float32;                  # Y coordinate of point
            width @2 :Float32;              # Width of stroke in current point
        }

        struct StrokeType @0x92cb02c4a3d33e41 {
            union {
                pen @0 :Void;               # Normal pen
                highlighter @1 :Void;       # Highlighter
                shape @2 :Shape;            # Custom shape (fill/border are preserved)
            }
        }
    }

    struct Shape @0xb44ef4a26759a9e1 {
        # More specific shapes
        # Transformation recalculares shapes

        baseColor @0 :UInt32;               # Base color of shape (it doesn't have to be redefined in every shape
                                            # struct – every shape has something in common with color) – what exactly
                                            # it is, is defined in docs of struct

        union {
            line @1 :Line;
            polygon @2 :Polygon;

            # a lot TODO
        }

        struct Line @0xf05f5f121eb786c0 {
            # baseColor is just pen color

            point1 @0 :Common.F32Coords;    # Coordinates of first point of line
            point1style @1 :PenCapStyle;    # Style of line first ending
            point2 @2 :Common.F32Coords;    # Coordinates of second point of line
            point2style @3 :PenCapStyle;    # Style of line second ending

            width @4 :Float32;              # Width of line

            style @5 :PenStyle;             # Style of line
        }

        struct Polygon @0xc043a13896ca32fa {
            # baseColor is pen color

            points @0 :List(Common.F32Coords);  # List of points of

            brush @1 :UInt32 = 0;               # Color of infill (RGBA)
            brushStyle @2 :BrushStyle;
            fillRule @3 :FillRule;
            penStyle @4 :PenStyle;
        }
    }

    struct Text @0x9f55f7f9447a542a {
        # Text with or without formatting allowed by Qt WebView
        # All transformations are performed live

        region @0 :Common.F32Coords;        # End point of rectangle of text field region
        union {
            text @1 :Text;                  # Just short embedded hardly formatted text
                                            #   TODO: Qt::AlignmentFlag
            resource @2 :UInt32;            # Resource ID of rich formatted text
        }
    }

    struct Image @0xb1cfb3dac8b271f1 {
        # Standard QPixmap compatible image or SVG (depends on resource type)
        # All transformations are performed live

        resourceId @0 :UInt32;                  # Reference to resource
        region @1 :Common.F32RegionEntireSel;   # Region of imported image
    }

    struct Document @0x870173a01af009e8 {
        # Document page or part of it
        # All transformations are performed live

        resourceId @0 :UInt32;                  # Reference to resource
        page @1 :UInt32;                        # Page number
        region @2 :Common.F32RegionEntireSel;   # Region of imported document
    }

    struct Math @0xcc991920426d6e11 {
        # Math stuff (equation, graph and so on)
        # All transformations are performed live

        # Huge TODO sign – lot of research, lot of thinking
    }

    struct Link @0xc19e6c4a28adcddf {
        # Visible link to bookmark/resource/URI
        # All transformations are performed live with

        region @0 :Common.F32Rectangle;     # Region where link is shown
        layout @1 :LinkLayout;              # Layout of link
        text :union {
            default @2 :Void;               # Use default text extracted from element
            custom @3 :Text;                # Custom title of link
        }

        union {
            bookmark @4 :UInt32;            # Reference to bookmark
            resource @5 :UInt32;            # Reference to resource
            uri :group {
                uri @6 :Text;               # URI text
                icon @7 :UInt32;            # Reference to icon resource
            }
        }

        enum LinkLayout @0x80393ac0c529f6cf {
            # Layout of link
            # U, D, L, R stands respectively for up, down, left, right position of specific item
            # P stands for "with preview"

            uIconDText @0;      # Icon up, text down
            uIconDTextP @1;     # Preview up, text down
            lIconRText @2;      # Icon left, text right
            rIconLText @3;      # Icon right, text left
            icon @4;            # Icon only
            iconP @5;           # Preview only
            text @6;            # Text only
        }
    }
}

struct Transformation @0x81d42e8abe8e9ed9 {
    # Describes transformations of object all in Float32, because most of objects are transformed live
    # (see object's docs)

    scale @0 :Common.F32Coords;             # Scaling
    shear @1 :Common.F32Coords;             # Shearing
    rotateOrigin @2 :Common.F32Coords;      # Origin of rotation
    rotate @3 :Float32;                     # Rotation value (see QTransform::rotate)
    perspective :union {
        none @4 :Void;                      # If not used what for waste 16B of memory
        use :group {                        # Define 4 corners of perspective polygon
            point1 @5 :Float32;
            point2 @6 :Float32;
            point3 @7 :Float32;
            point4 @8 :Float32;
        }
    }
}


# Styles

struct PenStyle @0xd4492d01514c489e {
    # Copy of Qt::PenStyle (http://doc.qt.io/qt-5/qt.html#PenStyle-enum)

    union {
        noPen @0 :Void;                     # No line at all
        solidLine @1 :Void;                 # A plain line.
        dashLine @2 :Void;                  # Dashes separated by a few pixels.
        dotLine @3 :Void;                   # Dots separated by a few pixels.
        dashDotLine @4 :Void;               # Alternate dots and dashes.
        dashDotDotLine @5 :Void;            # One dash, two dots, one dash, two dots.
        customDashLine @6 :List(Float32);   # A custom pattern – lengths of the dashes and spaces in the stroke
    }
}

struct BrushStyle @0xcc914c7f723a4b0f {
    # Copy of Qt::BrushStyle (http://doc.qt.io/qt-5/qt.html#BrushStyle-enum)

    union {
        noBrush @0 :Void;                   # No brush pattern
        solidPattern @1 :Void;              # Uniform color
        dense1Pattern @2 :Void;             # Extremely dense brush pattern
        dense2Pattern @3 :Void;             # Very dense brush pattern
        dense3Pattern @4 :Void;             # Somewhat dense brush pattern
        dense4Pattern @5 :Void;             # Half dense brush pattern
        dense5Pattern @6 :Void;             # Somewhat sparse brush pattern
        dense6Pattern @7 :Void;             # Very sparse brush pattern
        dense7Pattern @8 :Void;             # Extremely sparse brush pattern
        horPattern @9 :Void;                # Horizontal lines
        verPattern @10 :Void;               # Vertical lines
        crossPattern @11 :Void;             # Crossing horizontal and vertical lines
        bDiagPattern @12 :Void;             # Backward diagonal lines
        fDiagPattern @13 :Void;             # Forward diagonal lines
        diagCrossPattern @14 :Void;         # Crossing diagonal lines
        linearGradientPattern @15 :Void;    # Linear gradient (set using a dedicated QBrush constructor)
        conicalGradientPattern @17 :Void;   # Conical gradient (set using a dedicated QBrush constructor)
        radialGradientPattern @16 :Void;    # Radial gradient (set using a dedicated QBrush constructor)
        texturePattern @18 :UInt32;         # Custom pattern (resource id) (note: in Qt::BrushStyle it's enum 24)
    }
}

enum FillRule @0xd51233aa95c3f217 {
    # Copy of Qt::FillRule (http://doc.qt.io/qt-5/qt.html#FillRule-enum) – see there for docs

    oddEvenFill @0;
    windingFill @1;
}

enum PenCapStyle @0xc93fd5ec10bb0012 {
    # Copy of Qt::PenCapStyle (http://doc.qt.io/qt-5/qt.html#PenCapStyle-enum)

    flatCap @0;         # A square line end that does not cover the end point of the line
    squareCap @1;       # A square line end that covers the end point and extends beyond it by half the line width
    roundCap @2;        # Rounded line end
}

enum PenJoinStyle @0xda200e4012e6210f {
    # Copy of Qt::PenJoinStyle (http://doc.qt.io/qt-5/qt.html#PenJoinStyle-enum)

    miterJoin @0;       # The outer edges of the lines are extended to meet at an angle, and this area is filled
    bevelJoin @1;       # The triangular notch between the two lines is filled
    roundJoin @2;       # A circular arc between the two lines is filled
    svgMiterJoin @3;    # A miter join corresponding to the definition of a miter join in the SVG 1.2 Tiny specification
}

@0xb1fff6f6917f609a;

#
# Kournal Binary Journal  Cap'n'proto file format scheme
#
# Kournal
# Copyright (C) 2015  Marek Pikuła
# <https://github.com/Kournal/Kournal>
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

# Disclaimer: Until Kournal lays in alpha state this is only a draft and in future it'll be surely changed without 
#             warning nor preserving backwards compatibility. Therefore it shouldn't be used in production environment.
#             Some properties in this scheme are waiting for implementation and can be presumed as preview of future
#             Kournal functions.

struct Journal @0x9707008195388520 {
    # Base Kournal Binary Journal file struct
    
    metadata @0 :BasicMetadata;         # Document metadata (thumbnail defined by user, default last view of last tab)
    author @1 :Text;                    # Author of document
    additional @2 :Text;                # Additional variable JSON data
    
    lastTab @3 :UInt32;                 # Last used tab
    tabs @4 :List(Tab);                 # List of document tabs
    
    struct Tab @0x85132b574bd1c03b {
        # Defines document tab
        
        metadata @0 :BasicMetadata;     # Tab metadata (thumbnail of `lastView` or defined by user)
        color @1 :UInt32;               # Tab color in RGB (no alpha channel!)
        additional @2 :Text;            # Additional variable JSON data
        
        
        type @3 :TabType;
        
        enum TabType @0xd15a9c30c8fe33dc {
            # Type of tab
            
            page @0;                    # Classic paginated document
            scroll @1;                  # Single scroll of paper
            sCartesian @2;              # 2D cartesian signed space
            uCartesian @3;              # 2D cartesian unsigned space
        }
        
        
        lastView @4 :TabView;           # Last view of tab
        
        struct TabView @0xced2c65c87033d2f {
            # State of tab – position and zoom of middle point of view
            
            page @0 :PageCoords;        # Coordinates/position of page
            point @1 :F64Coords;        # Coordinates of middle point of view on `page`
            scale @2 :Float64;          # Scaling of view
        }
        
        
        pageIndex @5 :List(PageCoords); # List of page coordinates – no need to get entire document to see only part
        
        pages @6 :List(Page);           # List of pages – index corresponding to pageIndex
    
        struct Page @0x9870036b8decf65c {
            # Single page of the document in tab
            
            background @0 :Background;
            
            struct Background @0xc493cb4b6948964c {
                # Defines background style
                
                union {
                    copy @0 :PageCoords;                # Just copy background from specific page (preserving offset)
                    custom :group {                     # Introduce new background
                        type @1 :BackgroundType;
                        
                        resourceNo @2 :UInt32;          # Reference to resource if needed
                        resourceParams @3 :Text;        # Parameters of resource in JSON (ie. region, page)
                    }
                }
            }
                  
            enum BackgroundType @0xdd88bbb73c9d3313 {
                graph @0;
                lined @1;
                ruled @2;
                image @3;                               # QPixmap compatible external image or SVG
                document @4;                            # External document
                custom @5;                              # Custom background – description lays in resource
            }
            
            
            dimensions @1 :U32PointCoords;
            
            objects @2 :List(Object);
            
            struct Object @0xdc4eba3194719864 {
                # Main building block of journal
            
                union {
                    imported :group {                   
                        # There is some object painted on this page with declaration on some other
                        
                        page @0 :PageCoords;                    # Coordinates of page imported from
                        id @1 :UInt32;                          # ID of imported object
                    }
                    contained :group {
                        # Object contained by this specific page
                        
                        id @2 :UInt32;                          # ID of object – unique for page
                        startingPoint @3 :F64Coords;            # Coordinates of startingPoint (can be interpreted 
                                                                # differently for different types of object)
                        transform @4 :Transformation;           # Transformers of object
                        renderPages @5 :List(PageCoords);       # List of pages where object is also rendered
                        layer @6 :Int32;                        # Layer ID
                        
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
                
                struct Transformation @0x81d42e8abe8e9ed9 {
                    # Describes transformations of object all in Float32, because most of objects are transformed 
                    # live (see object's docs)
                    
                    scale @0 :F32Coords;                        # Scaling
                    shear @1 :F32Coords;                        # Shearing
                    rotateOrigin @2 :F32Coords;                 # Origin of rotation
                    rotate @3 :Float32;                         # Rotation value (see QTransform::rotate)
                    polygonal :union {
                        none @4 :Void;                          # If not used what for waste 16B of memory
                        polygonal :group {
                            point1 @5 :Float32;
                            point2 @6 :Float32;
                            point3 @7 :Float32;
                            point4 @8 :Float32;
                        }
                    }
                }
                
                
                struct Stroke @0xfe02439054caf718 {
                    # Basic stroke – free hand
                    # Transformation recalculares values of points
                    
                    color @0 :UInt32;                           # RGBA color of stroke
                    points @1 :List(StrokePoint);               # List of points
                    type @2 :StrokeType;                        # Type of stroke
                    
                    struct StrokePoint @0xe70fe9797511d775 {
                        x @0 :Float32;                          # X coordinate of point
                        y @1 :Float32;                          # Y coordinate of point
                        width @2 :Float32;                      # Width of stroke in current point
                    }
                    
                    struct StrokeType @0x92cb02c4a3d33e41 {
                        union {
                            pen @0 :Void;                       # Normal pen
                            highlighter @1 :Void;               # Highlighter
                            shape @2 :Shape;                    # Custom shape (fill/border are preserved)
                        }
                    }
                }
                
                struct Shape @0xb44ef4a26759a9e1 {
                    # More specific shapes
                    # Transformation recalculares shapes
                    
                    baseColor @0 :UInt32;                       # Base color of shape (it doesn't have to be redefined 
                                                                # in every shape struct – every shape has something in 
                                                                # common with color ) – what exactly it is in details 
                                                                # is defined in docs of struct
                    
                    union {
                        line @1 :Line;
                        polygon @2 :Polygon;
                        
                        # a lot TODO
                    }
                    
                    struct Line @0xf05f5f121eb786c0 {
                        # baseColor is just line color
                    
                        point1 @0 :F32Coords;                   # Coordinates of first point of line
                        point1style @1 :PenCapStyle;            # Style of line first ending
                        point2 @2 :F32Coords;                   # Coordinates of second point of line
                        point2style @3 :PenCapStyle;            # Style of line second ending
                        
                        width @4 :Float32;                      # Width of line
                        
                        style @5 :LineStyle;                    # Style of line
                    }
                    
                    struct Polygon @0xc043a13896ca32fa {
                        # baseColor is line color
                        
                        points @0 :List(F32Coords);             # List of points of 
                        
                        fill @1 :UInt32 = 0;                    # Color of infill (RGBA)
                        fillStyle @2 :FillStyle;
                        fillRule @3 :FillRule;
                        lineStyle @4 :LineStyle;
                    }
                    
                    
                    # Styles
                    
                    struct LineStyle @0xd4492d01514c489e {
                        # Copy of Qt::PenStyle (http://doc.qt.io/qt-5/qt.html#PenStyle-enum)
                        
                        union {
                            noPen @0 :Void;                     # No line at all
                            solidLine @1 :Void;                 # A plain line.
                            dashLine @2 :Void;                  # Dashes separated by a few pixels.
                            dotLine @3 :Void;                   # Dots separated by a few pixels.
                            dashDotLine @4 :Void;               # Alternate dots and dashes.
                            dashDotDotLine @5 :Void;            # One dash, two dots, one dash, two dots.
                            customDashLine @6 :List(Float32);   # A custom pattern – lengths of the dashes and spaces
                                                                #  in the stroke
                        }
                    }
                    
                    struct FillStyle @0xcc914c7f723a4b0f {
                        # Copy of Qt::BrushStyle (http://doc.qt.io/qt-5/qt.html#BrushStyle-enum)
                        
                        union {
                            # Sorry, not indented because of line lenght border
                        noBrush @0 :Void;                 # No brush pattern
                        solidPattern @1 :Void;            # Uniform color
                        dense1Pattern @2 :Void;           # Extremely dense brush pattern
                        dense2Pattern @3 :Void;           # Very dense brush pattern
                        dense3Pattern @4 :Void;           # Somewhat dense brush pattern
                        dense4Pattern @5 :Void;           # Half dense brush pattern
                        dense5Pattern @6 :Void;           # Somewhat sparse brush pattern
                        dense6Pattern @7 :Void;           # Very sparse brush pattern
                        dense7Pattern @8 :Void;           # Extremely sparse brush pattern
                        horPattern @9 :Void;              # Horizontal lines
                        verPattern @10 :Void;             # Vertical lines
                        crossPattern @11 :Void;           # Crossing horizontal and vertical lines
                        bDiagPattern @12 :Void;           # Backward diagonal lines
                        fDiagPattern @13 :Void;           # Forward diagonal lines
                        diagCrossPattern @14 :Void;       # Crossing diagonal lines
                        linearGradientPattern @15 :Void;  # Linear gradient (set using a dedicated QBrush constructor)
                        conicalGradientPattern @17 :Void; # Conical gradient (set using a dedicated QBrush constructor)
                        radialGradientPattern @16 :Void;  # Radial gradient (set using a dedicated QBrush constructor)
                        texturePattern @18 :UInt32;       # Custom pattern (resource id) (in Qt::BrushStyle it's 24)
                        }
                    }
                    
                    enum FillRule @0xd51233aa95c3f217 {
                        # Copy of Qt::FillRule (http://doc.qt.io/qt-5/qt.html#FillRule-enum) – see there for docs
                        
                        oddEvenFill @0;
                        windingFill @1;
                    }
                    
                    enum PenCapStyle @0xc93fd5ec10bb0012 {
                        # Copy of Qt::PenCapStyle (http://doc.qt.io/qt-5/qt.html#PenCapStyle-enum)
                    
                        flatCap @0;     # A square line end that does not cover the end point of the line.
                        squareCap @1;   # A square line end that covers the end point and extends beyond it by 
                                        #  half the line width.
                        roundCap @2;    # Rounded line end.
                    }
                    
                    enum PenJoinStyle @0xda200e4012e6210f {
                        # Copy of Qt::PenJoinStyle (http://doc.qt.io/qt-5/qt.html#PenJoinStyle-enum)
                        
                        miterJoin @0;           # The outer edges of the lines are extended to meet at an angle, and 
                                                #  this area is filled.
                        bevelJoin @1;           # The triangular notch between the two lines is filled.
                        roundJoin @2;           # A circular arc between the two lines is filled.
                        svgMiterJoin @3;        # A miter join corresponding to the definition of a miter join in 
                                                #  the SVG 1.2 Tiny specification.
                    }
                }
                
                struct Text @0x9f55f7f9447a542a {
                    # Text with or without formatting allowed by Qt WebView
                    # All transformations are performed live with `transform`
                    
                    region @0 :F32Rectangle;                    # Region of text field
                    union {
                        text @1 :Text;                          # Just short embedded hardly formatted text
                                                                # TODO: Qt::AlignmentFlag
                        resource @2 :UInt32;                    # Resource ID of rich formatted text
                    }
                }
                
                struct Image @0xb1cfb3dac8b271f1 {
                    # Standard QPixmap compatible image or SVG (depends on resource type)
                    # All transformations are performed live
                    
                    resourceId @0 :UInt32;                      # Reference to resource
                    region @1 :F32RegionEntireSel;
                }
                
                struct Document @0x870173a01af009e8 {
                    # Document page or part of it
                    # All transformations are performed live
                    
                    resourceId @0 :UInt32;                      # Reference to resource
                    page @1 :UInt32;                            # Page number
                    region @2 :F32RegionEntireSel;
                }
                
                struct Math @0xcc991920426d6e11 {
                    # Math stuff (equation, graph and so on)
                    # All transformations are performed live
                    
                    # Huge TODO sign – lot of research, lot of thinking
                }
                
                struct Link @0xc19e6c4a28adcddf {
                    # Visible link to bookmark/resource/URI
                    # All transformations are performed live with
                    
                    region @0 :F32Rectangle;                    # Region where link is shown
                    layout @1 :LinkLayout;                      # Layout of link
                    text :union {
                        default @2 :Void;                       # Use default text extracted from element
                        custom @3 :Text;                        # Custom title of link
                    }
                    
                    union {
                        bookmark @4 :UInt32;                    # Reference to bookmark
                        resource @5 :UInt32;                    # Reference to resource
                        uri :group {
                            uri @6 :Text;                       # URI text
                            icon @7 :UInt32;                    # Reference to icon resource
                        }
                    }
                    
                    enum LinkLayout @0x80393ac0c529f6cf {
                        # Layout of link
                        # U, D, L, R stands respectively for up, down, left, right position of specific item
                        # P stands for "with preview"
                        
                        uIconDText @0;                          # Icon up, text down
                        uIconDTextP @1;                         # Preview up, text down
                        lIconRText @2;                          # Icon left, text right
                        rIconLText @3;                          # Icon right, text left
                        icon @4;                                # Icon only
                        iconP @5;                               # Preview only
                        text @6;                                # Text only
                    }
                }
            }
        }
        
        
        layers @7 :List(Layer);
        
        struct Layer @0xd8d7248255e89bd2 {
            # Layer definition, BasicMetadata is not used, because of no need for timestamps or thumbnail
            
            name @0 :Text;              # Name of layer
            description @1 :Text;       # Description of layer
            
            opacity @2 :UInt8;          # Alpha channel of layer
            
            visible @3 :Bool;           # Is it currently visible?
            locked @4 :Bool;            # Is it currently accessible?
        }
        

        bookmarks @8 :List(Bookmark);
        
        struct Bookmark @0xd91b55583e033c9e {
            # Tab bookmark
            
            id @0 :UInt32;              # Unique ID of bookmark
            metadata @1 :BasicMetadata; # Bookmark metadata (thumbnail of view)
            view @2 :TabView;           # Bookmarked view
        }
        
        
        # Common structs
        
        struct U32PointCoords @0xa3ebcb4df9ad460c {
            # Unsigned point coordinates (or dimensions representation)
        
            x @0 :UInt32;               # X coordinate or width
            y @1 :UInt32;               # Y coordinate or height
        }
        
        struct S32PointCoords @0xcd5d4b7a926774e8 {
            # Signed point coordinates
        
            x @0 :Int32;
            y @1 :Int32;
        }
        
        struct F64Coords @0xa314f46e28416d37 {
            # Float64 coordinates, where speed is not that big issue and conversion may be performed while 
            # initialization
            
            x @0 :Float64;
            y @1 :Float64;
        }
        
        struct F32Coords @0x80403e892b80cb36 {
            # Float32 coordinates – Float64 is not used here because qreal on ARM is float (everywhere else it's double)
            # 64-bit float on ARM may (or may not, who knows) be slower than 32-bit as I read somewhere and while 
            # converting it'd loose precious precision
        
            x @0 :Float32;
            y @1 :Float32;
        }
        
        struct PageCoords @0xbcf789b5a83be597 {
            # Coordinates of page on tab depending on pagination type
            
            union {
                pageNo @0 :UInt32;      # Number of page if `type == page` or number of segment if `type == scroll`
                sCoords :group {        # Signed coordinates of segment for `type == sCartesian`
                    x @1 :Int16;
                    y @2 :Int16;
                }
                uCoords :group {        # Unsigned coordinates of segment for `type == uCartesian`
                    x @3 :UInt16;
                    y @4 :UInt16;
                }
            }
        }
        
        struct F32Rectangle @0x862b0ec13a0fb2ab {
            # Float32 rectangle
            
            corner @0 :F32Coords;       # Top-left corner of selection
            size @1 :F32Coords;         # x = width and y = height
        }
        
        struct F32RegionEntireSel @0x9b0aab365a0ef328 {
            # Union of entire page/image/object or Float32 region cut from it
            
            union {
                entire @0 :Void;                    # Import entire page
                region @1 :F32Rectangle;            # Region to import
            }
        }
    }
    
    resourceIndex @5 :List(UInt32);     # List with resource ids – no need to get all resources to see only one
    resources @6 :List(Resource);       # List of resource objects – index corresponding to pageIndex
    
    struct Resource @0x935c5c9d0bda6fce {
        # Resource used in some place(s) of page
        
        metadata @0 :BasicMetadata;     # Resource metadata (pretty redundant, but why not?)
        prefix @1 :Text;                # Resource prefix path
        
        type @2 :ResourceType;          # Resource type
        enum ResourceType @0xc924d836bfe44d04 {
            text @0;                    # Text data
            pixmap @1;                  # Pixmap supported by QPixmap
            svg @2;                     # SVG file
            document @3;                # Document or part of it (defined in `additional`)
            customBackground @4;        # Custom written background for page
        }
        
        visible @3 :Bool = true;        # If resource should be visible for user in resource explorer
        
        additional @4 :Text;            # Additional type specific variable JSON data
        data @5 :Data;                  # Main resource data
    }
}


struct BasicMetadata @0x947c65e448dd7d50 {
    # Universal basic metadata struct for all kinds of thumbnailable objects
    
    name @0 :Text;                      # Object name
    description @1 :Text;               # Object description
    
    created @2 :UInt64;                 # POSIX time when object was created
    modified @3 :UInt64;                # POSIX time when object was modified
    
    thumbnail @4 :Data;                 # QPixmap compatible thumbnail of object
}

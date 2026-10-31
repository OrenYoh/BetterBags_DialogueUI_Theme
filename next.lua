---@class BetterBags: AceAddon
local BetterBags = LibStub('AceAddon-3.0'):GetAddon("BetterBags")

-- BetterBags Next's themes (BetterBags 0.8 and later). An older BetterBags has no SonataNext: only the classic themes.
---@class SonataNext: AceModule
local sonataNext = BetterBags:GetModule('SonataNext', true)
if sonataNext == nil then return end

-- DialogueUI's Brown and Dark looks on BetterBags Next's panels, drawn with DialogueUI's own art and fonts, read from its
-- folder (not copied), so they are offered only while DialogueUI is loaded (Requires). Built as BetterBags' Parchment
-- Next theme is (paper and ink, no sparkles, shimmer or cloud): the body, the settings window, menus, dialogs and cards
-- on the plain middle of DialogueUI's settings frame (GenericFrame-Tiled-Large.png, away from its torn edge), the tabs on
-- a dimmed strip of it and the selected one on DialogueUI's selected settings tab, titles in DialogueUI's serif. The
-- hidden DialogueUI theme holds the look; Brown and Dark give its art and colors (DialogueUI's ThemeUtil.lua colors, as
-- theme.lua's classic themes use). The paper's color, for the feather and the controls, is the art's average (measured:
-- Brown 0.81, 0.65, 0.46; Dark black at 0.85).
local ART = "Interface\\AddOns\\DialogueUI\\Art\\"
local BROWN = ART .. "Theme_Brown\\"
local DARK = ART .. "Theme_Dark\\"

-- The frame art's plain middle; the tabs' strip of it.
local PAPER = { Texture = "DUIFrame", TexCoords = { 0.25, 0.75, 0.25, 0.75 }, Color = "White", Alpha = 1 }
local TAB_PAPER = { Texture = "DUIFrame", TexCoords = { 0.25, 0.75, 0.3, 0.5 }, Color = "TabDim", Alpha = 1 }
-- Settings-TabButton-Selection.png: the tab, opaque from its second row (128 x 64).
local TAB_SELECTED = { Texture = "DUITab", TexCoords = { 0, 1, 0.0625, 1 }, Color = "White", Alpha = 1 }

-- The sort and Show Blizzard Bags buttons out of the header, at the end of the search bar (as the WoW Classic theme puts
-- them): Show Blizzard Bags last, the sort button left of it, each BetterBags' glyph (inked, as the header's) on
-- DialogueUI's button plate (Settings-CloseButton.png's top left quarter: the plate theme.lua puts behind its close
-- button), drawn as ornaments behind the buttons. The plates are PLATE_W x PLATE_H, PLATE_GAP apart, the first Pad in
-- from the outer side, on the search bar's row (Default's SearchTop 70, SearchHeight 26); each button is Default's
-- header button (22) centered on its plate, its glyph at 0.8 of it. The search bar ends PLATE_GAP before the plates.
-- The bank has a sort button but no Show Blizzard Bags: there only the sort plate shows.
local PAD, SEARCH_TOP, SEARCH_HEIGHT, BUTTON = 18, 70, 26, 22
local PLATE_W, PLATE_H, PLATE_GAP = 30, 26, 4
local PLATE_Y = SEARCH_TOP + (SEARCH_HEIGHT - PLATE_H) / 2
local FIRST_PLATE, SECOND_PLATE = PAD, PAD + PLATE_W + PLATE_GAP
local function pinAt(plateX)
  return { Point = "TOPOUTER", X = -(plateX + (PLATE_W - BUTTON) / 2), Y = -(PLATE_Y + (PLATE_H - BUTTON) / 2) }
end
local function plate(plateX, panels)
  return { Point = "TOPOUTER", Texture = "DUIClose", TexCoords = { 0, 0.5, 0, 0.5 }, Color = "White",
    Width = PLATE_W, Height = PLATE_H, X = plateX, Y = PLATE_Y, Panels = panels }
end

-- The bag as DialogueUI's settings frame, as theme.lua draws the classic bags (GenericFrame-Tiled-Large.png, sliced 80 in
-- from each side, hanging 24 outside the window): BetterBags Next cannot repeat part of a file (its frames and fills
-- stretch what they crop), and DialogueUI has no plain paper to repeat, so its torn corners are drawn as they are (80 x 80,
-- 24 outside), its torn edges stretched along the sides between them, and its middle (texels 80 to 432) stretched over
-- the rest.
local F, M = 80 / 512, 432 / 512
local CORNER, OUT = 80, 24
local FRAME = { Pieces = {
  TopLeftCorner = { Texture = "DUIFrame", TexCoords = { 0, F, 0, F }, Width = CORNER, Height = CORNER, X = -OUT, Y = OUT },
  TopRightCorner = { Texture = "DUIFrame", TexCoords = { M, 1, 0, F }, Width = CORNER, Height = CORNER, X = OUT, Y = OUT },
  BottomLeftCorner = { Texture = "DUIFrame", TexCoords = { 0, F, M, 1 }, Width = CORNER, Height = CORNER, X = -OUT, Y = -OUT },
  BottomRightCorner = { Texture = "DUIFrame", TexCoords = { M, 1, M, 1 }, Width = CORNER, Height = CORNER, X = OUT, Y = -OUT },
  TopEdge = { Texture = "DUIFrame", TexCoords = { F, M, 0, F }, Height = CORNER },
  BottomEdge = { Texture = "DUIFrame", TexCoords = { F, M, M, 1 }, Height = CORNER },
  LeftEdge = { Texture = "DUIFrame", TexCoords = { 0, F, F, M }, Width = CORNER },
  RightEdge = { Texture = "DUIFrame", TexCoords = { M, 1, F, M }, Width = CORNER },
  Center = { Texture = "DUIFrame", TexCoords = { F, M, F, M } },
}, Color = "White", Alpha = 1 }

-- DialogueUI's serif (Fonts.xml), at BetterBags Next's sizes.
local function serif(color)
  return { Object = "DUIFont_Quest_SubHeader", Color = color, Justify = "LEFT" }
end

sonataNext:RegisterTheme({
  Name = "DialogueUI",
  DisplayName = "DialogueUI",
  Description = "What DialogueUI's Brown and Dark looks share.",
  Hidden = true,
  Requires = { "DialogueUI" },

  Textures = {
    DUIFrame = BROWN .. "GenericFrame-Tiled-Large.png",
    DUITab = BROWN .. "Settings-TabButton-Selection.png",
    DUIClose = BROWN .. "Settings-CloseButton.png",
  },

  -- Brown's colors: the art and colors default to Brown's (as theme.lua's), Dark gives its own.
  Palette = {
    Paper = { 0.81, 0.65, 0.46, 0.97 },
    PaperLight = { 0.9, 0.78, 0.62, 1 },
    TabDim = { 0.8, 0.8, 0.8, 1 },
    Ink = { 0.19, 0.17, 0.13, 1 },
    -- Darker than DialogueUI's own (0.50, 0.36, 0.24 and 0.58, 0.47, 0.36: about 1.8 to 1 on the paper, too light to read
    -- small; seen in game): about 4.5 and 3.4 to 1.
    InkSoft = { 0.32, 0.22, 0.13, 1 },
    InkMuted = { 0.40, 0.30, 0.20, 1 },
    Seal = { 0.416, 0.18, 0.165, 1 },
    TabText = { 0.87, 0.86, 0.75, 1 },
    Art = { 0.9, 0.88, 0.85, 1 },
    Body = { 0.81, 0.65, 0.46, 0.97 },
    Tab = { 0.72, 0.57, 0.40, 0.95 },
    TabSelected = { 0.38, 0.22, 0.17, 1 },
    SearchFill = { 0.72, 0.57, 0.40, 1 },
    SearchFillFocus = { 0.88, 0.75, 0.58, 1 },
    Scrim = { 0, 0, 0, 0.35 },
    ControlFill = { 0.85, 0.71, 0.53, 1 },
    ControlHover = { 0.88, 0.75, 0.58, 1 },
    ControlPressed = { 0.74, 0.59, 0.42, 1 },
    Track = { 0.67, 0.52, 0.36, 1 },
    Danger = { 0x9B / 255, 0x20 / 255, 0x20 / 255, 1 },
    Gain = { 19 / 255, 68 / 255, 4 / 255, 1 },
    Capped = { 0.416, 0.18, 0.165, 1 },
    CardFill = { 0.19, 0.17, 0.13, 0.06 },
    CardHover = { 0.19, 0.17, 0.13, 0.1 },
  },

  Fonts = {
    Title = { Object = "DUIFont_Quest_Title_16", Color = "Ink", Justify = "LEFT" },
    Section = serif("Seal"),
    SectionRecent = serif("Seal"),
    SectionFree = serif("InkMuted"),
    Count = { Color = "InkMuted" },
    -- Full ink on the dimmed paper of a tab not chosen (seen in game: too light).
    Tab = serif("Ink"),
    TabSelected = serif("TabText"),
    Footer = { Color = "InkSoft" },
    Empty = { Color = "InkMuted" },
    ConfirmTitle = serif("Ink"),
    ConfirmWarning = { Color = "Danger" },
    ConfirmHint = { Color = "InkSoft" },
    Search = { Color = "InkMuted" },
    SearchText = { Color = "Ink" },
    Price = { Color = "Ink" },
    PriceUnaffordable = { Color = "Danger" },
    VendorName = { Color = "Ink", Shadow = false },
    CurrencyCount = { Color = "Ink" },
    CurrencyNone = { Color = "InkMuted" },
    CurrencyName = { Color = "Ink" },
    CurrencyLoss = { Color = "InkMuted" },
    CurrencyMore = { Color = "InkSoft" },
    ControlText = { Color = "Ink" },
    ControlMuted = { Color = "InkMuted" },
    ControlHelp = { Color = "InkMuted" },
    Button = { Color = "Ink" },
    ButtonPrimary = { Color = "Seal" },
    ButtonDanger = { Color = "Danger" },
    Link = { Color = "InkSoft" },
    LinkHover = { Color = "Seal" },
    MenuItem = { Color = "Ink" },
    MenuItemSelected = { Color = "Seal" },
    DialogTitle = serif("Ink"),
    DialogText = { Color = "InkSoft" },
    TopTab = { Color = "InkMuted" },
    TopTabHover = { Color = "InkSoft" },
    TopTabSelected = { Color = "Ink" },
    SettingsBrand = { Object = "DUIFont_Quest_Title_16", Color = "Ink", Justify = "LEFT" },
    SettingsNavGroup = { Color = "Seal" },
    SettingsNav = { Color = "InkSoft" },
    SettingsNavHover = { Color = "Ink" },
    SettingsNavSelected = { Color = "Ink" },
    SettingsVersion = { Color = "InkMuted" },
    SettingsTitle = { Object = "DUIFont_Quest_Title_16", Color = "Ink", Justify = "LEFT" },
    SettingsDescription = { Color = "InkSoft" },
    SettingsSection = serif("InkMuted"),
    SettingsSectionNote = { Color = "InkMuted" },
    SettingsLabel = { Color = "Ink" },
    SettingsText = { Color = "InkSoft" },
    SettingsLink = { Color = "Seal" },
  },

  Panel = {
    Ornaments = {
      plate(FIRST_PLATE, { "Backpack" }),
      plate(SECOND_PLATE, { "Backpack", "Bank" }),
    },
    -- Nothing under the frame, no fade beside it and no line round it: one torn sheet, as the classic window.
    Fill = { Color = { 0, 0, 0, 0 } },
    Frame = FRAME,
    Feather = false,
    Wash = false,
    Edge = false,
    DropGlow = { Color = "Seal", Alpha = 0.12, BlendMode = "BLEND" },
  },

  Header = {
    TitleGlow = { Color = "Seal", Alpha = 0.12, BlendMode = "BLEND" },
    -- No line of light from the title out of the window (asked).
    Ribbon = false,
    Spark = false,
    Cloud = false,
    Buttons = {
      Color = "Ink", HoverColor = "Seal", ArtColor = "Art", ArtHoverColor = "White",
      Pinned = { bagsButton = pinAt(FIRST_PLATE), sortButton = pinAt(SECOND_PLATE) },
      Icons = { bagsButton = { Scale = 0.8 }, sortButton = { Scale = 0.8 } },
    },
  },

  Search = {
    Inset = { Left = PAD, Right = SECOND_PLATE + PLATE_W + PLATE_GAP },
    Edge = { Color = "Ink", Idle = 0.35, Hover = 0.6, Focus = 0.9 },
    Icon = { Color = "Ink", FocusColor = "Seal" },
  },

  Sections = {
    Line = { Color = "Ink", From = 0.35 },
    Highlight = { Color = "Seal", From = 0.1 },
  },

  -- A strip of the paper, dimmed; the selected tab in DialogueUI's selected settings tab, as theme.lua draws them.
  Tabs = {
    Fill = TAB_PAPER,
    SelectedFill = TAB_SELECTED,
    Glow = { Color = "Seal", BlendMode = "BLEND", Drop = 0.15, Pulse = 0.35 },
    Indicator = false,
    Edge = { Color = "Ink", Alpha = 0.35, Size = 1 },
  },

  Footer = {
    Line = { Color = "Ink", Inner = 0.05, Outer = 0.35 },
  },

  Sparkles = false,

  Chain = { Color = "Seal", BeadColor = "Seal", KnotColor = "Seal" },

  Drag = { Shadow = { Color = "Black", Alpha = 0.25 } },

  Dock = {
    Card = PAPER,
    Glow = { Color = "Seal" },
    Halo = false,
  },

  Currency = {
    Bar = { Track = { Color = "Ink", Alpha = 0.15 }, Fill = { Color = "Ink", Alpha = 0.75 }, Capped = { Color = "Seal" } },
    Flash = false,
    Drop = { BlendMode = "BLEND", Color = "Seal", Alpha = 0.22 },
    Slot = { Color = "Seal" },
    Tracker = { Fill = PAPER, Edge = { Color = "Ink", Alpha = 0.35 } },
  },

  Settings = {
    Fill = PAPER,
    Wash = false,
    Edge = { Color = "Ink", Alpha = 0.5 },
    Sidebar = { Fill = { Color = "Ink", Alpha = 0.06 }, Line = { Color = "Ink", Alpha = 0.25 } },
    Brand = { IconColor = "Seal", Line = { Color = "Seal" } },
    Search = { IconColor = "Ink" },
    Back = { IconColor = "Ink" },
    Nav = {
      Indicator = { Color = "Seal" },
      SelectedFill = { Color = "Ink", Alpha = 0.08 },
      HoverFill = { Color = "Ink", Alpha = 0.04 },
    },
    Header = { Close = { Color = "Ink", HoverColor = "Seal" } },
    Content = {
      Card = { Color = "Ink", Alpha = 0.04 },
      Divider = { Color = "Ink", Alpha = 0.15 },
      Hover = { Color = "Ink", Alpha = 0.05 },
    },
    Footer = { Line = { Color = "Ink", Alpha = 0.25 } },
    Cards = {
      Fill = { Color = "Ink", Alpha = 0.04 }, HoverFill = { Color = "Ink", Alpha = 0.08 },
      Edge = { Color = "Ink", Alpha = 0.25 }, SelectedEdge = { Color = "Seal", Alpha = 0.9 },
    },
    Categories = {
      Indicator = { Color = "Seal" },
      SelectedFill = { Color = "Ink", Alpha = 0.08 },
      HoverFill = { Color = "Ink", Alpha = 0.04 },
    },
    BagCategories = {
      Fill = { Color = "Ink", Alpha = 0.035 },
      HoverFill = { Color = "Ink", Alpha = 0.04 },
    },
  },

  Controls = {
    ScrollBar = {
      Track = { Color = "Ink", Alpha = 0.06 }, Thumb = { Color = "Ink", Alpha = 0.3 },
      ThumbHover = { Color = "Ink", Alpha = 0.55 }, ThumbDrag = { Color = "Seal", Alpha = 0.85 },
    },
    Toggle = {
      On = { Color = "Seal", Alpha = 0.9 }, Edge = { Color = "Ink", Alpha = 0.35 },
      Knob = { Color = "PaperLight" }, KnobOn = { Color = "PaperLight" }, Hover = { Color = "Ink", Alpha = 0.06 },
    },
    Button = {
      Plain = { Edge = { Color = "Ink", Alpha = 0.35 }, HoverEdge = { Color = "Ink", Alpha = 0.6 } },
      Primary = {
        Fill = { Color = "Seal", Alpha = 0.12 }, HoverFill = { Color = "Seal", Alpha = 0.2 },
        PressedFill = { Color = "Seal", Alpha = 0.06 },
        Edge = { Color = "Seal", Alpha = 0.6 }, HoverEdge = { Color = "Seal", Alpha = 1 },
      },
    },
    Input = { Edge = { Color = "Ink" } },
    Slider = { Fill = { Color = "Seal" }, Thumb = { Color = "Ink" }, ThumbHover = { Color = "Seal" } },
    Dropdown = { Edge = { Color = "Ink" }, Chevron = { Color = "Ink" } },
    Menu = {
      Fill = PAPER,
      Edge = { Color = "Ink", Alpha = 0.5 },
      HoverFill = { Color = "Ink", Alpha = 0.08 },
      Check = { Color = "Seal" },
    },
    Swatch = { Edge = { Color = "Ink", Alpha = 0.5 }, HoverEdge = { Color = "Ink", Alpha = 0.9 } },
    TopTabs = { Indicator = { Color = "Seal" }, Line = { Color = "Ink", Alpha = 0.2 } },
    Dialog = {
      Card = PAPER,
      Edge = { Color = "Seal", Alpha = 0.6 },
    },
  },

  Vendor = {
    Highlight = { 0, 0, 0, 0.12 },
    CardFill = "CardFill",
    CardHover = "CardHover",
  },
})

-- Brown: DialogueUI's parchment, dark ink with no shadow (the numbers over item icons keep one of their own).
sonataNext:RegisterTheme({
  Name = "DialogueUIBrown",
  DisplayName = "DialogueUI (Brown)",
  Description = "DialogueUI's parchment look. Requires DialogueUI.",
  Parent = "DialogueUI",
  Requires = { "DialogueUI" },


  FontShadow = { Color = { 0, 0, 0, 0 }, X = 0, Y = 0 },
  Fonts = {
    Stack = { Shadow = { Color = "Black", X = 1, Y = -1 } },
    DragHint = { Shadow = { Color = "Black", X = 1, Y = -1 } },
  },
})

-- Dark: DialogueUI's dark look, light text on near-black paper.
sonataNext:RegisterTheme({
  Name = "DialogueUIDark",
  DisplayName = "DialogueUI (Dark)",
  Description = "DialogueUI's dark look. Requires DialogueUI.",
  Parent = "DialogueUI",
  Requires = { "DialogueUI" },

  Textures = {
    DUIFrame = DARK .. "GenericFrame-Tiled-Large.png",
    DUITab = DARK .. "Settings-TabButton-Selection.png",
    DUIClose = DARK .. "Settings-CloseButton.png",
  },

  Palette = {
    Paper = { 0.02, 0.02, 0.025, 0.9 },
    PaperLight = { 0.8, 0.8, 0.8, 1 },
    TabDim = { 0.7, 0.7, 0.7, 1 },
    Ink = { 0.9, 0.9, 0.9, 1 },
    InkSoft = { 0.7, 0.7, 0.7, 1 },
    InkMuted = { 0.5, 0.5, 0.5, 1 },
    Seal = { 0.796, 0.784, 0.584, 1 },
    TabText = { 1, 0.98, 0.8, 1 },
    Art = { 1, 1, 1, 1 },
    Body = { 0.02, 0.02, 0.025, 0.9 },
    Tab = { 0.1, 0.1, 0.11, 0.95 },
    TabSelected = { 0.48, 0.09, 0.08, 1 },
    SearchFill = { 0.1, 0.1, 0.11, 1 },
    SearchFillFocus = { 0.16, 0.16, 0.17, 1 },
    Scrim = { 0, 0, 0, 0.5 },
    ControlFill = { 0.12, 0.12, 0.13, 1 },
    ControlHover = { 0.17, 0.17, 0.18, 1 },
    ControlPressed = { 0.08, 0.08, 0.09, 1 },
    Track = { 0.22, 0.22, 0.23, 1 },
    Danger = { 1, 0.125, 0.125, 1 },
    Gain = { 0.5, 0.86, 0.5, 1 },
    Capped = { 0.796, 0.784, 0.584, 1 },
    CardFill = { 1, 1, 1, 0.04 },
    CardHover = { 1, 1, 1, 0.08 },
  },
})

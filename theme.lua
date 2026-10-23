---@class BetterBags: AceAddon
local BetterBags = LibStub('AceAddon-3.0'):GetAddon("BetterBags")
assert(BetterBags, "BetterBags_DialogueUI_Theme requires BetterBags")

---@class Sonata: AceModule
local sonata = BetterBags:GetModule('Sonata')

-- DialogueUI's look, drawn with DialogueUI's own art: the art is read from DialogueUI's folder
-- (not copied), so the themes are only available while DialogueUI is loaded. Brown and Dark
-- match DialogueUI's two themes; the hidden DialogueUI theme holds what they share and each
-- one picks its art and text colors through variables.
local ART = "Interface\\AddOns\\DialogueUI\\Art\\"
local BROWN = ART .. "Theme_Brown\\"
local DARK = ART .. "Theme_Dark\\"

---@return boolean
local function isDialogueUILoaded()
  if C_AddOns and C_AddOns.IsAddOnLoaded then
    return C_AddOns.IsAddOnLoaded("DialogueUI") == true
  end
  return IsAddOnLoaded("DialogueUI") == true
end

-- GenericFrame-Tiled-Large.png is DialogueUI's settings frame: torn paper whose edge sits 16
-- texels inside the file, so the art hangs 16 outside the window and the window's edge lies
-- on the paper's. Large windows tile its middle (80 texel margins, as DialogueUI does); the
-- small ones, too short for those margins, stretch it with smaller ones.
local OUTSIDE = { Left = -16, Right = -16, Top = -16, Bottom = -16 }

-- The large frames hang 8 further out, so the paper keeps a margin around the window's
-- contents (the close button would otherwise touch the torn edge).
local PADDED = { Left = -24, Right = -24, Top = -24, Bottom = -24 }

local FRAME = {
  Texture = "$Frame",
  SliceMode = "Tiled",
  SliceMargins = { Left = 80, Right = 80, Top = 80, Bottom = 80 },
  Inset = PADDED,
}

local SMALL_FRAME = {
  Texture = "$Frame",
  SliceMode = "Stretched",
  SliceMargins = { Left = 40, Right = 40, Top = 40, Bottom = 40 },
  Inset = OUTSIDE,
}

-- The plain middle of the frame art, away from its torn edge.
local PAPER = { 0.25, 0.75, 0.25, 0.75 }

local TITLE = {
  Font = { Object = "DUIFont_Quest_Title_16", Color = "$TextColor", Shadow = "$TextShadow" },
  Points = { { Point = "TOPLEFT", X = 46, Y = -12 } },
  Height = 24,
  Justify = "LEFT",
}

-- Settings-CloseButton.png (DialogueUI's settings close button): a plate in its top left
-- quarter, drawn behind the button, and the cross below it.
local CLOSE_SIZE = { Width = 32, Height = 24 }
local CLOSE_POINTS = { { Point = "TOPRIGHT", X = -8, Y = -8 } }

local CLOSE_PLATE = {
  Name = "ClosePlate",
  Texture = "$Close",
  TexCoords = { 0, 0.5, 0, 0.5 },
  SliceMode = "Tiled",
  SliceMargins = { Left = 16, Right = 16, Top = 16, Bottom = 16 },
  Layer = "ARTWORK",
  Points = CLOSE_POINTS,
  Size = CLOSE_SIZE,
}

local CLOSE = {
  Size = 24,
  Points = { { Point = "TOPRIGHT", X = -12, Y = -8 } },
  Normal = {
    Texture = "$Close",
    TexCoords = { 0.0625, 0.1875, 0.625, 0.875 },
    Inset = { Left = 6, Right = 6, Top = 6, Bottom = 6 },
  },
  HoverColor = { 1, 1, 1, 1 },
}

local INSETS = { Left = 12, Right = 12, Top = 40, Bottom = 8 }

---@param noClose? boolean
---@return table
local function framed(noClose)
  return {
    Background = FRAME,
    Insets = INSETS,
    Title = TITLE,
    CloseButton = not noClose and CLOSE or nil,
    Textures = not noClose and { CLOSE_PLATE } or nil,
  }
end

local bag = framed()
bag.Layout = {
  Search = {
    Points = {
      { Point = "TOPLEFT", X = 12, Y = -40 },
      { Point = "BOTTOMRIGHT", RelativePoint = "TOPRIGHT", X = -12, Y = -60 },
    },
    Reserve = 24,
  },
  Footer = { Left = 12, Right = 12, Bottom = 8, Height = 20, Reserve = 26 },
  MenuButton = { Points = { { Point = "TOPLEFT", X = 8, Y = -6 } } },
}

local dialog = framed(true)
dialog.Background = SMALL_FRAME
dialog.Title = { Font = TITLE.Font, Points = { { Point = "TOPLEFT", X = 14, Y = -12 } }, Height = 24, Justify = "LEFT" }

-- Tabs hang 2 pixels into the window; their art starts 2 into the tab, just below it. A strip
-- of the paper, dimmed until selected; the selected tab in Settings-TabButton-Selection.png,
-- DialogueUI's selected settings tab.
local TAB_INSET = { Left = 0, Right = 0, Top = 2, Bottom = 0 }
local TAB = {
  Art = "Flat",
  Height = 26,
  Background = { Texture = "$Frame", TexCoords = PAPER, VertexColor = { 0.8, 0.8, 0.8, 1 }, Inset = TAB_INSET },
  Border = { Color = "$Edge", EdgeSize = 1, Inset = TAB_INSET },
  Hover = { Color = { 1, 1, 1, 0.1 }, Inset = TAB_INSET },
  Selected = {
    Background = {
      Texture = "$TabSelected",
      SliceMode = "Tiled",
      SliceMargins = { Left = 16, Right = 16, Top = 16, Bottom = 16 },
      Inset = TAB_INSET,
    },
  },
  Font = { Object = "DUIFont_Constant_10", Color = "$TextSoftColor", Shadow = "$TextShadow" },
  HighlightFont = { Object = "DUIFont_Constant_10", Color = "$TextColor", Shadow = "$TextShadow" },
  SelectedFont = { Object = "DUIFont_Constant_10", Color = "$TabSelectedTextColor", Shadow = "$TextShadow" },
  TextOffset = { X = 0, Y = -1 },
  SelectedTextOffset = { X = 0, Y = -1 },
}

local NO_SHADOW = { Color = { 0, 0, 0, 0 }, X = 0, Y = 0 }

sonata:RegisterTheme({
  Name = "DialogueUI",
  Hidden = true,
  Available = isDialogueUILoaded,
  -- The art defaults to Brown's; Dark sets its own.
  Variables = {
    Frame = BROWN .. "GenericFrame-Tiled-Large.png",
    Close = BROWN .. "Settings-CloseButton.png",
    TabSelected = BROWN .. "Settings-TabButton-Selection.png",
    Edge = { 0.50, 0.36, 0.24, 1 },
    TabSelectedTextColor = { 0.87, 0.86, 0.75, 1 },
  },
  Windows = {
    Bag = bag,
    Panel = framed(),
    Flat = framed(),
    Dialog = dialog,
    Slots = { Background = SMALL_FRAME, Insets = { Left = 8, Right = 8, Top = 8, Bottom = 8 } },
    Search = { Background = SMALL_FRAME, Insets = { Left = 12, Right = 12, Top = 8, Bottom = 8 } },
  },
  Elements = {
    -- A smaller menu button that fits inside the frame.
    BagButton = { Size = 32, Portrait = { Width = 32, Height = 40 }, Highlight = { Width = 32, Height = 40 } },
    SectionHeader = { Font = { Object = "DUIFont_Quest_SubHeader", Color = "$TextAccentColor", Shadow = "$TextShadow" } },
    Tab = TAB,
  },
})

-- The colors are DialogueUI's own (ThemeUtil.lua): its text colors for each theme, and the
-- reds and greens it uses for warnings and progress.
sonata:RegisterTheme({
  Name = "DialogueUIBrown",
  DisplayName = "DialogueUI (Brown)",
  Description = "DialogueUI's parchment look. Requires DialogueUI.",
  Parent = "DialogueUI",
  Available = isDialogueUILoaded,
  Variables = {
    TextColor = { 0.19, 0.17, 0.13, 1 },
    TextSoftColor = { 0.50, 0.36, 0.24, 1 },
    TextMutedColor = { 0.58, 0.47, 0.36, 1 },
    TextAccentColor = { 0.416, 0.18, 0.165, 1 },
    TextAccentHoverColor = { 0.55, 0.24, 0.2, 1 },
    TextPositiveColor = { 19 / 255, 68 / 255, 4 / 255, 1 },
    TextNegativeColor = { 0x9B / 255, 0x20 / 255, 0x20 / 255, 1 },
    TextShadow = NO_SHADOW,
    TextGlow = { Color = { 1, 0.82, 0, 0.35 }, X = 0, Y = 0 },
  },
})

sonata:RegisterTheme({
  Name = "DialogueUIDark",
  DisplayName = "DialogueUI (Dark)",
  Description = "DialogueUI's dark look. Requires DialogueUI.",
  Parent = "DialogueUI",
  Available = isDialogueUILoaded,
  Variables = {
    Frame = DARK .. "GenericFrame-Tiled-Large.png",
    Close = DARK .. "Settings-CloseButton.png",
    TabSelected = DARK .. "Settings-TabButton-Selection.png",
    Edge = { 0.3, 0.3, 0.3, 1 },
    TextColor = { 0.9, 0.9, 0.9, 1 },
    TextSoftColor = { 0.7, 0.7, 0.7, 1 },
    TextMutedColor = { 0.5, 0.5, 0.5, 1 },
    TextAccentColor = { 0.796, 0.784, 0.584, 1 },
    TextAccentHoverColor = { 1, 0.98, 0.8, 1 },
    TextPositiveColor = { 0.5, 0.86, 0.5, 1 },
    TextNegativeColor = { 1, 0.125, 0.125, 1 },
    TabSelectedTextColor = { 1, 0.98, 0.8, 1 },
  },
})

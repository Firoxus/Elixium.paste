getgenv().Settings = {
    Enabled = false,
    Boxes = false,
    Color = Color3.new(135, 206, 250),
    Width = 3000, -- cool feature
    Filled = false,
    FillColor = Color3.fromRGB(0, 0, 0),
    Transparency = 0.2, -- Filled box transparency
    Healthbar = false, 
    Tracers = false,
    Tcolor = Color3.fromRGB(135, 206, 250), -- Trace color
    Tfrom = 2, -- where tracers locate
    TeamCheck = false,
    TeamColor = false,
    FriendlyColor = Color3.fromRGB(135, 206, 250), -- If teamcolor on set ur friendlies colors
    Lac = false, -- Link all colors
    Lc = Color3.fromRGB(135, 206, 250), -- Linked color
    Names = false, -- Yeah
    NameC = Color3.fromRGB(135, 206, 250), -- Name color
    TextSize = 20, -- Yh
    Offset = 30, -- Bit bugged cos further u are the higher it goes 
    Rainbow = false -- Rainbow esp coloer (not filled / outlines)
}

loadstring(game:HttpGet('https://raw.githubusercontent.com/BlueButOutlined/Esps/main/Library'))()

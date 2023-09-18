getgenv().RecurringPoint = nil
getgenv().Hitbox = nil
getgenv().Keybind = nil
getgenv().AimbotStrengthAmount = nil
getgenv().PredictionAmount = nil
getgenv().Radius = nil
getgenv().UsePrediction = nil
getgenv().AimbotStrength = nil
getgenv().FirstPerson = nil
getgenv().ThirdPerson = nil
getgenv().TeamCheck = nil
getgenv().Enabled = nil


if getgenv().Enabled == true then
    getgenv().Keybind = getgenv().Keybind
else
    getgenv().Keybind = "*"
end
getgenv().CheckIfJumped = true
local Players, Uis, RService, SGui =
    game:GetService "Players",
    game:GetService "UserInputService",
    game:GetService "RunService",
    game:GetService "StarterGui"
local Client, Mouse, Camera, CF, RNew, Vec3, Vec2 =
    Players.LocalPlayer,
    Players.LocalPlayer:GetMouse(),
    workspace.CurrentCamera,
    CFrame.new,
    Ray.new,
    Vector3.new,
    Vector2.new
local Aimlock, MousePressed, CanNotify = true, false, false
local AimlockTarget
local OldPre

getgenv().WTV = function(P)
    return Camera:WTV(P)
end

getgenv().WTS = function(P)
    return Camera.WTS(Camera, P)
end

getgenv().GOG = function(T)
    if T and T:FindFirstChild(getgenv().Hitbox) and Client and Client.Character:FindFirstChild("Head") then
        local RayPos = workspace:FindPartOnRay(RNew(T[getgenv().Hitbox].Position, Client.Character.Head.Position))
        if RayPos then
            return RayPos:IsDescendantOf(T)
        end
    end
end

getgenv().GNT = function()
    local players = {}
    local PLAYER_HOLD = {}
    local DISTANCES = {}
    for i, v in pairs(Players:GetPlayers()) do
        if v ~= Client then
            table.insert(players, v)
        end
    end
    for i, v in pairs(players) do
        if v.Character ~= nil then
            local AIM = v.Character:FindFirstChild("Head")
            if getgenv().TeamCheck == true and v.Team ~= Client.Team then
                local DISTANCE =
                    (v.Character:FindFirstChild("Head").Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
                local RAY =
                    Ray.new(
                    game.Workspace.CurrentCamera.CFrame.p,
                    (Mouse.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * DISTANCE
                )
                local HIT, POS = game.Workspace:FindPartOnRay(RAY, game.Workspace)
                local DIFF = math.floor((POS - AIM.Position).magnitude)
                PLAYER_HOLD[v.Name .. i] = {}
                PLAYER_HOLD[v.Name .. i].dist = DISTANCE
                PLAYER_HOLD[v.Name .. i].plr = v
                PLAYER_HOLD[v.Name .. i].diff = DIFF
                table.insert(DISTANCES, DIFF)
            elseif getgenv().TeamCheck == false and v.Team == Client.Team then
                local DISTANCE =
                    (v.Character:FindFirstChild("Head").Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
                local RAY =
                    Ray.new(
                    game.Workspace.CurrentCamera.CFrame.p,
                    (Mouse.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * DISTANCE
                )
                local HIT, POS = game.Workspace:FindPartOnRay(RAY, game.Workspace)
                local DIFF = math.floor((POS - AIM.Position).magnitude)
                PLAYER_HOLD[v.Name .. i] = {}
                PLAYER_HOLD[v.Name .. i].dist = DISTANCE
                PLAYER_HOLD[v.Name .. i].plr = v
                PLAYER_HOLD[v.Name .. i].diff = DIFF
                table.insert(DISTANCES, DIFF)
            end
        end
    end

    if unpack(DISTANCES) == nil then
        return nil
    end

    local L_DISTANCE = math.floor(math.min(unpack(DISTANCES)))
    if L_DISTANCE > getgenv().Radius then
        return nil
    end

    for i, v in pairs(PLAYER_HOLD) do
        if v.diff == L_DISTANCE then
            return v.plr
        end
    end
    return nil
end

Mouse.KeyDown:Connect(
    function(a)
        if not (Uis:GetFocusedTextBox()) then
            if a == Keybind and AimlockTarget == nil then
                pcall(
                    function()
                        if MousePressed ~= true then
                            MousePressed = true
                        end
                        local Target
                        Target = GNT()
                        if Target ~= nil then
                            AimlockTarget = Target
                        end
                    end
                )
            elseif a == Keybind and AimlockTarget ~= nil then
                if AimlockTarget ~= nil then
                    AimlockTarget = nil
                end
                if MousePressed ~= false then
                    MousePressed = false
                end
            end
        end
    end
)

RService.RenderStepped:Connect(
    function()
        if getgenv().ThirdPerson == true and getgenv().FirstPerson == true then
            if
                (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude > 1 or
                    (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude <= 1
             then
                CanNotify = true
            else
                CanNotify = false
            end
        elseif getgenv().ThirdPerson == true and getgenv().FirstPerson == false then
            if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude > 1 then
                CanNotify = true
            else
                CanNotify = false
            end
        elseif getgenv().ThirdPerson == false and getgenv().FirstPerson == true then
            if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude <= 1 then
                CanNotify = true
            else
                CanNotify = false
            end
        end
        if Aimlock == true and MousePressed == true then
            if AimlockTarget and AimlockTarget.Character and AimlockTarget.Character:FindFirstChild(getgenv().Hitbox) then
                if getgenv().FirstPerson == true then
                    if CanNotify == true then
                        if getgenv().UsePrediction == true then
                            if getgenv().AimbotStrength == true then
                                --// The part we're going to lerp/smoothen \\--
                                local Main =
                                    CF(
                                    Camera.CFrame.p,
                                    AimlockTarget.Character[getgenv().Hitbox].Position +
                                        AimlockTarget.Character[getgenv().Hitbox].Velocity / PredictionAmount
                                )

                                --// Making it work \\--
                                Camera.CFrame =
                                    Camera.CFrame:Lerp(
                                    Main,
                                    getgenv().AimbotStrengthAmount,
                                    Enum.EasingStyle.Elastic,
                                    Enum.EasingDirection.InOut
                                )
                            else
                                Camera.CFrame =
                                    CF(
                                    Camera.CFrame.p,
                                    AimlockTarget.Character[getgenv().Hitbox].Position +
                                        AimlockTarget.Character[getgenv().Hitbox].Velocity / PredictionAmount
                                )
                            end
                        elseif getgenv().UsePrediction == false then
                            if getgenv().AimbotStrength == true then
                                --// The part we're going to lerp/smoothen \\--
                                local Main = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().Hitbox].Position)

                                --// Making it work \\--
                                Camera.CFrame =
                                    Camera.CFrame:Lerp(
                                    Main,
                                    getgenv().AimbotStrengthAmount,
                                    Enum.EasingStyle.Elastic,
                                    Enum.EasingDirection.InOut
                                )
                            else
                                Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().Hitbox].Position)
                            end
                        end
                    end
                end
            end
        end
        if CheckIfJumped == true then
            if AimlockTarget.Character.HuDDDDDDDDDDWmanoid.FloorMaterial == Enum.Material.Air then
                getgenv().Hitbox = "UpperTorso"
            else
                getgenv().Hitbox = getgenv().RecurringPoint
            end
        end
    end
)

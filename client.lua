local jumpCount = 0
local hasJumpedOnce = false
local jumpStartTime = 0

CreateThread(function()
    while true do
        Wait(Config.DoubleJump.waitTime)

        if IsPedJumping(cache.ped) then
            if not hasJumpedOnce then
                jumpCount = jumpCount + 1
                hasJumpedOnce = true
                jumpStartTime = GetGameTimer()

                if jumpCount == 2 then
                    SetPedToRagdoll(cache.ped, Config.DoubleJump.ragdollDuration, Config.DoubleJump.ragdollDuration, 0, false, false, false)
                    jumpCount = 0
                end
            end
        else
            hasJumpedOnce = false
        end

        if not IsPedJumping(cache.ped) and not IsPedFalling(cache.ped) then
            hasJumpedOnce = false
        end

        if jumpCount == 1 and (GetGameTimer() - jumpStartTime) > Config.DoubleJump.jumpTimeout then
            jumpCount = 0
            hasJumpedOnce = false
        end
    end
end)

lib.onCache('vehicle', function(value)
    if value then
        jumpCount = 0 
        hasJumpedOnce = false
    end
end)
--[[
 ____   ____                         ________ ___.    _____                           __                
 \   \ /   /____   ____   _______  __\_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
  \   Y   // __ \ /    \ /  _ \  \/  //   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
   \     /\  ___/|   |  (  <_> >    </    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
    \___/  \___  >___|  /\____/__/\_ \_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
               \/     \/            \/       \/    \/                \/     \/     \/                  
                |_VenoxObfuscator (100% realll)
                
    Venox Hub: discord.gg/venoxhub / @venox.w
]]--
game.StarterGui:SetCore("SendNotification", {
    Title = "Update Notice";
    Text = "This version is now obsolete. Loading the normal Venoxware version...";
    Duration = 5;
})
wait(2)
loadstring(game:HttpGet('https://raw.githubusercontent.com/venoxhh/universalscripts/main/rivals/venoxware'))()

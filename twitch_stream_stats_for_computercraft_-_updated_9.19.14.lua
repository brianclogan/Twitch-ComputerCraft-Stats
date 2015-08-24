streamid = "Bacon_Donut"
SleepTime = 60
os.loadAPI("json")
local m = peripheral.wrap("right")
m.setCursorPos(1,1)
function getFollowers()
        str = http.get("https://api.twitch.tv/kraken/channels/" .. streamid .. "/follows").readAll()
        obj = json.decode(str)
        follows = json.encodePretty(obj._total)
        m.setCursorPos(1,3)    
        m.write("Twitch Followers: ")
        m.write(follows)
        return follows
end
function getViewerCount()
        lstr = http.get("https://api.twitch.tv/kraken/streams/" .. streamid).readAll()
        lobj = json.decode(lstr)
        live = json.encodePretty(lobj.stream.viewers)
        m.setCursorPos(1,1)
        if live == "\"0\"" then
                m.write(streamid)
                m.setCursorPos(1,4)
                m.write("Live Viewers: Offline")
        else
                m.setBackgroundColor(colors.yellow)
                m.clear()
                m.write(streamid)
                m.setCursorPos(1,4)
                m.write("Live Viewers: ")
                m.write(live)          
        end
        return live
end
while true do
        m.setCursorPos(1,1)
        m.setBackgroundColor(colors.white)
        m.setTextColor(colors.blue)
        m.setTextScale(1)
        m.clear()
        m.write(streamid)
        m.setCursorPos(1,2)
        local status, live = pcall(function () getViewerCount() end)
        if status then
                -- do nothing
        else
                m.write("Not Currently Streaming")
        end
        local status, followsCount = pcall(function () getFollowers() end)
        m.setCursorPos(1,3)    
        if status then         
                -- do nothing
        else           
                m.write("Twitch Follows: Loading...")
        end
        sleep(SleepTime)
end
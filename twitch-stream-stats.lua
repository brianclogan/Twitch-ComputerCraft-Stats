----- EDITABLE VARIABLES. Only edit the below.
streamid = "darkgoldblade01" --- the twitch.tv username
SleepTime = 60 --- how often do you want to refresh in seconds? (default - 60)
direction = "right" --- this is the direction the monitors are
--- This next area is for deciding what you want on each line. The options are: followerCount, viewerCount, and currentGame
line1 = "viewerCount" -- default viewerCount
line2 = "followerCount" -- default followerCount
line3 = "currentGame" -- default currentGame

----- DO NOT EDIT BELOW THIS LINE! ----


os.loadAPI("json")
local m = peripheral.wrap(direction)
------ All the functions -------
--- before the functions, the api grab ---
str = http.get("https://api.twitch.tv/kraken/streams/" .. streamid).readAll()
obj = json.decode(str)
-- Function to get follower counts
function getFollowers(line)
        followers = json.encodePretty(obj.stream.channel.followers)
        m.setCursorPos(1,line)
        m.write("Twitch Followers: ")
        m.write(followers)
end
-- function to get current viewer count
function getViewerCount(line)
        viewers = json.encodePretty(obj.stream.viewers)
        m.setCursorPos(1,line)
        m.write("Current Viewers: ")
        m.write(viewers)
end
-- function to get current game
function getCurrentGame(line)
        game = obj.stream.game
        m.setCursorPos(1,line)
        m.write("Currently Playing: ")
        m.write(game)
end

--Set the current position to 1,1
while true do
        m.setCursorPos(1,1)
        m.setBackgroundColor(colors.white)
        m.setTextColor(colors.blue)
        m.setTextScale(1)
        m.clear()
        m.write(streamid)
        live = obj.stream
        if live == null then
            --- they are offline, just show that.
            m.setCursorPos(1,3)
            m.write("Currently Offline")
        else 
            --- they are online! WOO! Change the background to yellow, clear the board, and reset!
            m.setBackgroundColor(colors.yellow)
            m.clear()
            m.setCursorPos(1,1)
            m.write(streamid)
            --- now we can continue on.
            m.setCursorPos(1,3)
            if line1 == "followerCount" then 
                getFollowers(3)
            elseif line1 == "viewerCount" then
                getViewerCount(3)
            elseif line1 == "currentGame" then
                getCurrentGame(3)
            else
                getViewerCount(3)    
            end
            m.setCursorPos(1,4)
            if line2 == "followerCount" then 
                getFollowers(4)
            elseif line2 == "viewerCount" then
                getViewerCount(4)
            elseif line2 == "currentGame" then
                getCurrentGame(4)
            else
                getFollowers(4)    
            end
            m.setCursorPos(1,5)
            if line3 == "followerCount" then 
                getFollowers(5)
            elseif line3 == "viewerCount" then
                getViewerCount(5)
            elseif line3 == "currentGame" then
                getCurrentGame(5)
            else
                getCurrentGame(5)    
            end
        end
        sleep(SleepTime)
end

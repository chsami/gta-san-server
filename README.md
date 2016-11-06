# gta-san-server
Download for the client/server : https://mtasa.com/


23 June 2014
-Finished police job
-Added gangdriveby script to the server
-Fixed some vehicle bugs
-Added ammunation store + interface + weapon buying
-Added health saving

--DONE FOR TODAY--


24 June 2014

-Added treadmill gym
-added spinning_bike gym
-added dumbells gym

--DONE FOR TODAY--

25 June 2014

-Fixed some gym bugs
-Added boxing gym
-Added permits saving + interface
-Fixed some resolution interface
-Added realtime timer
--Added gym blip
--Added onElementchange security server + client side
-Added stamina up and muscles up interface in the gym

26 June 2014

-Farming bug fixed with harvesting coca plants
-Achievement system added + interface
-Custom blips added
-Fixed hacking marker
-Added 2 new cars
--Added achievement for 1000 and 5000 for stamina and muscles

--Done for today--

27 June 2014

-Created custom interface system
-/semote - > to stop emote
-/dance and /smoke
-Help interface at farmer place and hospital
-Fixed some resolution interfaces
-Cleaned up messy code 
-Added portals at hospital to airport and farm with 3d text

28 June 2014

-Fixed hacking interface
-Created new notification screen interface
-Fixed login screen edit boxes
-Fixed some bugs with the new interface system
-Added 2 new location for pilot job
-Fixed some code about the points given in a certain skill
-Added death image when player dies + slow motion
-Added wanted level saving for players
-Fixed some police job bugs and jail timer interface
-Fixed the book interface problem implementing it into the meta.xml
-Aded hospital icon at the correct position and police icon at the correct place
-Tested multilogin, everything went fine
-Fixed achievement system interfering with slideshow

29 June 2014

-Added minigame for fighting permits
-Fighting permit exam can be done for 5000$, currently 3 styles
-On death now results in losing your weapons
-Created car permit exam

30 June 2014

-Fixed tons of interface issues
-Added a client side loggin detection
-Created personal vehicle system
-Created vehicle hide/show/repair/locate
-Players can now buy their own personal vehicle
-Vehicle display when purchasing your vehicle
-Dynamic updating on vehicle look (broken, very broken , neat ) ...
-Added some texts on markers
-Added blip for car purchasing spot
-Added utility class for function we use occasionally like : round, isLoggedIn, getLoginName...
-Disabled logout command through acl rights
-Fixed book.png error message

--DONE FOR TODAY--

1 July 2014

-Players can sell vehicles
-Players can delete vehicles from the sales list
-Players can lock and unlock their vehicles
-Players can only enter a vehicle that they own
-Players can buy vehicles from other players
-Players get a notification when they login if their vehicle is sold
-Players can choose their price to sell the vehicle

2 July 2014

-Added a marker near hospital where people can buy cars from other players
-Added a tutorial for players that login explaning some basic server features
-added a /support command
-Show vehicle button on the vehicle market interface now works
-Fixed some issues with the vehicle rotation
-Added a blip icon at the vehicle exam centrum

4 July 2014
-Added some new utility functions for easier scripting
-Players can now add a friend/message a friend/delete a friend
-Player can buy their phones in the general store, samsung or iphone currently, phones are used to contact friends
-Players can now enter a general store in Los santos
-General store blip has been added to the minimap

5 July 2014
-Players personal vehicles now get their fuel depleted depending on how fast they drive and if the engine is off or on
-New vehicle attributes interface added eg: Speed, fuel, damage
-Vehicle fuel saves correctly even if the server crashes
-Players can now refuel their vehicle at a tankstation which is marked by a custom blip (tankstation icon)
-A custom interface made to refuel vehicle correctly. Gas price is currently set to $3
-Players can now see if their friends are offline or online and if their online it will display the area where they are on the friendslist

6 July 2014
-Tested server with multiple accounts
-Players can no longer enter locked vehicles or vehicles that contain a passanger that is the owner of the vehicle
-Players can join in a vehicle by pressing "g"
-Players can now tune their vehicle
-Players can now fix their vehicle at the garage for a cheaper price
-Players now get removed of the map when they log out
-Destroyed vehicles no longer wander around on the map

8 July 2014
-2 Speedcamera's added on the world map (current fine is 5000$ (need to lower it))
-Rewrote job progress interface
-Rewrote all the 4 jobs now works like this : PlayerLevel - PlayerExperience - PlayerFunctionName (in the job)
-Rewrote pilot job with the new system

9 July 2014

-Players now need to go to a job location to apply for a certain job
-Players with a wanted level can't apply for a police job
-Players can now travl around the world map using the taxi system
-Jobs now use the level up system. Explanation : YOu need 101 exp to gain a level in your job and exp is gained by doing your job

10 July 2014

-Players that hide their HUD in the settings mode now don't see the custom blips aswell
-Taxi system improved and perfected
-Players that get over 4 vehicle penalty's will lose their vehicle permit
-Players job progress interface has been made a lil bit nicer to fit in the screen
-Players can now choose their chat options eg : /ooc will trigger out of character chat and /ic will trigger ingame character and /me does player actions
-Fixed some database issue's with fresh players logging into the server for the first timer aswell for vehicles
-New players now get the option to choose between 4 jobs and a bunch of skins with a nice interface
-Players that are now disconnected or got kicked and log back in the sky can use parachute, skydiving works perfectly aswell

11 July 2014

-Players can no longer glitch interfaces by pressing binded keys
-Fixed some bugs with the tuning vehicle
-All jobs now have their own skin
-Players can change their skin depending on their jobs
-Criminal job completely changed eg : Efficient code, no longer client side actions, even more realistic than before
-A small glitch with speeding tickets fixed
-Fixed small bug with personal vehicles not respawning correctly after tuning
-Added a 3 minute cooldown for robbing stores

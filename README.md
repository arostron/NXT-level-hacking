# NXT-level-hacking
Lego Mindstorm Project for #HackED2020 hackathon 

## The Inspiration
A couple summers ago I worked for an organization called DiscoverE, which is the UofA's engineering outreach program. In the summers DiscoverE host's summer camps, many of which I went to when I was a kid. One of the summer camps I went to was a robotics camp, where we programmed lego NXT robots. I contacted DiscoverE and borrowed 4 of their original NXT bricks (ones I likely programmed in elementary school). There is a box of about 40 NXT bricks just sitting around the DiscoverE office. 

I'm looking to bring life back to these old, but still functional, NXT bricks!

## The plan
- Figure out how to program a NXT brick using the Not Exactly C language (NXC)
- make some kind of demo...?

## dont forget how to docker
docker image build -t nxcdev .
docker run -itd --rm --name devenv nxcdev 
docker exec -it devenv /bin/sh
#Divivde and conquer plan
Goal: find where something is, and yell at it

one robot is sent north (the master)
other robot is sent south (the slave)

when one robot finds something, it signals the other
when the found signal is sent, the other robot changes direction to meet up with the other robot

         master         slave
        --------          |    
          |               |    
          |               |    
          |               |    
   send   | ----------->  |    
    5s    |  ready to go? | if ready
          |               | send every 1s
          |  <----------  |    
          |   yes ready   |    
          |               |    
          |               |    
          |   dist to m   |    
   finds  | ------------> |    
          |               |    
      stop|and            |drive back to 
      wait|               |other robot
          |               |    
          | <-----------  |    
          |  send met up  |    
          |  signal       |    
      play|               |play
     sound|               |sound 
          |               |    
       end|            end|    
          |               |   






 

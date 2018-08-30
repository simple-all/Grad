classdef Linear < handle
    %LINEAR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        length = 30; % in
        maxSpeed = 5; % in/s
        lastTime = 0; % s
        position = 0; % in
        speed = 0; % in/s
        speedMod = 1; % "unseen" speed multiplication
        resolution = 0.25; % in
        dir = 1;
    end
    
    methods
        
        function runAtTime(obj, time)
            tstep = time - obj.lastTime;
            obj.lastTime = time;
            obj.position = obj.position + obj.speed * obj.speedMod * tstep * obj.dir;
            if obj.position > obj.length
                obj.position = obj.length;
            elseif obj.position < 0
                obj.position = 0;
            end
        end
        
        function pos = getReadout(obj)
            pos = round(obj.position / obj.resolution) * obj.resolution;
        end
        
        function setPWM(obj, pwm)
            obj.speed = obj.maxSpeed * pwm;
            if obj.speed > obj.maxSpeed
                obj.speed = obj.maxSpeed;
            end
            if obj.speed < 0
                obj.speed = 0;
            end
        end
        
    end
    
end


classdef GenericEventManager < publicsim.tests.UniversalTester
    %GENERICEVENTMANAGER Manages event detectors
    % 
    
    properties
        eventList;
    end
    
    methods
        function obj = GenericEventManager
            % Constructor
            obj.eventList = publicsim.funcs.eventManager.Event.empty();
        end
        
        function addEvent(obj, eventName, runFunctionHandle, varargin)
            % Adds an event to the event list
            np = publicsim.util.inputParser();
            np.addParameter('initFunction', []);
            np.parse(varargin{:});
            
            newEvent = publicsim.funcs.eventManager.Event(eventName);
            newEvent.setRunFunction(runFunctionHandle);
            if ~isempty(np.Results.initFunction)
                newEvent.setInitFunction(np.Results.initFunction);
            end
            obj.eventList(end + 1) = newEvent;
        end
        
        function subscribeToEvent(obj, eventName, triggerHandle, varargin)
            % Add a subscriber to the named event
            names = obj.getEventNames();
            index = find(strcmp(names, eventName));
            assert(numel(index) == 1, sprintf('Event ''%s'' is not registered in this event manager!', eventName));
            obj.eventList(index).addSubscriber(triggerHandle, varargin{:});
        end
        
        function runAtTime(obj, time)
            % Runs all events at the current time
            for i = 1:numel(obj.eventList)
                obj.eventList(i).runAtTime(time);
            end
        end
        
        function initEvents(obj)
            for i = 1:numel(obj.eventList)
                obj.eventList(i).init();
            end
        end
    end
    
    methods (Access = private)
        function names = getEventNames(obj)
            % Gets the names of all events in the event list
            names = {obj.eventList(:).name};
        end
    end
    
    
    % Test methods
    
    methods (Static, Access = {?publicsim.tests.UniversalTester})
        function tests = test()
            tests{1} = 'publicsim.funcs.eventManager.GenericEventManager.test_GenericEventManager';
        end
    end
    
    methods (Static)
        function test_GenericEventManager()
            pause(1);
            gem = publicsim.funcs.eventManager.GenericEventManager();
            gem.addEvent('test_basic', @publicsim.funcs.eventManager.GenericEventManager.test_runner1);
            gem.subscribeToEvent('test_basic', @publicsim.funcs.eventManager.GenericEventManager.test_trigger1);
            disp('Starting GenericEventManager test...');
            for i = 1:10
                gem.runAtTime(i);
            end
            pause(1); % Delay here to give the command window a chance to catch up
            
            % Get command window output to check if the right messages
            % displayed
            % Big thanks to Hugh Nolan and Jan Simon: https://www.mathworks.com/matlabcentral/fileexchange/31438-command-window-text
            [cmdWin]=com.mathworks.mde.cmdwin.CmdWin.getInstance;
            cmdWin_comps=get(cmdWin,'Components');
            subcomps=get(cmdWin_comps(1),'Components');
            text_container=get(subcomps(1),'Components');
            output_string=get(text_container(1),'text');
            
            output_cell=textscan(output_string,'%s','Delimiter','\r\n','MultipleDelimsAsOne',1);
            output_cell=output_cell{1};
            
            assert(strcmp(output_cell{end - 1}, 'Starting GenericEventManager test...'), 'Unexpected test starting string!');
            assert(strcmp(output_cell{end}, 'Test Trigger 1!'), 'Basic event test failed!');
        end
        
        function bool = test_runner1(time, ~)
            if (time == 5)
                bool = 1;
            else
                bool = 0;
            end
        end
        
        function test_trigger1()
            disp('Test Trigger 1!');
        end
    end
    
end


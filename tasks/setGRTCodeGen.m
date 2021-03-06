function setGRTCodeGen()
% SETGRTCODEGENERATIONSETTINGS This function sets the appropriate settings
% for code generation for the controller. This is a private function, not
% meant to be used directly.

% Copyright 2017 The MathWorks, Inc.

% Check if the flight control system model and its children are open
model = {'flightControlSystem','flightController','stateEstimator'};

for k = 1:length(model)
    isFCSLoaded = bdIsLoaded(model{k});
    if ~isFCSLoaded
        load_system(model{k});
    end
    
    % Set the hardware target toolchain
    set_param(model{k},...
        'HardwareBoard','None',...
        'SystemTargetFile','grt.tlc');

    
    % Only save if model is not opened, just in case there are unsaved changes
    if ~isFCSLoaded
        save_system(model{k});
        bdclose(model{k});
    end
end

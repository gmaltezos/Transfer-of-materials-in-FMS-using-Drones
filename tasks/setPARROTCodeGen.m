function setPARROTCodeGen()
% SETPARROTCODEGEN This function sets the appropriate settings
% for code generation for the controller. This is a private function, not
% meant to be used directly.

% Copyright 2017-2018 The MathWorks, Inc.

% Check that the support package is installed
if isParrotSupportPkgInstalled
    % Check if the flight control system model and its children are open
    modelList = {'flightControlSystem','flightController','stateEstimator'};
    
    for k = 1:length(modelList)
        isFCSLoaded = bdIsLoaded(modelList{k});
        if ~isFCSLoaded
            load_system(modelList{k});
        end

        % Set the hardware target toolchain
        switch evalin('base','model')
            case 'Mambo'
                set_param(modelList{k},'HardwareBoard','PARROT Mambo',...
                        'MatFileLogging','on');
            case 'RollingSpider'
                set_param(modelList{k},'HardwareBoard','PARROT Rolling Spider',...
                        'MatFileLogging','on');
        end

        % Only save if model is not opened, just in case there are unsaved changes
        if ~isFCSLoaded
            save_system(modelList{k});
            bdclose(modelList{k});
        end
    end
else
    warning(message('aeroblks:asbquadcopter:supportPkgNotInstalled'));
end

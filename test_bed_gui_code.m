classdef onitafinal < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        GreenLamp                       matlab.ui.control.Lamp
        YellowLamp                      matlab.ui.control.Lamp
        RedLamp                         matlab.ui.control.Lamp
        HeadlightStatusEditFieldLabel   matlab.ui.control.Label
        HeadlightStatusEditField        matlab.ui.control.EditField
        MotorSpeedEditFieldLabel        matlab.ui.control.Label
        MotorSpeedEditField             matlab.ui.control.NumericEditField
        DistancetoObjectmetersEditFieldLabel  matlab.ui.control.Label
        DistancetoObjectEditField       matlab.ui.control.NumericEditField
        LowCoolantAlarmEditFieldLabel   matlab.ui.control.Label
        LowCoolantAlarmEditField        matlab.ui.control.EditField
        TemperatureCEditFieldLabel      matlab.ui.control.Label
        TemperatureEditField            matlab.ui.control.NumericEditField
        TemperatureAlarmEditFieldLabel  matlab.ui.control.Label
        TemperatureAlarmEditField       matlab.ui.control.EditField
        startButton                     matlab.ui.control.Button
        headlight1                      matlab.ui.control.Lamp
        headlight2                      matlab.ui.control.Lamp
    end

    properties (Access = private)
        arduino;
        offcolor = [0.80,0.80,0.80];
        off = [0.67,0.73,0.73];
        dim = [0.2,0.6,0.6];
        bright = [0,1,1];
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: startButton
        function startButtonPushed(app, event)
            app.startButton.Visible = true;
            arduino = serialport("/dev/cu.usbmodem142101",9600);
            pause(1)
            while 1
                valuesstring = readline(arduino);
                valuesstring = strip(valuesstring);
                valuesstring = split(valuesstring);
                distance =  double(valuesstring(1));
                coolevel =  double(valuesstring(3));
                temperature =  double(valuesstring(4));
                speed = double(valuesstring(5));
                headlight = double(valuesstring(6));
                app.TemperatureEditField.Value = temperature;
                if (coolevel < 30)||(temperature >= 30) 
                    app.DistancetoObjectEditField.Value = 0;
                    app.MotorSpeedEditField.Value = 0;
                    app.RedLamp.Color = app.offcolor;
                    app.GreenLamp.Color = app.offcolor;
                    app.YellowLamp.Color = app.offcolor;
                    if temperature >= 30
                        app.TemperatureAlarmEditField.Value = "ON"
                    end
                    if coolevel < 30
                        app.LowCoolantAlarmEditField.Value = "ON"
                        app.TemperatureAlarmEditField.Value = "OFF";
                    end
                else
                    app.DistancetoObjectEditField.Value = distance;
                    app.MotorSpeedEditField.Value = speed;
                    app.LowCoolantAlarmEditField.Value = "OFF"
                    app.TemperatureAlarmEditField.Value = "OFF";
                    if (distance <= 15) 
                        app.RedLamp.Color = 'r';
                        app.GreenLamp.Color = 'g';
                        app.YellowLamp.Color = 'y';                
                    elseif ((distance > 15)&&(distance <= 25)) 
                        app.RedLamp.Color = app.offcolor;
                        app.GreenLamp.Color = 'g';
                        app.YellowLamp.Color = 'y';                
                    elseif ((distance > 25)&&(distance < 32 ))
                        app.RedLamp.Color = app.offcolor;
                        app.GreenLamp.Color = 'g';
                        app.YellowLamp.Color = app.offcolor;                
                    else 
                        app.RedLamp.Color = app.offcolor;
                        app.GreenLamp.Color = app.offcolor;
                        app.YellowLamp.Color = app.offcolor;                
                    end 
                    if (headlight == 0) || (headlight == 1)
                        app.headlight1.Color = app.off;
                        app.headlight2.Color = app.off;
                        app.HeadlightStatusEditField.Value = "OFF";
                    elseif headlight == 2
                        app.headlight1.Color = app.dim;
                        app.headlight2.Color = app.dim;
                        app.HeadlightStatusEditField.Value = "DIM";
                    else
                        app.headlight1.Color = app.bright;
                        app.headlight2.Color = app.bright;
                        app.HeadlightStatusEditField.Value = "BRIGHT";
                    end
                end   
            end
            delete(arduino);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 902 809];
            app.UIFigure.Name = 'MATLAB App';

            % Create GreenLamp
            app.GreenLamp = uilamp(app.UIFigure);
            app.GreenLamp.Position = [144 451 151 151];
            app.GreenLamp.Color = [0.8 0.8 0.8];

            % Create YellowLamp
            app.YellowLamp = uilamp(app.UIFigure);
            app.YellowLamp.Position = [340 451 151 151];
            app.YellowLamp.Color = [0.8 0.8 0.8];

            % Create RedLamp
            app.RedLamp = uilamp(app.UIFigure);
            app.RedLamp.Position = [537 451 151 151];
            app.RedLamp.Color = [0.8 0.8 0.8];

            % Create HeadlightStatusEditFieldLabel
            app.HeadlightStatusEditFieldLabel = uilabel(app.UIFigure);
            app.HeadlightStatusEditFieldLabel.HorizontalAlignment = 'right';
            app.HeadlightStatusEditFieldLabel.FontName = 'American Typewriter';
            app.HeadlightStatusEditFieldLabel.FontSize = 16;
            app.HeadlightStatusEditFieldLabel.Position = [216 283 134 22];
            app.HeadlightStatusEditFieldLabel.Text = 'Headlight Status';

            % Create HeadlightStatusEditField
            app.HeadlightStatusEditField = uieditfield(app.UIFigure, 'text');
            app.HeadlightStatusEditField.HorizontalAlignment = 'center';
            app.HeadlightStatusEditField.FontName = 'American Typewriter';
            app.HeadlightStatusEditField.FontSize = 16;
            app.HeadlightStatusEditField.Position = [230 233 107 38];

            % Create MotorSpeedEditFieldLabel
            app.MotorSpeedEditFieldLabel = uilabel(app.UIFigure);
            app.MotorSpeedEditFieldLabel.HorizontalAlignment = 'right';
            app.MotorSpeedEditFieldLabel.FontName = 'American Typewriter';
            app.MotorSpeedEditFieldLabel.FontSize = 16;
            app.MotorSpeedEditFieldLabel.Position = [494 382 134 22];
            app.MotorSpeedEditFieldLabel.Text = 'Motor Speed (%)';

            % Create MotorSpeedEditField
            app.MotorSpeedEditField = uieditfield(app.UIFigure, 'numeric');
            app.MotorSpeedEditField.HorizontalAlignment = 'center';
            app.MotorSpeedEditField.FontName = 'American Typewriter';
            app.MotorSpeedEditField.FontSize = 16;
            app.MotorSpeedEditField.Position = [502 334 118 38];

            % Create DistancetoObjectmetersEditFieldLabel
            app.DistancetoObjectmetersEditFieldLabel = uilabel(app.UIFigure);
            app.DistancetoObjectmetersEditFieldLabel.HorizontalAlignment = 'right';
            app.DistancetoObjectmetersEditFieldLabel.FontName = 'American Typewriter';
            app.DistancetoObjectmetersEditFieldLabel.FontSize = 16;
            app.DistancetoObjectmetersEditFieldLabel.Position = [181 382 216 22];
            app.DistancetoObjectmetersEditFieldLabel.Text = 'Distance to Object (meters)';

            % Create DistancetoObjectEditField
            app.DistancetoObjectEditField = uieditfield(app.UIFigure, 'numeric');
            app.DistancetoObjectEditField.HorizontalAlignment = 'center';
            app.DistancetoObjectEditField.FontName = 'American Typewriter';
            app.DistancetoObjectEditField.FontSize = 16;
            app.DistancetoObjectEditField.Position = [235 334 107 38];

            % Create LowCoolantAlarmEditFieldLabel
            app.LowCoolantAlarmEditFieldLabel = uilabel(app.UIFigure);
            app.LowCoolantAlarmEditFieldLabel.HorizontalAlignment = 'right';
            app.LowCoolantAlarmEditFieldLabel.FontName = 'American Typewriter';
            app.LowCoolantAlarmEditFieldLabel.FontSize = 16;
            app.LowCoolantAlarmEditFieldLabel.Position = [481 283 152 22];
            app.LowCoolantAlarmEditFieldLabel.Text = 'Low Coolant Alarm';

            % Create LowCoolantAlarmEditField
            app.LowCoolantAlarmEditField = uieditfield(app.UIFigure, 'text');
            app.LowCoolantAlarmEditField.HorizontalAlignment = 'center';
            app.LowCoolantAlarmEditField.FontName = 'American Typewriter';
            app.LowCoolantAlarmEditField.FontSize = 16;
            app.LowCoolantAlarmEditField.Position = [502 233 118 38];

            % Create TemperatureCEditFieldLabel
            app.TemperatureCEditFieldLabel = uilabel(app.UIFigure);
            app.TemperatureCEditFieldLabel.HorizontalAlignment = 'right';
            app.TemperatureCEditFieldLabel.FontName = 'American Typewriter';
            app.TemperatureCEditFieldLabel.FontSize = 16;
            app.TemperatureCEditFieldLabel.Position = [212 186 141 22];
            app.TemperatureCEditFieldLabel.Text = 'Temperature (ºC)';

            % Create TemperatureEditField
            app.TemperatureEditField = uieditfield(app.UIFigure, 'numeric');
            app.TemperatureEditField.HorizontalAlignment = 'center';
            app.TemperatureEditField.FontName = 'American Typewriter';
            app.TemperatureEditField.FontSize = 16;
            app.TemperatureEditField.Position = [230 136 105 38];

            % Create TemperatureAlarmEditFieldLabel
            app.TemperatureAlarmEditFieldLabel = uilabel(app.UIFigure);
            app.TemperatureAlarmEditFieldLabel.HorizontalAlignment = 'right';
            app.TemperatureAlarmEditFieldLabel.FontName = 'American Typewriter';
            app.TemperatureAlarmEditFieldLabel.FontSize = 16;
            app.TemperatureAlarmEditFieldLabel.Position = [481 186 159 22];
            app.TemperatureAlarmEditFieldLabel.Text = 'Temperature Alarm';

            % Create TemperatureAlarmEditField
            app.TemperatureAlarmEditField = uieditfield(app.UIFigure, 'text');
            app.TemperatureAlarmEditField.HorizontalAlignment = 'center';
            app.TemperatureAlarmEditField.FontName = 'American Typewriter';
            app.TemperatureAlarmEditField.FontSize = 16;
            app.TemperatureAlarmEditField.Position = [502 136 118 38];

            % Create startButton
            app.startButton = uibutton(app.UIFigure, 'push');
            app.startButton.ButtonPushedFcn = createCallbackFcn(app, @startButtonPushed, true);
            app.startButton.Position = [366 22 100 22];
            app.startButton.Text = 'start';

            % Create headlight1
            app.headlight1 = uilamp(app.UIFigure);
            app.headlight1.Position = [238 634 151 151];
            app.headlight1.Color = [0.6706 0.7294 0.7294];

            % Create headlight2
            app.headlight2 = uilamp(app.UIFigure);
            app.headlight2.Position = [434 634 151 151];
            app.headlight2.Color = [0.6706 0.7294 0.7294];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = onitafinal

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end

{\rtf1\ansi\ansicpg1252\cocoartf2638
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fmodern\fcharset0 Courier;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue255;\red60\green118\blue61;\red160\green82\blue45;
\red160\green32\blue240;}
{\*\expandedcolortbl;;\csgenericrgb\c0\c0\c100000;\csgenericrgb\c23529\c46275\c23922;\csgenericrgb\c62745\c32157\c17647;
\csgenericrgb\c62745\c12549\c94118;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\pardirnatural\partightenfactor0

\f0\fs21 \cf2 classdef \cf0 onitafinal < matlab.apps.AppBase\
\
    \cf3 % Properties that correspond to app components\
\cf0     \cf2 properties \cf0 (Access = public)\
        UIFigure                        \cf4 matlab.ui.Figure\
\cf0         GreenLamp                       \cf4 matlab.ui.control.Lamp\
\cf0         YellowLamp                      \cf4 matlab.ui.control.Lamp\
\cf0         RedLamp                         \cf4 matlab.ui.control.Lamp\
\cf0         HeadlightStatusEditFieldLabel   \cf4 matlab.ui.control.Label\
\cf0         HeadlightStatusEditField        \cf4 matlab.ui.control.EditField\
\cf0         MotorSpeedEditFieldLabel        \cf4 matlab.ui.control.Label\
\cf0         MotorSpeedEditField             \cf4 matlab.ui.control.NumericEditField\
\cf0         DistancetoObjectmetersEditFieldLabel  \cf4 matlab.ui.control.Label\
\cf0         DistancetoObjectEditField       \cf4 matlab.ui.control.NumericEditField\
\cf0         LowCoolantAlarmEditFieldLabel   \cf4 matlab.ui.control.Label\
\cf0         LowCoolantAlarmEditField        \cf4 matlab.ui.control.EditField\
\cf0         TemperatureCEditFieldLabel      \cf4 matlab.ui.control.Label\
\cf0         TemperatureEditField            \cf4 matlab.ui.control.NumericEditField\
\cf0         TemperatureAlarmEditFieldLabel  \cf4 matlab.ui.control.Label\
\cf0         TemperatureAlarmEditField       \cf4 matlab.ui.control.EditField\
\cf0         startButton                     \cf4 matlab.ui.control.Button\
\cf0         headlight1                      \cf4 matlab.ui.control.Lamp\
\cf0         headlight2                      \cf4 matlab.ui.control.Lamp\
\cf0     \cf2 end\
\cf0 \
    \cf2 properties \cf0 (Access = private)\
        arduino;\
        offcolor = [0.80,0.80,0.80];\
        off = [0.67,0.73,0.73];\
        dim = [0.2,0.6,0.6];\
        bright = [0,1,1];\
    \cf2 end\
\cf0     \
\
    \cf3 % Callbacks that handle component events\
\cf0     \cf2 methods \cf0 (Access = private)\
\
        \cf3 % Button pushed function: startButton\
\cf0         \cf2 function \cf0 startButtonPushed(app, event)\
            app.startButton.Visible = true;\
            arduino = serialport(\cf5 "/dev/cu.usbmodem142101"\cf0 ,9600);\
            pause(1)\
            \cf2 while \cf0 1\
                valuesstring = readline(arduino);\
                valuesstring = strip(valuesstring);\
                valuesstring = split(valuesstring);\
                distance =  double(valuesstring(1));\
                coolevel =  double(valuesstring(3));\
                temperature =  double(valuesstring(4));\
                speed = double(valuesstring(5));\
                headlight = double(valuesstring(6));\
                app.TemperatureEditField.Value = temperature;\
                \cf2 if \cf0 (coolevel < 30)||(temperature >= 30) \
                    app.DistancetoObjectEditField.Value = 0;\
                    app.MotorSpeedEditField.Value = 0;\
                    app.RedLamp.Color = app.offcolor;\
                    app.GreenLamp.Color = app.offcolor;\
                    app.YellowLamp.Color = app.offcolor;\
                    \cf2 if \cf0 temperature >= 30\
                        app.TemperatureAlarmEditField.Value = \cf5 "ON"\
\cf0                     \cf2 end\
\cf0                     \cf2 if \cf0 coolevel < 30\
                        app.LowCoolantAlarmEditField.Value = \cf5 "ON"\
\cf0                         app.TemperatureAlarmEditField.Value = \cf5 "OFF"\cf0 ;\
                    \cf2 end\
\cf0                 \cf2 else\
\cf0                     app.DistancetoObjectEditField.Value = distance;\
                    app.MotorSpeedEditField.Value = speed;\
                    app.LowCoolantAlarmEditField.Value = \cf5 "OFF"\
\cf0                     app.TemperatureAlarmEditField.Value = \cf5 "OFF"\cf0 ;\
                    \cf2 if \cf0 (distance <= 15) \
                        app.RedLamp.Color = \cf5 'r'\cf0 ;\
                        app.GreenLamp.Color = \cf5 'g'\cf0 ;\
                        app.YellowLamp.Color = \cf5 'y'\cf0 ;                \
                    \cf2 elseif \cf0 ((distance > 15)&&(distance <= 25)) \
                        app.RedLamp.Color = app.offcolor;\
                        app.GreenLamp.Color = \cf5 'g'\cf0 ;\
                        app.YellowLamp.Color = \cf5 'y'\cf0 ;                \
                    \cf2 elseif \cf0 ((distance > 25)&&(distance < 32 ))\
                        app.RedLamp.Color = app.offcolor;\
                        app.GreenLamp.Color = \cf5 'g'\cf0 ;\
                        app.YellowLamp.Color = app.offcolor;                \
                    \cf2 else \
\cf0                         app.RedLamp.Color = app.offcolor;\
                        app.GreenLamp.Color = app.offcolor;\
                        app.YellowLamp.Color = app.offcolor;                \
                    \cf2 end \
\cf0                     \cf2 if \cf0 (headlight == 0) || (headlight == 1)\
                        app.headlight1.Color = app.off;\
                        app.headlight2.Color = app.off;\
                        app.HeadlightStatusEditField.Value = \cf5 "OFF"\cf0 ;\
                    \cf2 elseif \cf0 headlight == 2\
                        app.headlight1.Color = app.dim;\
                        app.headlight2.Color = app.dim;\
                        app.HeadlightStatusEditField.Value = \cf5 "DIM"\cf0 ;\
                    \cf2 else\
\cf0                         app.headlight1.Color = app.bright;\
                        app.headlight2.Color = app.bright;\
                        app.HeadlightStatusEditField.Value = \cf5 "BRIGHT"\cf0 ;\
                    \cf2 end\
\cf0                 \cf2 end\cf0    \
            \cf2 end\
\cf0             delete(arduino);\
        \cf2 end\
\cf0     \cf2 end\
\cf0 \
    \cf3 % Component initialization\
\cf0     \cf2 methods \cf0 (Access = private)\
\
        \cf3 % Create UIFigure and components\
\cf0         \cf2 function \cf0 createComponents(app)\
\
            \cf3 % Create UIFigure and hide until all components are created\
\cf0             app.UIFigure = uifigure(\cf5 'Visible'\cf0 , \cf5 'off'\cf0 );\
            app.UIFigure.Position = [100 100 902 809];\
            app.UIFigure.Name = \cf5 'MATLAB App'\cf0 ;\
\
            \cf3 % Create GreenLamp\
\cf0             app.GreenLamp = uilamp(app.UIFigure);\
            app.GreenLamp.Position = [144 451 151 151];\
            app.GreenLamp.Color = [0.8 0.8 0.8];\
\
            \cf3 % Create YellowLamp\
\cf0             app.YellowLamp = uilamp(app.UIFigure);\
            app.YellowLamp.Position = [340 451 151 151];\
            app.YellowLamp.Color = [0.8 0.8 0.8];\
\
            \cf3 % Create RedLamp\
\cf0             app.RedLamp = uilamp(app.UIFigure);\
            app.RedLamp.Position = [537 451 151 151];\
            app.RedLamp.Color = [0.8 0.8 0.8];\
\
            \cf3 % Create HeadlightStatusEditFieldLabel\
\cf0             app.HeadlightStatusEditFieldLabel = uilabel(app.UIFigure);\
            app.HeadlightStatusEditFieldLabel.HorizontalAlignment = \cf5 'right'\cf0 ;\
            app.HeadlightStatusEditFieldLabel.FontName = \cf5 'American Typewriter'\cf0 ;\
            app.HeadlightStatusEditFieldLabel.FontSize = 16;\
            app.HeadlightStatusEditFieldLabel.Position = [216 283 134 22];\
            app.HeadlightStatusEditFieldLabel.Text = \cf5 'Headlight Status'\cf0 ;\
\
            \cf3 % Create HeadlightStatusEditField\
\cf0             app.HeadlightStatusEditField = uieditfield(app.UIFigure, \cf5 'text'\cf0 );\
            app.HeadlightStatusEditField.HorizontalAlignment = \cf5 'center'\cf0 ;\
            app.HeadlightStatusEditField.FontName = \cf5 'American Typewriter'\cf0 ;\
            app.HeadlightStatusEditField.FontSize = 16;\
            app.HeadlightStatusEditField.Position = [230 233 107 38];\
\
            \cf3 % Create MotorSpeedEditFieldLabel\
\cf0             app.MotorSpeedEditFieldLabel = uilabel(app.UIFigure);\
            app.MotorSpeedEditFieldLabel.HorizontalAlignment = \cf5 'right'\cf0 ;\
            app.MotorSpeedEditFieldLabel.FontName = \cf5 'American Typewriter'\cf0 ;\
            app.MotorSpeedEditFieldLabel.FontSize = 16;\
            app.MotorSpeedEditFieldLabel.Position = [494 382 134 22];\
            app.MotorSpeedEditFieldLabel.Text = \cf5 'Motor Speed (%)'\cf0 ;\
\
            \cf3 % Create MotorSpeedEditField\
\cf0             app.MotorSpeedEditField = uieditfield(app.UIFigure, \cf5 'numeric'\cf0 );\
            app.MotorSpeedEditField.HorizontalAlignment = \cf5 'center'\cf0 ;\
            app.MotorSpeedEditField.FontName = \cf5 'American Typewriter'\cf0 ;\
            app.MotorSpeedEditField.FontSize = 16;\
            app.MotorSpeedEditField.Position = [502 334 118 38];\
\
            \cf3 % Create DistancetoObjectmetersEditFieldLabel\
\cf0             app.DistancetoObjectmetersEditFieldLabel = uilabel(app.UIFigure);\
            app.DistancetoObjectmetersEditFieldLabel.HorizontalAlignment = \cf5 'right'\cf0 ;\
            app.DistancetoObjectmetersEditFieldLabel.FontName = \cf5 'American Typewriter'\cf0 ;\
            app.DistancetoObjectmetersEditFieldLabel.FontSize = 16;\
            app.DistancetoObjectmetersEditFieldLabel.Position = [181 382 216 22];\
            app.DistancetoObjectmetersEditFieldLabel.Text = \cf5 'Distance to Object (meters)'\cf0 ;\
\
            \cf3 % Create DistancetoObjectEditField\
\cf0             app.DistancetoObjectEditField = uieditfield(app.UIFigure, \cf5 'numeric'\cf0 );\
            app.DistancetoObjectEditField.HorizontalAlignment = \cf5 'center'\cf0 ;\
            app.DistancetoObjectEditField.FontName = \cf5 'American Typewriter'\cf0 ;\
            app.DistancetoObjectEditField.FontSize = 16;\
            app.DistancetoObjectEditField.Position = [235 334 107 38];\
\
            \cf3 % Create LowCoolantAlarmEditFieldLabel\
\cf0             app.LowCoolantAlarmEditFieldLabel = uilabel(app.UIFigure);\
            app.LowCoolantAlarmEditFieldLabel.HorizontalAlignment = \cf5 'right'\cf0 ;\
            app.LowCoolantAlarmEditFieldLabel.FontName = \cf5 'American Typewriter'\cf0 ;\
            app.LowCoolantAlarmEditFieldLabel.FontSize = 16;\
            app.LowCoolantAlarmEditFieldLabel.Position = [481 283 152 22];\
            app.LowCoolantAlarmEditFieldLabel.Text = \cf5 'Low Coolant Alarm'\cf0 ;\
\
            \cf3 % Create LowCoolantAlarmEditField\
\cf0             app.LowCoolantAlarmEditField = uieditfield(app.UIFigure, \cf5 'text'\cf0 );\
            app.LowCoolantAlarmEditField.HorizontalAlignment = \cf5 'center'\cf0 ;\
            app.LowCoolantAlarmEditField.FontName = \cf5 'American Typewriter'\cf0 ;\
            app.LowCoolantAlarmEditField.FontSize = 16;\
            app.LowCoolantAlarmEditField.Position = [502 233 118 38];\
\
            \cf3 % Create TemperatureCEditFieldLabel\
\cf0             app.TemperatureCEditFieldLabel = uilabel(app.UIFigure);\
            app.TemperatureCEditFieldLabel.HorizontalAlignment = \cf5 'right'\cf0 ;\
            app.TemperatureCEditFieldLabel.FontName = \cf5 'American Typewriter'\cf0 ;\
            app.TemperatureCEditFieldLabel.FontSize = 16;\
            app.TemperatureCEditFieldLabel.Position = [212 186 141 22];\
            app.TemperatureCEditFieldLabel.Text = \cf5 'Temperature (\'baC)'\cf0 ;\
\
            \cf3 % Create TemperatureEditField\
\cf0             app.TemperatureEditField = uieditfield(app.UIFigure, \cf5 'numeric'\cf0 );\
            app.TemperatureEditField.HorizontalAlignment = \cf5 'center'\cf0 ;\
            app.TemperatureEditField.FontName = \cf5 'American Typewriter'\cf0 ;\
            app.TemperatureEditField.FontSize = 16;\
            app.TemperatureEditField.Position = [230 136 105 38];\
\
            \cf3 % Create TemperatureAlarmEditFieldLabel\
\cf0             app.TemperatureAlarmEditFieldLabel = uilabel(app.UIFigure);\
            app.TemperatureAlarmEditFieldLabel.HorizontalAlignment = \cf5 'right'\cf0 ;\
            app.TemperatureAlarmEditFieldLabel.FontName = \cf5 'American Typewriter'\cf0 ;\
            app.TemperatureAlarmEditFieldLabel.FontSize = 16;\
            app.TemperatureAlarmEditFieldLabel.Position = [481 186 159 22];\
            app.TemperatureAlarmEditFieldLabel.Text = \cf5 'Temperature Alarm'\cf0 ;\
\
            \cf3 % Create TemperatureAlarmEditField\
\cf0             app.TemperatureAlarmEditField = uieditfield(app.UIFigure, \cf5 'text'\cf0 );\
            app.TemperatureAlarmEditField.HorizontalAlignment = \cf5 'center'\cf0 ;\
            app.TemperatureAlarmEditField.FontName = \cf5 'American Typewriter'\cf0 ;\
            app.TemperatureAlarmEditField.FontSize = 16;\
            app.TemperatureAlarmEditField.Position = [502 136 118 38];\
\
            \cf3 % Create startButton\
\cf0             app.startButton = uibutton(app.UIFigure, \cf5 'push'\cf0 );\
            app.startButton.ButtonPushedFcn = createCallbackFcn(app, @startButtonPushed, true);\
            app.startButton.Position = [366 22 100 22];\
            app.startButton.Text = \cf5 'start'\cf0 ;\
\
            \cf3 % Create headlight1\
\cf0             app.headlight1 = uilamp(app.UIFigure);\
            app.headlight1.Position = [238 634 151 151];\
            app.headlight1.Color = [0.6706 0.7294 0.7294];\
\
            \cf3 % Create headlight2\
\cf0             app.headlight2 = uilamp(app.UIFigure);\
            app.headlight2.Position = [434 634 151 151];\
            app.headlight2.Color = [0.6706 0.7294 0.7294];\
\
            \cf3 % Show the figure after all components are created\
\cf0             app.UIFigure.Visible = \cf5 'on'\cf0 ;\
        \cf2 end\
\cf0     \cf2 end\
\cf0 \
    \cf3 % App creation and deletion\
\cf0     \cf2 methods \cf0 (Access = public)\
\
        \cf3 % Construct app\
\cf0         \cf2 function \cf0 app = onitafinal\
\
            \cf3 % Create UIFigure and components\
\cf0             createComponents(app)\
\
            \cf3 % Register the app with App Designer\
\cf0             registerApp(app, app.UIFigure)\
\
            \cf2 if \cf0 nargout == 0\
                clear \cf5 app\
\cf0             \cf2 end\
\cf0         \cf2 end\
\cf0 \
        \cf3 % Code that executes before app deletion\
\cf0         \cf2 function \cf0 delete(app)\
\
            \cf3 % Delete UIFigure when app is deleted\
\cf0             delete(app.UIFigure)\
        \cf2 end\
\cf0     \cf2 end\
end\
}
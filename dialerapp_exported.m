classdef dialerapp_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        TelephoneDialerUIFigure  matlab.ui.Figure
        TextArea                 matlab.ui.control.TextArea
        star                     matlab.ui.control.Button
        pound                    matlab.ui.control.Button
        Button_0                 matlab.ui.control.Button
        Button_9                 matlab.ui.control.Button
        Button_8                 matlab.ui.control.Button
        Button_7                 matlab.ui.control.Button
        Button_6                 matlab.ui.control.Button
        Button_5                 matlab.ui.control.Button
        Button_4                 matlab.ui.control.Button
        Button_3                 matlab.ui.control.Button
        Button_2                 matlab.ui.control.Button
        Button_1                 matlab.ui.control.Button
    end

    
    properties (Access = private)
        duration = 0.2; % Duration of tone
        fs = 8000; % Sampling rate
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: Button_1
        function Button_1Pushed(app, event)
            app.TextArea.Value = app.TextArea.Value + "1";
            f1 = 697;
            f2 = 1209;
            t = 0:1/app.fs:app.duration;
            dial_tone = sin(2 * pi * f1 * t) + sin(2 * pi * f2 * t); 
            dial_tone = dial_tone / max(abs(dial_tone)); % Normalize to stop clipping
            sound(dial_tone, app.fs); % Play the sound
        end

        % Button pushed function: Button_2
        function Button_2Pushed(app, event)
            app.TextArea.Value = app.TextArea.Value + "2";
            f1 = 697;
            f2 = 1336;
            t = 0:1/app.fs:app.duration;
            dial_tone = sin(2 * pi * f1 * t) + sin(2 * pi * f2 * t); 
            dial_tone = dial_tone / max(abs(dial_tone)); % Normalize to stop clipping
            sound(dial_tone, app.fs); % Play the sound
        end

        % Button pushed function: Button_3
        function Button_3Pushed(app, event)
            app.TextArea.Value = app.TextArea.Value + "3";
            f1 = 697;
            f2 = 1477;
            t = 0:1/app.fs:app.duration;
            dial_tone = sin(2 * pi * f1 * t) + sin(2 * pi * f2 * t); 
            dial_tone = dial_tone / max(abs(dial_tone)); % Normalize to stop clipping
            sound(dial_tone, app.fs); % Play the sound
        end

        % Button pushed function: Button_4
        function Button_4Pushed(app, event)
            app.TextArea.Value = app.TextArea.Value + "4";
            f1 = 770;
            f2 = 1209;
            t = 0:1/app.fs:app.duration;
            dial_tone = sin(2 * pi * f1 * t) + sin(2 * pi * f2 * t); 
            dial_tone = dial_tone / max(abs(dial_tone)); % Normalize to stop clipping
            sound(dial_tone, app.fs); % Play the sound
        end

        % Button pushed function: Button_5
        function Button_5Pushed(app, event)
            app.TextArea.Value = app.TextArea.Value + "5";
            f1 = 770;
            f2 = 1336;
            t = 0:1/app.fs:app.duration;
            dial_tone = sin(2 * pi * f1 * t) + sin(2 * pi * f2 * t); 
            dial_tone = dial_tone / max(abs(dial_tone)); % Normalize to stop clipping
            sound(dial_tone, app.fs); % Play the sound
        end

        % Button pushed function: Button_6
        function Button_6Pushed(app, event)
            app.TextArea.Value = app.TextArea.Value + "6";
            f1 = 770;
            f2 = 1477;
            t = 0:1/app.fs:app.duration;
            dial_tone = sin(2 * pi * f1 * t) + sin(2 * pi * f2 * t); 
            dial_tone = dial_tone / max(abs(dial_tone)); % Normalize to stop clipping
            sound(dial_tone, app.fs); % Play the sound
        end

        % Button pushed function: Button_7
        function Button_7Pushed(app, event)
            app.TextArea.Value = app.TextArea.Value + "7";
            f1 = 852;
            f2 = 1209;
            t = 0:1/app.fs:app.duration;
            dial_tone = sin(2 * pi * f1 * t) + sin(2 * pi * f2 * t); 
            dial_tone = dial_tone / max(abs(dial_tone)); % Normalize to stop clipping
            sound(dial_tone, app.fs); % Play the sound
        end

        % Button pushed function: Button_8
        function Button_8Pushed(app, event)
            app.TextArea.Value = app.TextArea.Value + "8";
            f1 = 852;
            f2 = 1336;
            t = 0:1/app.fs:app.duration;
            dial_tone = sin(2 * pi * f1 * t) + sin(2 * pi * f2 * t); 
            dial_tone = dial_tone / max(abs(dial_tone)); % Normalize to stop clipping
            sound(dial_tone, app.fs); % Play the sound
        end

        % Button pushed function: Button_9
        function Button_9Pushed(app, event)
            app.TextArea.Value = app.TextArea.Value + "9";
            f1 = 852;
            f2 = 1477;
            t = 0:1/app.fs:app.duration;
            dial_tone = sin(2 * pi * f1 * t) + sin(2 * pi * f2 * t); 
            dial_tone = dial_tone / max(abs(dial_tone)); % Normalize to stop clipping
            sound(dial_tone, app.fs); % Play the sound
        end

        % Button pushed function: Button_0
        function Button_0Pushed(app, event)
            app.TextArea.Value = app.TextArea.Value + "0";
            f1 = 941;
            f2 = 1209;
            t = 0:1/app.fs:app.duration;
            dial_tone = sin(2 * pi * f1 * t) + sin(2 * pi * f2 * t); 
            dial_tone = dial_tone / max(abs(dial_tone)); % Normalize to stop clipping
            sound(dial_tone, app.fs); % Play the sound
        end

        % Button pushed function: star
        function starButtonPushed(app, event)
            app.TextArea.Value = app.TextArea.Value + "*";
            f1 = 941;
            f2 = 1336;
            t = 0:1/app.fs:app.duration;
            dial_tone = sin(2 * pi * f1 * t) + sin(2 * pi * f2 * t); 
            dial_tone = dial_tone / max(abs(dial_tone)); % Normalize to stop clipping
            sound(dial_tone, app.fs); % Play the sound
        end

        % Button pushed function: pound
        function poundButtonPushed(app, event)
            app.TextArea.Value = app.TextArea.Value + "#";
            f1 = 941;
            f2 = 1477;
            t = 0:1/app.fs:app.duration;
            dial_tone = sin(2 * pi * f1 * t) + sin(2 * pi * f2 * t); 
            dial_tone = dial_tone / max(abs(dial_tone)); % Normalize to stop clipping
            sound(dial_tone, app.fs); % Play the sound
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create TelephoneDialerUIFigure and hide until all components are created
            app.TelephoneDialerUIFigure = uifigure('Visible', 'off');
            app.TelephoneDialerUIFigure.Position = [100 100 640 480];
            app.TelephoneDialerUIFigure.Name = 'Telephone Dialer';

            % Create Button_1
            app.Button_1 = uibutton(app.TelephoneDialerUIFigure, 'push');
            app.Button_1.ButtonPushedFcn = createCallbackFcn(app, @Button_1Pushed, true);
            app.Button_1.FontSize = 20;
            app.Button_1.Position = [50 344 87 76];
            app.Button_1.Text = '1';

            % Create Button_2
            app.Button_2 = uibutton(app.TelephoneDialerUIFigure, 'push');
            app.Button_2.ButtonPushedFcn = createCallbackFcn(app, @Button_2Pushed, true);
            app.Button_2.FontSize = 20;
            app.Button_2.Position = [156 344 87 76];
            app.Button_2.Text = '2';

            % Create Button_3
            app.Button_3 = uibutton(app.TelephoneDialerUIFigure, 'push');
            app.Button_3.ButtonPushedFcn = createCallbackFcn(app, @Button_3Pushed, true);
            app.Button_3.FontSize = 20;
            app.Button_3.Position = [263 344 87 76];
            app.Button_3.Text = '3';

            % Create Button_4
            app.Button_4 = uibutton(app.TelephoneDialerUIFigure, 'push');
            app.Button_4.ButtonPushedFcn = createCallbackFcn(app, @Button_4Pushed, true);
            app.Button_4.FontSize = 20;
            app.Button_4.Position = [50 251 87 76];
            app.Button_4.Text = '4';

            % Create Button_5
            app.Button_5 = uibutton(app.TelephoneDialerUIFigure, 'push');
            app.Button_5.ButtonPushedFcn = createCallbackFcn(app, @Button_5Pushed, true);
            app.Button_5.FontSize = 20;
            app.Button_5.Position = [156 251 87 76];
            app.Button_5.Text = '5';

            % Create Button_6
            app.Button_6 = uibutton(app.TelephoneDialerUIFigure, 'push');
            app.Button_6.ButtonPushedFcn = createCallbackFcn(app, @Button_6Pushed, true);
            app.Button_6.FontSize = 20;
            app.Button_6.Position = [263 251 87 76];
            app.Button_6.Text = '6';

            % Create Button_7
            app.Button_7 = uibutton(app.TelephoneDialerUIFigure, 'push');
            app.Button_7.ButtonPushedFcn = createCallbackFcn(app, @Button_7Pushed, true);
            app.Button_7.FontSize = 20;
            app.Button_7.Position = [50 159 87 76];
            app.Button_7.Text = '7';

            % Create Button_8
            app.Button_8 = uibutton(app.TelephoneDialerUIFigure, 'push');
            app.Button_8.ButtonPushedFcn = createCallbackFcn(app, @Button_8Pushed, true);
            app.Button_8.FontSize = 20;
            app.Button_8.Position = [156 159 87 76];
            app.Button_8.Text = '8';

            % Create Button_9
            app.Button_9 = uibutton(app.TelephoneDialerUIFigure, 'push');
            app.Button_9.ButtonPushedFcn = createCallbackFcn(app, @Button_9Pushed, true);
            app.Button_9.FontSize = 20;
            app.Button_9.Position = [263 159 87 76];
            app.Button_9.Text = '9';

            % Create Button_0
            app.Button_0 = uibutton(app.TelephoneDialerUIFigure, 'push');
            app.Button_0.ButtonPushedFcn = createCallbackFcn(app, @Button_0Pushed, true);
            app.Button_0.FontSize = 20;
            app.Button_0.Position = [156 60 87 76];
            app.Button_0.Text = '0';

            % Create pound
            app.pound = uibutton(app.TelephoneDialerUIFigure, 'push');
            app.pound.ButtonPushedFcn = createCallbackFcn(app, @poundButtonPushed, true);
            app.pound.FontSize = 20;
            app.pound.Position = [263 60 87 76];
            app.pound.Text = '#';

            % Create star
            app.star = uibutton(app.TelephoneDialerUIFigure, 'push');
            app.star.ButtonPushedFcn = createCallbackFcn(app, @starButtonPushed, true);
            app.star.FontSize = 20;
            app.star.Position = [50 60 87 76];
            app.star.Text = '*';

            % Create TextArea
            app.TextArea = uitextarea(app.TelephoneDialerUIFigure);
            app.TextArea.FontSize = 24;
            app.TextArea.Position = [363 60 263 360];

            % Show the figure after all components are created
            app.TelephoneDialerUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = dialerapp_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.TelephoneDialerUIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.TelephoneDialerUIFigure)
        end
    end
end
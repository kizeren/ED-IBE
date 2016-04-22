﻿using System;
using System.IO;
using System.Windows.Forms;
using System.Xml;
using System.Xml.Serialization;

namespace IBE
{
    //GameSettings class interfaces with the actual Game configuration files.
    //Note only needed functions and properties are loaded.
    
    public class GameSettings
    {
        private AppConfig AppConfigGlobal;
        private AppConfig AppConfigLocal;

        private EdDisplayConfig m_Display;
        private DateTime lastTry_Displaydata = DateTime.Now - new TimeSpan(1,0,0);

        public GameSettings()
        {
            try
            {
                //Load DisplaySettings from AppData
                LoadDisplaySettings();

                //Load AppConfig
                AppConfigGlobal = LoadAppConfig("AppConfig.xml", false);
                AppConfigLocal  = LoadAppConfig("AppConfigLocal.xml", true);

                //Set up some filewatchers, If user changes config its reflected here
                WatcherDisplaySettings();
                WatcherAppDataSettings(); //Currently disabled as we only check Verbose logging and that cant be changed from the game

                if((AppConfigGlobal.Network.VerboseLogging != 1) && ((AppConfigLocal == null) || (AppConfigLocal.Network.VerboseLogging != 1)))
                { 
                    //Check and Request for Verbose Logging
                    AppConfigLocal = CheckAndRequestVerboseLogging("AppConfigLocal.xml", AppConfigLocal);
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error while creating the object", ex);
            }
        }

        // access to the Display-object
        public EdDisplayConfig Display
        {
            get
            {
                return m_Display;
            }
        }

        AppConfig CheckAndRequestVerboseLogging(String fileName, AppConfig configuration)
        {
            try
            {
                if ((configuration == null) || (configuration.Network.VerboseLogging != 1))
                {
                    if(!Program.SplashScreen.IsDisposed)
                        Program.SplashScreen.TopMost = false;

                    var setLog =
                        MessageBox.Show(
                            "Verbose logging isn't set in your Elite Dangerous AppConfig.xml, so I can't read system names. Would you like me to set it for you?",
                            "Set verbose logging?", MessageBoxButtons.YesNo);

                    if(!Program.SplashScreen.IsDisposed)
                        Program.SplashScreen.TopMost = true;

                    if (setLog == DialogResult.Yes)
                    {
                        var appConfigFilePath = Path.Combine(Program.DBCon.getIniValue<String>(IBE.IBESettingsView.DB_GROUPNAME, "GamePath"), fileName);
                        var doc = new XmlDocument();

                        //Make backup
                        if(File.Exists(appConfigFilePath))
                        {
                            File.Copy(appConfigFilePath, appConfigFilePath+".bak", true);
                            doc.Load(appConfigFilePath);
                        }
                        else
                        {
                            doc.LoadXml("<AppConfig><Network></Network></AppConfig>");
                        }

                        var ie = doc.SelectNodes("/AppConfig/Network").GetEnumerator();

                        while (ie.MoveNext())
                        {
                            if ((ie.Current as XmlNode).Attributes["VerboseLogging"] != null)
                            {
                                (ie.Current as XmlNode).Attributes["VerboseLogging"].Value = "1";
                            }
                            else
                            {
                                var verb = doc.CreateAttribute("VerboseLogging");
                                verb.Value = "1";

                                (ie.Current as XmlNode).Attributes.Append(verb);
                            }
                        }

                        doc.Save(appConfigFilePath);

                        if(!Program.SplashScreen.IsDisposed)
                            Program.SplashScreen.TopMost = false;

                        MessageBox.Show(
                            fileName + " updated.  You'll need to restart Elite Dangerous if it's already running.");

                        if(!Program.SplashScreen.IsDisposed)
                            Program.SplashScreen.TopMost = true;

                    }

                    //Update config
                    configuration = LoadAppConfig(fileName, false);
                }

                return configuration;
            }
            catch (Exception ex)
            {
                throw new Exception("Error while checking VerboseLogging", ex);
            }
        }

        AppConfig LoadAppConfig(String fileName, Boolean ignoreMissing)
        {
            AppConfig locAppConfig = null;
            DialogResult MBResult = DialogResult.Ignore;

            try
            {
                string configFile = Path.Combine(Program.DBCon.getIniValue<String>(IBE.IBESettingsView.DB_GROUPNAME, "GamePath"), fileName);
                XmlSerializer serializer; 

                do{

                    try
                    {
                        serializer = new XmlSerializer(typeof(AppConfig)); 
                        using (var myFileStream = new FileStream(configFile, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
                        {
                            locAppConfig = (AppConfig)serializer.Deserialize(myFileStream);
                        }
                    }
                    catch (Exception ex)
                    {

                        if ((!ignoreMissing) && (locAppConfig == null))
                        {
                            // ignore if it was loaded before
                            throw new Exception(String.Format("Error while loading ED-Appconfig from file <{0}>", configFile), ex);
                            //cErr.processError(ex, String.Format("Error while loading ED-Appconfig from file <{0}>", configFile));
                        }

                    }
                } while (MBResult == DialogResult.Retry);
           
                return locAppConfig;
            }
            catch (Exception ex)
            {
                throw new Exception("Error while loading the appconfig-file", ex);
            }
        }

        private void AppData_Changed(object sender, FileSystemEventArgs e)
        {
            try
            {
                LoadAppConfig("App", true);
            }
            catch (Exception ex)
            {
                cErr.processError(ex, "Error in AppData_Changed()");
            }
        }

        void LoadDisplaySettings()
        {
            try
            {
                TimeSpan delta;
                DialogResult MBResult = DialogResult.Ignore;
                EdDisplayConfig locDisplay;

                var configFile = Path.Combine(Program.DBCon.getIniValue<String>(IBE.IBESettingsView.DB_GROUPNAME, "ProductAppData"), "Graphics" ,"DisplaySettings.xml");
                if (!File.Exists(configFile))
                {
                    return;
                }
                var serializer = new XmlSerializer(typeof(EdDisplayConfig));


                do
                {
                    try
                    {
                        using (var myFileStream = new FileStream(configFile, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
                        {
                            locDisplay = (EdDisplayConfig)serializer.Deserialize(myFileStream);
                            m_Display = locDisplay;
                        }
                    }
                    catch (Exception ex)
                    {
                        if (m_Display == null)
                        {
                            // ignore this if it was loaded short before
                            delta = DateTime.Now - lastTry_Displaydata;
                            if (delta.TotalMilliseconds > 1000)
                            {
                                if(!Program.SplashScreen.IsDisposed)
                                    Program.SplashScreen.TopMost = false;

                                // ignore this if it was asked before
                                MBResult = MessageBox.Show(String.Format("Error while loading ED-Displaysettings from file <{0}>", configFile), "Problem while loading data...", MessageBoxButtons.AbortRetryIgnore, MessageBoxIcon.Exclamation, MessageBoxDefaultButton.Button3);

                                if(!Program.SplashScreen.IsDisposed)
                                    Program.SplashScreen.TopMost = true;

                                if (MBResult == DialogResult.Abort)
                                {
                                    cErr.processError(ex, "Error in AppData_Changed()", true);
                                }
                                lastTry_Displaydata = DateTime.Now;
                            }
                        }
                    }
                } while (MBResult == DialogResult.Retry);

                // this makes problems -> another solution is needed
                //if (_parent != null)
                //{
                //    _parent.setOCRTabsVisibility();
                //}
            }
            catch (Exception ex)
            {
                throw new Exception("Error while loading display settings", ex);
            }
        }

        private void LoadDisplaySettings(object sender, FileSystemEventArgs e)
        {
            try
            {
                LoadDisplaySettings();
            }
            catch (Exception ex)
            {
                cErr.processError(ex, "Error while loading displaysettigns from event");
            }
        }

        private readonly FileSystemWatcher _displayWatcher = new FileSystemWatcher();
        void WatcherDisplaySettings()
        {
            var path = Path.Combine(Program.DBCon.getIniValue<String>(IBE.IBESettingsView.DB_GROUPNAME, "ProductAppData"), "Graphics");
            if (!Directory.Exists(path) || !File.Exists(Path.Combine(path, "DisplaySettings.xml")))
                return;

            _displayWatcher.Path = path;
            _displayWatcher.Filter = "DisplaySettings.xml";
            _displayWatcher.NotifyFilter = NotifyFilters.LastWrite;
            _displayWatcher.Changed += LoadDisplaySettings;
            _displayWatcher.EnableRaisingEvents = true;
        }

        private readonly FileSystemWatcher _appdataWatcher = new FileSystemWatcher();
        void WatcherAppDataSettings()
        {
            _appdataWatcher.Path = Program.DBCon.getIniValue<String>(IBE.IBESettingsView.DB_GROUPNAME, "GamePath");
            _appdataWatcher.Filter = "AppConfig.xml";
            _appdataWatcher.NotifyFilter = NotifyFilters.LastWrite;
            _appdataWatcher.Changed += AppData_Changed;
            _appdataWatcher.EnableRaisingEvents = false; //Set to TRUE to enable watching!
        }

    }
}

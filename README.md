# scs-print

[![Master Branch Build Status](https://img.shields.io/travis/egomezm/scs-print-module/master.svg?style=flat-square&label=master)](https://travis-ci.org/egomezm/scs-print-module)

## A Module to help send jobs to the scs-print-api

*How to Install this module*

From a terminal or CML interface
```
box install scs-print
```


*How to Configure your module*

Your ModuleConfig.cfc. will have by default this initial fake settings.
Override them in the ColdBox.cfc settings.

Default ModuleConfig.cfc
```
settings = {
            apiUrl = "http:fakesite.com"
        };
```

And then if you use this app, you’d have something like this in your Coldbox.cfc or whatever…
Override default ModuleConfig.cfc with your own settings for where the scs-print-api lives.
```
settings = {
    'scs-print' = {
        settings = {
            apiUrl = "http://[your domain]/print"
        }
    }
};
```

*How to Use and implement your module*

instanctiate your model, and the use the functions available
on your controller or any other place
```
    property name="scs-print" inject="coldbox:setting:scs-print";
```
to use it
```
scs-print-api.scsPrint(printer = [printer], fullPath = [fullPathToFIle]);
```
Here are additional parameters with their default values (but are not required.)
```
required string printer,
required string fullPath,
numeric copies = 1,
string layout = "portrait",
numeric scale = 100
```
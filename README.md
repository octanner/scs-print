# SCS Print Helper
---
![Master Branch Build Status(https://www.forgebox.io/view/print-helper)](https://www.forgebox.io/api/v1/entry/print-helper/badges/version)
![Master Branch Download Status(https://www.forgebox.io/view/print-helper)](https://www.forgebox.io/api/v1/entry/print-helper/badges/downloads)

## A Module to help send jobs to the scs-print-api

*How to Install this module*

From a terminal or CML interface
```
    box install print-helper --save
```


*How to Configure your module*

Your ModuleConfig.cfc. will have by default this initial fake settings.
settings = {   
        'apiUrl' = "http:fakesite.com"   
    };   

**Step 1: Override default apiUrl to send jobs to your own URL (one time change)**

Override default ModuleConfig.cfc with your own settings for where the scs-print-api lives. You can do this by Making sure you add 'print-helper' node to the *moduleSettings* object in the Coldbox.cfc  (if not present add it inside of the configure() function )
```
   		moduleSettings = {
            'print-helper' = { 'apiUrl' : '[your Print API URL]' }
        };  
```
FYI only, behind the scenes Coldbox will interpret the new settings correctly  in this manner (no need to insert this code)
    property name="print-helper-URL"    inject="coldbox:setting:print-helper"; 



**Step 2: Instanciate your Model from your newly installed Module**

When you declare a module and you define a models folder then the framework automatically register all models in that folder for you using a namespace of @moduleName in this case @print-helper .
In other words you will have to create a new property and inject the model of your choice. The pattern to inject its value is [Model]@[Module]
```
	property name='printHelper' inject='printRequestHelper@print-helper';
```

**Step 3: call the print() method and pass your data.**

Once your property has been declared and injected with the model, you are ready to use it, here is and example of the minimum required parameters you need to pass:
```
    printHelper.print(printer = [printer], fullPath = [fullPathToFIle]);
```
Here are additional parameters with their default values (but are not required.)  
required string printer,  
required string fullPath,  
numeric copies = 1,  (Default is 1)
string layout = "portrait", () ["landscape","portrait"] default is portrait)
numeric scale = 100  (Default is 100)

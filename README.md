![alt text](https://github.com/pliegl/ebinterface/blob/master/site/images/logo.jpg?raw=true "ebInterface e-Invoice standard")


Development repository of the Austrian e-Invoicing standard ebInterface. For the official standard versions please refer to the ebInterface website http://www.ebinterface.at


This repository contains two main artifacts:

#ebInterface XML Schema files


Using this repository, the development versions of the different ebInterface standard schemas are shared among the standard developers.


#ebInterface validation service


The ebInterface validation service allows to validate ebInterface instances according to the ebInterface XML Schema version 3.0, 3.02, 4.0 and 4.01.

The validation includes XML Schema conformance, conformance to predefined Schematron rules, and the validation of digital signatures. For the validation of digital signatures the Web Service of [Rundfunk & Telekom Regulierungs-GmbH](http://www.rtr.at) https://pruefung.signatur.rtr.at/ is used.

Additionally, the validation service allows to visualize ebInterface XML instances by applying XSL stylesheets.

The validation contains two main artifacts

 * *ebinterface-core.* This module contains the validation logic for ebInterface instances, the logic for applying stylesheets to ebInterface instances, as well as the Web Service client for the RTR Web Service
 * *ebinterface-web.* This module contains a Web frontend for the *ebinterface-core* module.


##Prerequisites

Please note, that the RTR Web Service is not open to the public, but requires credentials for its HTTP basic authentication in order to be accessed. Username and password must be provided in a properties file named ```rtr.properties``` which must contain the following values:

``` 
rtr.username=<username>
rtr.password=<password>
```

Username and password may be requested from RTR directly, and are not provided in this GitHub repository.



 



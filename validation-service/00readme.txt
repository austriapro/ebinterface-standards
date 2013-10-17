How to make this version build and run:

1. Preparation
  Disable eventually present "*" mirror in Maven settings.xml because
    MOA uses a local, file based repository for building...

2. Checkout the MOA IDSPSS Tag 1.5.1:
  svn co https://joinup.ec.europa.eu/svn/moa-idspss/tags/1.5.1/ moa-idspss

3. Build MOA IDSPSS
  cd moa-idspss
  build

4. Upon success, refresh the dependencies of this project and everything should be fine

Philip Helger, 2013-10-17
 
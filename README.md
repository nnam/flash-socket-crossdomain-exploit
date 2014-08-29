## Flash socket cross-domain exploit
Bypasses the same-origin-policy using Flash sockets and an overly permissive socket policy (crossdomain.xml on port 843 by default).

To compile and deploy:
- Download the Apache Flex SDK from http://flex.apache.org/
- Modify the targetName, data, and sendTo parameters in SocketCrossDomain.as
- Compile using mxmlc from the Flex SDK:
```
mxmlc SocketCrossDomain.as
```
- Deploy SocketCrossDomain.swf and exploit.html to the same web directory

--
Credit to Gursev Singh Kalra for the original Flash PoC (https://github.com/gursev/flash-xdomain-xploit).

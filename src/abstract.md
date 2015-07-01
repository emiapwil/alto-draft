<!-- why we need to design a multi-source ALTO server [[[-->

With the standardization of the Application-Layer Traffic Optimization (ALTO)
protocol in IETF, multiple groups have started the designing and implementation
of ALTO servers.  This document shares the experience of our work and introduces
a generic framework to develop ALTO servers.  The major motivation for this
design is that [](#RFC7285) only specifies the formats for communications
between ALTO servers and clients and has no constraints on the sources of
information nor the methods to store and process the information, thus different
ALTO service instances can and are very likely to have different internal
protocols and representations for efficiency, security and copyright reasons.
In this document, we discuss the benefits of our ALTO server framework, our
design decisions and other advanced topics on the development and deployment of
ALTO services.

<!-- ]]] -->

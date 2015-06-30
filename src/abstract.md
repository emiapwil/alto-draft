<!-- why we need to design a multi-source ALTO server [[[-->

GK:

This document shares the experience of designing and implementing a
multi-source ALTO server. A major motivation is that [](#RFC7285) only
specifies the output format for ALTO services so it has no constraints on the
internal structure of a server. Even though different implementations may and
should have different internal representations for efficiency reasons, they can
benefit from a general framework in several ways. This document introduces such
a framework and discusses some advanced features for ALTO services.

<!-- ]]] -->

YRY:

With the standardization of the Application-Layer Traffic Optimization (ALTO)
protocol, multiple groups have started the design and implementation of ALTO
servers. Although the most basic services (i.e., the full network and cost maps)
of ALTO are relatively easy to implement, say using an HTTP server, other
already-defined or emerging services, including the filtered maps, the endpoint
property service (EPS), the endpoint cost service (ECS), and incremental updates
can be more difficult to implement. In addition, a key challenge in providing
the ALTO services is to derive the ALTO information resources, but this is not
defined in the ALTO protocol. This document discusses our design and
implementation of an ALTO server that can function in either OpenDaylight or
ONOS. We discuss the design alternatives and our design decisions.


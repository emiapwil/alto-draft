<!-- why we need to design a cross-platform ALTO server [[[-->

This document shares the experience of designing and implementing a
cross-platform ALTO server. A major motivation is that [](#RFC7285) only
specifies the output format for ALTO services so it has no constraints on the
internal structure of a server. Even though different implementations may and
should have different internal representations for efficiency reasons, they can
benefit from a general framework in several ways. This document introduces such
a framework and discusses some advanced features for ALTO services.

<!-- ]]] -->

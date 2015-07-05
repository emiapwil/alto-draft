
# ALTO Servers and Information Sources { #alto-info-sources }
<!-- [[[ -->

This section introduces the concept of "information sources" and discusses the
possible relationships between an ALTO server and an information source.
Furthermore, a protocol is proposed for the communication between server
implementations with certain internal structures and the corresponding
information sources.

## Information Sources
<!-- what are information sources [[[ -->

An "information source" can be roughly described as any entity that is capable
of providing information on the network but the exact meaning depends on the
server implementation.  For example, in Software Defined Networking (SDN), a
controller that provides topology views is an information source, meanwhile P2P
clients submitting the statistics of a connection and even another ALTO server
can also be regarded as information sources.  In this document we identify four
major kinds of information sources:

- Human Input
<!-- [[[ -->

    It is possible that the administrators of an ALTO service want to modify the
    output to meet the need of certain demands such as policy changes, so they may
    compose some data accordingly and input them into the server.  Also in the
    early stages of ALTO server development, human interference is inevitable to
    detect abnormal behavior.

<!-- ]]] -->
- Network Measurement Tools
<!-- [[[ -->

    Due to financial, technical and security reasons it has been hard to fetch the
    required data directly from ISPs, thus many efforts have been made to measure
    different metrics using endpoint-based tools.  Since most of these tools require
    little support from the network infrastructure, lots of them can still work even
    if the Internet architecture evolves.  These measurement techniques can be
    valuable sources to ALTO services as the measured results often reflect the
    actual performance of the network.

<!-- ]]] -->
- Network Operating Systems
<!-- [[[ -->

    With the progress on opening up the network in recent years, especially with
    the development of SDN, the networking system itself has become an important
    source of network information.  Using "northbound" APIs provided by SDN
    controllers, one can get both the configurations and the accurate running
    states of a network.

<!-- ]]] -->
- Information Aggregators
<!-- [[[ -->

    While information sources discussed above are capable to provide raw data,
    these data can be aggregated, by a third-party aggregator or as in some
    hiearchical SDN controller designs, by a higher-level network OS.  It is
    notable that an ALTO server itself can also be regarded as a source of
    aggregated information.

<!-- ]]] -->

<!-- ]]] -->

## Relationship Analysis { #relationships }
<!-- [[[ -->

The complexity of the relationships between ALTO servers and information sources
comes from the following aspects:

- How to identify the boundary;
- How ALTO servers and information sources are coupled;
- The capabilities of information sources.

### Identification of Boundaries
<!-- [[[ -->

When we discuss the relationship between an ALTO server and the information
source, it is important to identify the boundary first.  As it is shown in
[](#fig:boundary-identification), we can see with different boundaries,
different pairs of ALTO servers and information sources can be identified and
their relationships are not quite the same.

<!-- figure: example of different choices of boundaries [[[ -->

    +------------------+-----------------------------------------------+
    |  ALTO Server #A  |          Information Source #A                |


                           +---------------------------------------+
        +--------+         |  +---------+                          |
        |        |         |  |         |       Information        |
        |  Host  +------------+  Agent  |        Source #0         |
        |        |         |  |         |                          |
        +--------+         |  +---------+                          |
                           +---------------------------------------+

    |           ALTO SERVER #B             |   Information Source #B   |
    +--------------------------------------+---------------------------+
^[fig:boundary-identification::Different Ways to Identify the Boundary]

<!-- ]]] -->

<!-- ]]] -->

### Types of Coupling
<!-- how ALTO servers and IS are coupled [[[ -->

We identify three types of coupling ALTO servers and information sources.

- The ALTO server is deeply embedded into the information source, which is
  either a network OS or an information aggregator.  For example, our group has
  participated in a project to provide ALTO services in Open Daylight, a famous
  SDN controller.

- The ALTO server is loosely coupled with the information source.  One example is
  the ALTO server #A in [](#fig:boundary-identification) if the host and agents
  are still coupled by some private protocol.

- The ALTO server is decoupled from the information sources.

<!-- ]]] -->

### Capabilities of Information Sources
<!-- [[[ -->

The capabilities of an information source which declare the types of available
information are determined by the type of the information source and the
limitation of the targeted network, both of which can vary significantly.

<!-- ]]] -->

<!-- ]]] -->

<!-- ]]] -->

# Protocol Design { #alto-info-protocol }
<!-- [[[ -->

As described above it is difficult to define a unified protocol to cover the
need of ALL ALTO server implementations.  However, we can narrow down the
demands by establishing clear boundaries and focus on the most general and most
commonly used requirements.  The protocol is based on ALTO because of the fact
that as mentioned in [](#information-sources), the ALTO servers are actually one
kind of information source so it is natural to consider regulating the
communication formats by extending the ALTO protocol.

To clarify the boundaries of the targeted information and to exploit the
limitation of the current ALTO specification, especially for the network map
service, two internal representations of an ALTO information service are
introduced.  We derive our design based on these two representations and discuss
how to extend the ALTO specification so that the extensions can fit in the
framework.

## Internal Structures of ALTO Implementations
<!-- [[[ -->

Two implementation choices are identified for ALTO services as discussed below.
It can be seen that both structures are highly related to and can reflect the
information sources they use.

- End-to-End
<!-- [[[ -->

    In an end-to-end implementation, the network is represented as a full-mesh
    graph in which case the links are implicit and can be ignored.  This can
    happen when the corresponding information source collects the information
    either by conducting end-to-end measurement methods itself or by making
    request to other information resources, whether it is forced to do so
    because of not having the condition or priority to get topological
    information or as an intentional choice.

<!-- ]]] -->
- Topological
<!-- [[[ -->

    In this case the server is using a graph with explicit nodes and links, to
    represent a network.  The graph is usually sparse and may have internal
    nodes that are transparent to the ALTO clients.  Such examples are servers
    retrieving topology information from a SDN controller, from a data
    aggregator such as CAIDA, or simply from a configuration parser.

<!-- ]]] -->

<!-- ]]] -->

## Overview of Extended ALTO Services
<!-- [[[ -->

<!-- Limitations of Current ALTO Specification [[[ -->

It can be seen that the current ALTO specifications only leverage end-to-end
information to the clients.  That is probably good enough for end users to
choose from different destinations, however, the original ALTO protocol is not
capable of publishing topological information.

<!-- ]]] -->

To support this feature, the following extensions are proposed for ALTO
protocol:

- [](#extended-network-map) introduces an extension of network maps;
- [](#information-map) introduces the extension to publish information
  for all elements defined in the extended network map.
- [](#endpoint-info-service) introduces the extension to support querying
  information between two endpoints.

<!-- ]]] -->

## Extended Network Map
<!-- [[[ -->

The extended network map can publish topological information such as links
between different endpoints.  Just like for the network map, filtering is also
possible for the extended network map but due to timing issues it is not
discussed in this document.

#### Media Type
<!-- [[[ -->

The media types for extended network map is defined in [](#media-types).

<!-- ]]] -->

#### HTTP Method
<!-- [[[ -->

The extended network map is requested using the HTTP GET method.

<!-- ]]] -->

#### Accept Input Parameters
<!-- [[[ -->

None

<!-- ]]] -->

#### Capabilities
<!-- [[[ -->

The capabilities of an extended network map are described using a JSON object of
type ExtNetworkMapCapabilities:

        object {
            JSONString type<1..1>;
        } ExtNetworkMapCapabilities;

with fields:

- type: the type of information that is published.  Currently the only valid
  options are "end-to-end" and "topological".

<!-- ]]] -->

#### Uses
<!-- [[[ -->

None.

<!-- ]]] -->

#### Response { #extnetmap-response }
<!-- [[[ -->

The "meta" field of the response is the same as of network map responses.

The data component of an extended network map service is named
"extended-network-map", which is a JSON object of type ExtNetworkMapData, where

        object {
            ExtNetworkMapData   extended-network-map;
        } InfoResourceExtNetworkMap : ResponseEntityBase;

<!-- -->

        object {
            NodeData            nodes;
            [LinkData            links;]
        } ExtNetworkMapData;

<!-- -->

        object-map {
            NodeName -> NodeDesc;
        } EndpointData;

<!-- -->

        object {
            [JSONBool            internal;]
        } NodeDesc : EndpointAddrGroup;

<!-- -->

        object-map {
            LinkName -> LinkDesc;
        } LinkData;

<!-- -->

        object {
            JSONString          pid<2..2>;
            LinkPropertyType -> JSONValue;
        } LinkDesc;

If the "type" field in the capabilities is "end-to-end", there MUST be no
"links" field in the data component and no "internal" field in any node
description.  At the same time, ALTO clients MUST ignore these fields if they
are mistakenly provided.

If the "type" field in the capabilities is "topological", the "links" field and
the "internal" field MUST be provided.

<!-- ]]] -->

#### Example

<!-- ]]] -->

## Information Map
<!-- [[[ -->

The information map has many similarities with the cost map.  Instead of
providing only the "cost" between endpoints, it is extended to publish generic
network information for both endpoint/node pairs and links.  Filtering is also
optional and due to timing issues it is not described in this document.

#### Media Type
<!-- [[[ -->

The media types for information map is defined in [](#media-types).

<!-- ]]] -->

#### HTTP Method
<!-- [[[ -->

The information map is requested using the HTTP GET method.

<!-- ]]] -->

#### Accept Input Parameters
<!-- [[[ -->

None

<!-- ]]] -->

#### Capabilities
<!-- [[[ -->

The capabilities of an information map are described using a JSON object of
type InfoMapCapabilities:

        object {
            JSONString    properties<0..*>;
        } InfoMapCapabilities;

with fields:

- properties: the list containing the property names of paths and links.  The
  names SHOULD indicate the exact target using prefixes such as "path-" or
  "link-".  The properties here CAN contain both characteristic attributes and
  statistics for a given path/link.

<!-- ]]] -->

#### Uses
<!-- [[[ -->

The resource ID of the network map or the extended network map based on which
the information map will be defined.

<!-- ]]] -->

#### Response { #infomap-response }
<!-- [[[ -->

<!-- Meta [[[ -->

The "meta" field of the response is described using the following JSON object:

        object {
            VersionTag    dependent-vtags<1..1>;
            VersionTag    vtag;
            [PropertyName -> PropertySpec;]
        } InfoMapMetaData;

<!-- -->

        object {
            JSONString          type;
            [PropertyAttrName -> JSONValue;]
        } PropertySpec;

with fields:

- vtag: the same as the "vtag" in the network map;

- dependent-vtags: the same as the "dependent-vtags" in the cost map, with the
  addition that resource ID can point to an extended network map;

- PropertyName: the name listed in the capabilities.

The "type" field in PropertySpec is either 'path' or 'link', designating the
target the property is for.

<!-- ]]] -->

<!-- Data [[[ -->

The data component of an information map service is named "information-map",
which is a JSON object of type InfoMapData, where:

        object {
            InfoMapData         information-map;
        } InfoResourceInfoMap : ResponseEntityBase;

<!-- -->

        object-map {
            PropertyName -> PropertyMapData;
        } InfoMapData;

<!-- -->

        object-map {
            NodeName -> { NodeName -> JSONValue };
        } PathPropertyData : PropertyMapData;

<!-- -->

        object-map {
            LinkName -> JSONValue;
        } LinkPropertyData : PropertyMapData;

If the "type" field in the corresponding PropertySpec is "path", the type of the
PropertyMapData MUST be PathPropertyData and the same goes for "link" and
LinkPropertyData.

<!-- ]]] -->

<!-- ]]] -->

#### Example


<!-- ]]] -->

## Endpoint Information Service { #endpoint-info-service }
<!-- [[[ -->

The endpoint information service to the information map is just as the endpoint
cost service to the cost map.  It provides only the requested information for
paths specified by given pairs of addresses.

#### Media Type
<!-- [[[ -->

The media types for endpoint information service is defined in [](#media-types).

<!-- ]]] -->

#### HTTP Method
<!-- [[[ -->

The endpoint information service is requested using the HTTP POST method.

<!-- ]]] -->

#### Accept Input Parameters { #eis-input }
<!-- [[[ -->

The input parameters for the endpoint information service is described using the
following JSON object:

        object {
            EndpointFilter    endpoints;
            [PropertySpecName -> PropertySpec;]
            [JSONString       constraints<0..*>;]
        } EndpointInfoReq;

The EndpointFilter is the same as defined in [](#RFC7285).  The PropertySpec is
the same as defined in [](#information-map).  The "constraints" have the
following three components:

- A property name that indicates the property to filter. The corresponding
  property MUST be declared in the capabilities otherwise it MUST be ignored.
- An operator as defined in [](#RFC7285)
- A constant or a symbolic property to be compared to.

<!-- ]]] -->

#### Capabilities
<!-- [[[ -->

The capabilities of the endpoint information service are described using a JSON object of
type EndpointInfoCapabilities:

        object {
            JSONString    properties<0..*>;
        } EndpointInfoCapabilities;

with fields:

- properties: the list containing the property names between endpoints.

<!-- ]]] -->

#### Uses
<!-- [[[ -->

The resource ID of the network map or the extended network map based on which
the endpoint information service will be defined.

<!-- ]]] -->

#### Response { #eis-response }
<!-- [[[ -->

<!-- Meta [[[ -->

The "meta" field of the response is described using the following JSON object:

        object {
            VersionTag    dependent-vtags<1..1>;
            VersionTag    vtag;
            [PropertyName -> PropertySpec;]
        } InfoMapMetaData;

        object {
            JSONString          type;
            [PropertyAttrName -> JSONValue;]
        } PropertySpec;

with fields:

- dependent-vtags: the same as the "dependent-vtags" in the cost map, with the
  addition that resource ID can point to an extended network map;

- vtag: the same as in the network map;

- PropertyName: the name listed in the request.

<!-- ]]] -->

<!-- Data [[[ -->

The data component of an information map service is named "information-map",
which is a JSON object of type InfoMapData, where:

        object {
            InfoMapData         information-map;
        } InfoResourceInfoMap : ResponseEntityBase;

<!-- -->

        object-map {
            PropertyName -> PropertyMapData;
        } InfoMapData;

<!-- -->

        object-map {
            TypedEndpointAddr -> { TypedEndpointAddr -> JSONValue };
        } PathPropertyData : PropertyMapData;

<!-- ]]] -->

<!-- ]]] -->

#### Example


<!-- ]]] -->

<!-- ]]] -->

# Future Improvement
<!-- [[[ -->

In this document three new ALTO services are introduced, however, they only
serve as basic functionalities to distribute information.  In this section we
discuss some advanced topics about the extensions.

## Derive ALTO Services from the Extensions
<!-- [[[ -->

Even though the extended network map is capable to provide topological
information, sometimes applications would still only request for end-to-end
information.  Also, due to backward-compatibility considerations, a network map
derived from the extended network map is desired.

One simple implementation is to crop the "links" field from the data component
in an extended network map response, ignore all internal nodes and rename the
"nodes" field to "network-map".

At the same time, new information maps and an endpoint information services can
be derived from the corresponding ones for the base extended network map.  For
example, consider the hop count as the targeted information, the hop counts
between two endpoints can be derived by summing up the hop counts (which all
have the value of 1) on all the links on the path.  The example also demonstrate
that the cost map can be derived from certain information maps.

<!-- ]]] -->

## Information Aggregation Services
<!-- [[[ -->

With the extensions introduced in [](#alto-info-protocol), an generic ALTO server
implementation can collect information by requesting another ALTO server
providing these information.  However, question still remains that how the
original data can be collected.

One possible way is to use customized ALTO servers, for example, one embedded
into a SDN controller.

Another approach is to enable passive data collection in an ALTO server where
the ALTO server declares a new kind of ALTO "aggregation" service. The
aggregation service defines the format of information it can resolve so that
information sources, whether they are ALTO servers, ALTO clients or a
third-party agents, can push the data to the server.  One good way to start is
to reuse the format defined for the extensions in [](#alto-info-protocol).

<!-- ]]] -->


## Scope for Extended ALTO Services

With the approaches in [](#alto-info-protocol) and the ones discussed in
sections above, we represent how ALTO protocol can be used in distributing
network information to the application in [](#fig:alto-scenario) where the
normal paths represent ALTO protocol and the starred path represents some
private protocol.

<!-- [[[ -->

           +---------------------+             +--------------------+
           |                     |             |                    |
           |                     |       ******+ Private            |
           |                     |       *     | Information Source |
           |                     |       *     |                    |
           |                     |       *     +--------------------+
           |                     v       v
           |                  +--+-------+--+         +-------------+
    +------+------+           |             |         |             |
    |             +<----------+ Generic     +<--------+ Third-Party |
    | ALTO Client |           | ALTO Server |         | Aggregator  |
    |             |  +--------+             |         |             |
    +-------------+  |        +-----+-------+         +-------------+
                     |              ^
                     v              |     +-------------+
           +---------+---+          +-----+             |
           |             |                | Customized  |
           | ALTO Client |                | ALTO Server |
           |             +<---------------+             |
           +-------------+                +-------------+
^[fig:alto-scenario::AN ALTO Deployment Scenario]

<!-- ]]] -->

<!-- ]]] -->


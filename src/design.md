
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
  participated in a project to provide ALTO services in [](#OpenDaylight), an industrial
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
commonly used requirements.

An observation is made that as mentioned in [](#information-sources), the ALTO
servers are actually one kind of information source and the ALTO protocol is
designed to publish certain network information.  Hence, instead of designing a
new protocol for data collection, which would result in functionality overlap
assuredly and introduce complexity from an implementation perspective, the
solution proposed in this document is based on the ALTO protocol.  In this case,
information sources can also take advantages of the ALTO framework such as the
service discovery mechanism, and current ALTO implementations don't have to
change anything if they want to serve as an information source too.

To clarify the boundaries of the targeted information and to exploit the
limitation of the current ALTO specification, especially for the network map
service, two internal representations of an ALTO information service are
introduced.  We derive our design based on these two representations and discuss
how to extend the ALTO specification so that the extensions can fit in the
framework.

## Common ALTO Information Bases
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
between different endpoints.  The data component in the response uses the
classic Vertices-Edges representation to describe the topology.

Just like for the network map, filtering is also possible for the extended
network map but due to timing issues it is not discussed in this document.

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
            JSONString          direction;
        } LinkDesc;

If the "type" field in the capabilities is "end-to-end", there MUST be no
"links" field in the data component and no "internal" field in any node
description.  At the same time, ALTO clients MUST ignore these fields if they
are mistakenly provided.

If the "type" field in the capabilities is "topological", the "links" field and
the "internal" field MUST be provided.

The "direction" field indicates the allowed direction of traffic.  The optional
values are "both", "ltr" and "rtl".  If the value is not "both", the pid MUST be
sorted to represent the correct direction where "ltr" indicates the direction of
pid\_0 --> pid\_1 while "rtl" indicates pid\_0 <-- pid\_0.

<!-- ]]] -->

#### Example
<!-- [[[ -->

[](#fig:example-topology) demonstrates a simple topology.

<!-- figure: example topology [[[ -->

    +-----------+                          +-----------+
    |  Node #1  |----\                     |  Node #4  |
    +-----------+     |                    +-----------+
       |              |                     |
       |              |                    /
       \              |                   /
        \       +-----------+      +-----------+
         -------|  Node #3  |______|  node #6  |
                +-----------+      +-----------+
                   |                      |
                  /                        \
                 /                          \
    +-----------+                           +-----------+
    |  Node #2  |                           |  Node #5  |
    +-----------+                           +-----------+
^[fig:example-topology::Example Topology]

The example request and the corresponding response for the extended network map
based on this topology is given below.

<!-- request [[[ -->

        GET /extnetworkmap HTTP/1.1
        Host: alto.example.org
        Accept: application/alto-extnetworkmap+json,
                application/alto-error+json

<!-- ]]] -->

<!-- response [[[ -->

        HTTP/1.1 200 OK
        Content-Length: 1078
        Content-type: application/alto-extnetworkmap+json

        {
          "meta" : {
            "vtag": {
              "resource-id": "extended-network-map-example",
              "tag": "67e6183c00fe467a960f174b93f23cf7"
            }
          },
          "extended-network-map": {
            "nodes": {
              "node#1": {
                "internal": "false",
                "ipv4": [ "192.168.1.0/28" ]
              },
              "node#2": {
                "internal": "false",
                "ipv4": [ "192.168.1.128/28" ]
              },
              "node#3": {
                "internal": "true"
              },
              "node#4": {
                "internal": "false",
                "ipv4": [ "192.168.2.0/28" ]
              },
              "node#5": {
                "internal": "false",
                "ipv4": [ "192.168.2.128/28" ]
              },
              "node#6": {
                "internal": "true"
              }
            },
            "links": {
              "link#1": {
                "pid": ["node#1", "node#3"]
              },
              "link#2": {
                "pid": ["node#1", "node#3"]
              },
              "link#3": {
                "pid": ["node#2", "node#3"]
              },
              "link#4": {
                "pid": ["node#4", "node#6"]
              },
              "link#5": {
                "pid": ["node#5", "node#6"]
              },
              "link#6": {
                "pid": ["node#3", "node#6"]
              }
            }
          }
        }
<!-- ]]] -->

<!-- ]]] -->


<!-- ]]] -->

<!-- ]]] -->

## Information Map
<!-- [[[ -->

The information map has many similarities with the cost map.  Instead of
providing only the "cost" between endpoints, it is extended to publish generic
network information for both endpoint/node pairs and links.  It is notable that
there are no distinction between attributes and statistics, where the former
represent the essence and configurations of the object that should seldom change
while the latter represent the dynamic running state of a network.  However, an
ALTO server can provide such indications in the corresponding information
specifications.

Due to timing issues, the filtering on the information map is not described in
this document but it is worthy pointing out that the filtered information map is
quite essential to enhance the performance of fetching data for the interested
nodes or links.

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

#### Example { #infomap-example }
<!-- [[[ -->

The example of getting the hop counts between nodes, link cost and the link
capacities is given below, using the topology in [](#fig:example-topology).

<!-- request  [[[ -->

        GET /example-infomap HTTP/1.1
        Host: alto.example.org
        Accept: application/alto-infomap+json,
                application/alto-error+json

<!-- ]]] -->

<!-- response [[[ -->

        HTTP/1.1 200 OK
        Content-Length: 1434
        Content-type: application/alto-infomap+json

        {
          "meta": {
            "vtag": {
              "resource-id": "infomap-example",
              "tag": "e7822fdd03814561bdb955667ca06534"
            },
            "dependent-vtags": [
              {
                "resource-id": "extended-network-map-example",
                "tag": "67e6183c00fe467a960f174b93f23cf7"
              }
            ],
            "path-hop-count-cost": {
              "type": "path",
              "mode": "numerical",
              "metric": "hopcount"
            },
            "link-cost": {
                "type": "link",
                "mode": "numerical",
                "metric": "routingcost"
            },
            "link-capacity": {
              "type": "link",
              "format": "text"
            }
          },
          "information-map": {
            "path-hop-count-cost": {
              "node#1": {
                "node#1": 0, "node#2": 2, "node#3": 1,
                "node#4": 3, "node#5": 3, "node#6": 2
              },
              "node#2": {
                "node#1": 2, "node#2": 0, "node#3": 1,
                "node#4": 3, "node#5": 3, "node#6": 2
              },
              "node#3": {
                "node#1": 1, "node#2": 1, "node#3": 0,
                "node#4": 2, "node#5": 2, "node#6": 1
              },
              "node#4": {
                "node#1": 3, "node#2": 3, "node#3": 2,
                "node#4": 0, "node#5": 2, "node#6": 1
              },
              "node#5": {
                "node#1": 3, "node#2": 3, "node#3": 2,
                "node#4": 2, "node#5": 0, "node#6": 1
              },
              "node#6": {
                "node#1": 2, "node#2": 2, "node#3": 1,
                "node#4": 1, "node#5": 1, "node#6": 0
              }
            },
            "link-cost": {
                "link#1": 2,
                "link#2": 1,
                "link#3": 1,
                "link#4": 1,
                "link#5": 1,
                "link#6": 1
            },
            "link-capacity": {
              "link#1": "10Gbps",
              "link#2": "5Gbps",
              "link#3": "10Gbps",
              "link#4": "10Gbps",
              "link#5": "10Gbps",
              "link#6": "20Gbps"
            }
          }
        }

<!-- ]]] -->

<!-- ]]] -->

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

The resource ID of the network map, information map or the extended network map
based on which the endpoint information service will be defined.

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

The data component of an endpoint information service is named "endpoint-information",
which is a JSON object of type InfoMapData, where:

        object {
            InfoMapData         endpoint-information;
        } InfoResourceInfoMap : ResponseEntityBase;

<!-- -->

        object-map {
            PropertyName -> PropertyMapData;
        } InfoMapData;

<!-- -->

        object-map {
            TypedNodeAddr -> { TypedNodeAddr -> JSONValue };
        } PathPropertyData : PropertyMapData;

<!-- ]]] -->

<!-- ]]] -->

#### Example
<!-- [[[ -->

The example of getting the routing cost is given below, using the same topology
and routing cost information as in [](#infomap-example).

<!-- request [[[ -->

        POST /eis-example HTTP/1.1
        Host: alto.example.org
        Content-Length: 329
        Content-type: application/alto-endpointinfoparam+json
        Accept: application/alto-endpointinfo+json,
                application/alto-error+json


        {
          "endpoints": {
              "srcs": [ "ipv4:192.168.1.12", "node:node#1" ],
              "dsts": [
                "ipv4:192.168.1.13",
                "ipv4:192.168.2.34",
                "node:node#2"
              ]
          },
          "path-routingcost": {
            "type": "path",
            "mode": "numerical",
            "metric": "routingcost"
          },
          "constraints": ["link-capacity > 8Gbps"]
        }

<!-- ]]] -->

<!-- response [[[ -->

        HTTP/1.1 200 OK
        Content-length: 601
        Content-type: application/alto-endpointinfo+json

<!-- -->

        {
          "meta": {
            "vtag": {
              "resource-id": "eis-example",
              "tag": "5ffb08265da64136a13978055f3affb6"
            },
            "dependent-vtags": [
              {
                "resource-id": "extended-network-map-example",
                "tag": "67e6183c00fe467a960f174b93f23cf7"
              },
              {
                "resource-id": "infomap-example",
                "tag": "e7822fdd03814561bdb955667ca06534"
              }
            ]
          },

<!-- -->

          "endpoint-information": {
            "path-cost": {
              "ipv4:192.168.1.12": {
                "ipv4:192.168.1.13": 0,
                "ipv4:192.168.2.34": 4
              },
              "node:node#1": {
                "node:node#2": 3
              }
            }
          }
        }

<!-- ]]] -->

It can be seen from the request that with the constraint of "link-capacity >
8Gbps", link#2 is filtered so the routing cost between node#1 and node#4 is 4
instead of 3.

It is notable that the endpoint information is only provided between endpoints
with the same address type.

<!-- ]]] -->

<!-- ]]] -->

<!-- ]]] -->

# Future Improvement
<!-- [[[ -->

In this document three new ALTO services are introduced, however, they only
serve as basic functionalities to distribute information.  In this section we
discuss some advanced topics about the extensions.

## Deriving ALTO Services from the Extensions
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
information sources, whether they are ALTO servers, ALTO clients or third-party
agents, can push the data to the server.

The Internet Draft [](#I-D.ietf-alto-incr-update-sse), which uses Server-Sent
Events (SSE) to push incremental updates to the ALTO clients, can also be used
as a passive data collection method.  Both methods can transport partial data to
the aggregator ALTO server, however, the information sources using the
"aggregation" service don't have to launch an ALTO server instance, thus this
approach allows more lightweight publishers and can apply in more general
scenarios.

A comparison between the methods mentioned above is listed in
[](#mode-comparison-tbl).  In "Ext-ALTO with SSE" and "Ext-ALTO", the aggregator
ALTO server acts as a client to the publisher ALTO servers which provide the
extended ALTO services introduced in this document with and without the SSE
mechanism respectively.  In "ALTO Aggregation", the aggregator ALTO server is
providing the "aggregation" service and there is no demand on the publisher
other than following the protocol.

<!-- comparison between Ext-ALTO/Ext-ALTO-SSE/Aggregation [[[ -->

Description        Aggregator     Publisher    Partial Data
--------------     -------------- ------------ ------------
Ext-ALTO           ALTO Server    ALTO Server  No
                   Active         Passive
Ext-ALTO with SSE  ALTO Server    ALTO Server  Yes
                   Active         Active
ALTO Aggregation   ALTO Server    Any          Yes
                   Passive        Active
---------------------------------------------------------------------
^[mode-comparison-tbl::Comparison between Different Ways to Collect Data]

<!-- ]]] -->


<!-- ]]] -->

## Scope for Extended ALTO Services
<!-- [[[ -->

With the approaches in [](#alto-info-protocol) and the ones discussed in
sections above, we represent how ALTO protocol can be used in distributing
network information to the application in [](#fig:alto-scenario) where the
normal paths represent ALTO protocol and the starred path represents some
private protocol.

<!-- [[[ -->


           +---------------------+               +--------------------+
           |                     |       ********+                    |
           |                     |       *       | Private            |
           |                     v       v       | Information Source |
           |                  +--+-------+--+    |                    |
    +------+------+           |             |    +--------------------+
    |             +<----------+ Generic     |
    | ALTO Client |           | ALTO Server |           +-------------+
    |             |  +--------+             +<----------+             |
    +-------------+  |        +--+----------+           | Third-Party |
                     |           ^                      | Aggregator  |
                     v           |     +-------------+  |             |
           +---------+---+       +-----+             |  +-------------+
           |             |             | Customized  |
           | ALTO Client |             | ALTO Server |
           |             +<------------+             |
           +-------------+             +-------------+
^[fig:alto-scenario::AN ALTO Deployment Scenario]

<!-- ]]] -->

<!-- ]]] -->

## The Regulation of Property Specifications
<!-- [[[ -->

In the specifications for the information map and endpoint information service,
the information to be published is identified by so-called property
specifications.  However, there are no standard designating the specification of
other properties.  Even though the specification for "cost-type" proposed in
[](#RFC7285) can be seen as an example, it can still lead to confusions if two
ALTO servers happen to use the same mode-metric combination but use different
measure units.

Just like the cost types in [](#RFC7285), a registry for the information
specification used by the information map and the endpoint information service
SHOULD be created and maintained by IANA in the future.  To get started, future
proposals SHOULD designate some initial values by providing the specifications
for some commonly used information, such as link capacities, available
bandwidth, etc.

Another approach is to design a management system where new specifications can
be validated and registered with an "exp:" prefix indicating they are
experimental properties, before they are standardized.

## Fetching Filtered Topological Information
<!-- [[[ -->

One way to fetch filtered topological information, as the name suggests, is to
use the filtered information map, which has not been specified in this document
yet but its basic idea applies: filter the information map by returning only the
requested data of the requested nodes/links.

Another approach can be achieved in the following way: First make use of a
special type of TypedNodeAddr, the "NodeName", to identify the targeted nodes,
and then implement an endpoint information service that returns the links
between two requested nodes with all the requested data attached.  This
particular service can be useful to merge the given sequence of links to a
single "virtual" link, which may help reduce the size of network view and
encapsulate details of the original topology.

<!-- ]]] -->

<!-- ]]] -->

<!-- ]]] -->


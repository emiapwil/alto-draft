
# ALTO Servers and Information Sources { #alto-info-sources }
This section introduces the concept of "information sources" and discusses the
possible relationships between an ALTO server and an information source.
Furthermore, a protocol is proposed for the communication between server
implementations with certain internal structures and the corresponding
information sources.

<!-- [[[ -->

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

## Protocol Design { #alto-info-protocol }
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

### Internal Structures of ALTO Implementations
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

### Overview of Extended ALTO Specification
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

### Extended Network Map
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
        } ExtNetowkrMapCapabilities;

with fields:

- type: the type of information that is published.  Currently the only valid
  options are "end-to-end" and "topological".

<!-- ]]] -->

#### Uses
<!-- [[[ -->

None.

<!-- ]]] -->

#### Response
<!-- [[[ -->

The "meta" field of the response is the same as of network map responses.

The data component of an extended network map service is named
"extended-network-map", which is a JSON object of type ExtNetworkMapData, where

        object {
            ExtNetworkMapData   extended-network-map;
        } InfoResourceExtNetworkMap : ResponseEntityBase;

        object {
            EndpointData        endpoints;
            LinkData            links<0..1>;
        } ExtNetworkMapData;

        object-map {
            PIDName -> EndpointAddrGroup;
        } EndpointData;

        object-map {
            LINKName -> LinkDesc;
        } LinkData;

        object {
            JSONString          pid<2..2>;
        } LinkDesc;

If the "type" field in the capabilities is "end-to-end", there MUST be no
"links" field in the data component and ALTO clients MUST ignore the field if it
is mistakenly provided.

If the "type" field in the capabilities is "topological", the "links" field MUST
be provided.

<!-- ]]] -->

#### Example

<!-- ]]] -->

### Information Map
<!-- [[[ -->
<!-- ]]] -->

### Endpoint Information Service { #endpoint-info-service }

### Media Types of Extended Services { #media-types }
<!-- [[[ -->


<!-- ]]] -->


<!-- Network Statistics Collection [[[ -->
<!-- ]]] -->

<!-- ]]] -->

# IRD Extensions
<!-- [[[ -->

Unlike other ALTO services defined in [](#RFC7285), whose communications with
information sources can vary, the Information Resource Directory (IRD) service
is relatively simple and well-defined.  In this section we introduce several
extensions on this particular ALTO service, including:

- Management;
- Filtering on IRD entries;
- New specifications of capabilities that are useful in real-world deployment.

<!-- ]]] -->

## Entry Management

Interfaces for registration/unregistration.

## Filtered IRD

Motivation:

- Performance
- Automation

## Multi-homing

## Redistribution

<!-- ]]] -->

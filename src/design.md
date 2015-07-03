
# ALTO Servers and Information Sources
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

The capabilities of an information source determine what information can be
provided and are determined by the type of the information source and the
limitation of the targeted network, both of which can vary significantly.

<!-- ]]] -->

<!-- ]]] -->

## Protocol Design { #alto-sc-protocol }
<!-- [[[ -->
<!-- ]]] -->

<!-- ]]] -->

# IRD Extensions
<!-- [[[ -->

The main functionality of an IRD is to organize the backends.

## Message Format
## Access Control of Properties
## Filtered IRD
## Multi-homing

<!-- ]]] -->


# ALTO Servers and Information Sources

This section introduces the concept of "information sources" and discusses the
possible relationships between an ALTO server and an information source.
Furthermore, a protocol is proposed for the communication between server
implementations with certain internal structures and the corresponding
information sources.

<!-- [[[ -->

## Information Sources

### The Concept of Information Sources
<!-- what are information sources [[[ -->

An "information source" can be roughly described as any entity that is capable
of providing information on the network but the exact meaning depends on the
server implementation.  For example, a SDN controller that provides topology
views is an information source, P2P clients submitting the statistics of a
connection and even another ALTO server can also be regarded as information
sources.  In this document we identify three major kinds of information sources.

- Configurations


- End-to-End Statistics

- Network Operating Systems

<!-- ]]] -->

### The Relationship between ALTO Servers and Information Sources

<!-- Motivation: the fact that there are different sources [[[ -->

Extracting information out of the network has been a widely-studied research
topic.  Due to financial, technical and security reasons it is hard to fetch the
required data directly from ISPs, thus many efforts have been made to measure
different metrics using endpoint-based tools.  Since most of these tools require
little support from the network infrastructure, lots of them can still work even
if the Internet architecture evolves.  These measurement techniques can be
valuable sources to ALTO services as the measured results often reflect the
actual performance of the network.

At the same time, Software-Defined Networking makes it much easier for ALTO
service providers to gather information with the centralized programming
paradigm and the global view.  However, there have been plenty of SDN
controller implementations ever since the very first [](#NOX) system.  These
controllers are implemented in different programming languages such as C/C++,
Java and Python, and have different data structures to store the network
information.  Even though RESTful APIs are provided by most controllers, the
formats still varies and different ALTO instances may be interested in different
information.  For example, most cost maps only require the topology view but a
QoS-first cost map also needs bandwidth statistics.

<!-- TODO at least two examples of different topology presentations -->

<!-- ]]] -->

## Proposed Protocol { #alto-sc-protocol }

<!-- ]]] -->

<!-- Motivation: the need to reuse and aggregate meta information [[[ -->



<!-- ]]] -->

<!-- Motivation: reusable functionalities [[[ -->

It is also obvious that requests for maps generated from different sources still
share some common routines related to the ALTO protocol and other basic
functionalities.

<!-- ]]] -->


<!-- ]]] -->


<!-- [[[ -->

## Frontend and Backend

Similar to the service model in [](#fig:alto-service-model), the ALTO server

<!-- ]]] -->

# Framework Design
## Backend Management
<!-- [[[ -->

### Message Format

<!-- ]]] -->

## IRD Extensions
<!-- [[[ -->

The main functionality of an IRD is to organize the backends.

### Message Format
### Access Control of Properties
### Filtered IRD
### Multi-homing

<!-- ]]] -->

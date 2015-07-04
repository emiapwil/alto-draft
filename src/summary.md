
The basic functionalities of an ALTO server are:

- Collecting data from the information sources;
- Publishing the information to clients (using ALTO protocol).

While the latter is well-defined in RFC 7285, there are no standards for the
communication between an ALTO server and information sources.  I think there are
three scenarios:

- The ALTO server is deeply embedded into the information source, just like what
  we are trying to do in Open Daylight.

- The ALTO server is partially embedded into the information source.  For
  example, in the early stage of out implementation in ODL, we used an external
  server which pulls data from ODL using RESTCONF and converts them into
  RFC7285-compatible formats.

- The ALTO server is decoupled from the information source.

It is for the last scenario that a standard protocol might be helpful.  To get
started, I can think of two basic and probably most common implementation
choices, and they both can have multiple different information sources:

- End-to-End:
  The server builds its maps using a full-mesh internal representation.  This
  can happen if the server is using end-to-end measurement methods or it just
  doesn't have the priority to fetch topology information.

- Topology-based:
  In this case the server is using a graph representation and there can be some
  internal nodes besides endpoints.  A server can fetch topology view directly,
  either from configurations or by making a query to a SDN controller.  Also one
  can use aggregated data such as the inferred AS graph.

Accordingly we can identify the following kinds of information for both implementation
choices:

- Connection-based statistics;
- Link-based statistics;
- (?) Node-based statistics.

All three statistics can be encapsulated using the following JSON representation:

    {
        /* the type of the statistics */
        'type': 'alto-IS-e2e',
        /* choices: alto-IS-e2e, alto-IS-link, alto-IS-node, etc. */

        /* identity for the provider of the information */
        'source': 'grid-ftp-client:ef423dab',

        'data': [
            {
                'meta': {
                    /* e2e */
                    'src': 'ipv4:X.X.X.X',
                    'dst': 'ipv4:Y.Y.Y.Y',

                    /* link */
                    'id': 'e15',

                    /* node */
                    'id': 'n02'
                },
                'statistics': [
                    /* e2e */
                    'average-round-trip-time': '10ms',
                    'average-drop-rate-percentage': '5',
                    ...,

                    /* link */
                    'status': 'up',
                    'capacity': '10Gbps',
                    'available-bandwidth': '5Gbps',
                    ...,

                    /* node */
                    ...
                    /* actually I don't have any statistics for nodes in mind */
                ]
            },
            ...
        ]
    }

There are also considerations on push/pull modes, integration to IRD and
potential DDoS threats but I'd like to hear some feedback on the proposal from
you alto guys.

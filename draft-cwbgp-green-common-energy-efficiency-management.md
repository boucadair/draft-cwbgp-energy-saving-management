---
title: "A Common YANG Data Model for Energy Efficiency Network Management"
abbrev: "Energy Efficiency Management"
category: std

docname: draft-cwbgp-green-common-energy-efficiency-management-latest
submissiontype: IETF
number:
date:
consensus: true
v: 3
area: "Operations and Management"
workgroup: "GREEN"
keyword:
 - energy efficiency
 - energy saving
 - energy management

author:
 -
   fullname: Qiufang Ma
   organization:  Huawei
   country: China
   email: maqiufang1@huawei.com
 -
   fullname: Qin Wu
   organization: Huawei
   country: China
   email: bill.wu@huawei.com
 -
   fullname: Emile Stephan
   organization: Orange
   country: France
   email:  emile.stephan@orange.com
 -
   fullname: Oscar Gonzales de Dios
   organization: Telefonica I+D
   country: Spain
   email:  oscar.gonzalezdedios@telefonica.com
 -
   fullname: Carlos Pignataro
   organization: North Carolina State University
   country: United States of America
   email: cpignata@gmail.com
 -
   fullname: Sai Han
   organization: China Unicom
   country: China
   email: hans29@chinaunicom.cn

normative:

informative:


--- abstract

This document defines a common YANG module that is meant to be reused
by various energy efficiency-related modules such as energy saving
Network models, energy saving network inventory model and energy saving
device models.

--- middle

# Introduction

The IETF has specified YANG modules for energy efficiency Management,
e.g., Energy Saving Network models {{?I-D.cwbgp-green-energy-saving-management}},
Power Management Device Model {{?I-D.li-green-power}}.
Other relevant YANG data models are Network topologies Base Model {{?RFC8345}}
and Network Inventory Base Model {{?I-D.ietf-ivy-network-inventory-yang}}.
There are common data nodes and structures that
are present in all of these models or at least a subset of them.

This document defines a common YANG module that is meant to be reused
by various energy efficiency-related modules such as energy saving
Network models, energy saving network inventory model and energy saving
device models.

The "ietf-energy-efficiency-common" module includes a set of identities, types, and
groupings that are meant to be reused by other energy efficiency-related YANG
modules independently of their characteristics (e.g., variable, invariable) and the
type of the module (e.g., network model, device model), including
possible future revisions of existing models (e.g., the Network Topology
{{?RFC8345}} or the Network Inventory {{?I-D.ietf-ivy-network-inventory-yang}}).

## Notes to the RFC Editor

   > Note to the RFC Editor: This section is to be removed prior to publication.

   This document contains placeholder values that need to be replaced
   with finalized values at the time of publication.  This note
   summarizes all the substitutions that are needed.

   Please apply the following replacements:

   * XXXX --> the RFC number assigned to this I-D
   * 2024-01-23 --> the actual date of the publication of this document

# Conventions and Definitions

{::boilerplate bcp14-tagged}

   The terminology for describing YANG modules is defined in {{!RFC7950}}.
   The meanings of the symbols in the YANG tree diagrams are defined in
   {{?RFC8340}}.

   The reader may refer to {{?I-D.bclp-green-terminology}} for energy efficiency-related
   terms.

   This document inherits many terms from {{?RFC7326}} (e.g.,
   energy, power, energy management, energy monitoring).

# Description of the Energy Efficiency Common YANG Module

  The "ietf-energy-efficiency-common" module defines the following feature:

  * "energy-saving": Indicates support of energy efficiency network management.

  It also defines a set of identities, including the following:

  * "energy-saving-mode": Specifies the energy saving mode. Examples of supported
     energy saving modes are as follows:

    * "basic": The system will shut down idle modules and put them in a sleep mode.
    * "standard": The system extends basic energy saving mode with more advanced
      lossless energy saving features, e.g., power module schedule.
    * "deep": The system extends standard energy saving mode with more advanced
      system level energy saving features, e.g., board scheduling.

  * "energy-saving-method": Specifies the energy saving method. Examples of supported
    energy saving methods are as follows:

    * "zone-based-fan-speed-adjustment": The system collects information about the
       temperatures of the service boards in the chassis and the zones where the
       service boards reside. According to the current temperature and target
       temperature of each board, the system implements stepless speed adjustment in
       different zones.
    * "unused-high-speed-interface-shutdown": When detecting an unused high-speed
      interface, the system shuts down the interface to reduce power consumption
      of the interface circuits. When the interface needs to run service, the
      system will automatically wake up the interface and restore the interface
      to the normal working state.
    * "unused-port-shutdown": When detecting an unused user port, the system automatically
       or manually shuts down the interface circuits and optical module of the port
       to reduce port power consumption. When detecting that the port needs to run
       service, the system automatically enables the port and restores the port to the
       normal running state, without affecting application of the board.
    * "unused-board-shutdown": When detecting an unused board, the system automatically
       shuts down the power supply of the board, ensuring zero power consumption of an unused board.
       When detecting that the board needs to run service, the system automatically
       powers on the board and restores the board to the normalrunning state, without
       affecting application of the whole device.
    * "dynamic-frequency-adjustment": When detecting that a service board is carrying a small
       service load, the system automatically reduces the working frequency of the
       service processing module of the board while maintaining the service
       quality. In doing so, power consumption of the service processing module
       is reduced. When the service load of the board increases, the system
       automatically increases the working frequency of the service processing
       module to meet service needs.
    * "unused-channel-shutdown": When an unused channel is detected, the unused
      channel is closed. Dynamically open the channel when detecting that there
      are services on the channel.
    * "load-based-power-module-scheduling": Power modules intelligently schedule
      internal power supply based on the power load. When the power load decreases,
      some power supplies are automatically disabled. When the power load increases,
      the disabled power supplies are enabled again.
    * "load-based-board-scheduling": Boards intelligently schedule internal forwarding resources
       based on the service load. When the service load decreases,
       some forwarding resources are automatically disabled or the
       working frequency of the forwarding resources is reduced.
       When the service load increases, the disabled forwarding
       resources are enabled again or the working frequency of
       forwarding resources is improved. In the case of burst
       traffic, packet forwarding may be delayed, but packets
       will not be lost.

  * "energy-saving-power-state": Specifies the energy saving power state. Examples
    of supported energy saving power state are as follows:

    * "off-state": The component typically requires a complete boot when awakened.
    * "sleep-state": The component with energy management support is not functional
      but immediately available such as wake up mechanism.
    * "low-power-state": Some components with energy management support are not
      available and these components can take measures to use less energy.
    * "full-power-state": All components with energy management support are
      available and may use maximum power.

  In addition, it defines the following types:

  * "energy-saving-operator": Indicates the type of energy saving operator. Either
    a power-on or a power-off is allowed to be specified.

  The "ietf-energy-efficiency-common" module also contains a set of resuable
  energy efficiency-related groupings. {{e-tree}} provides the tree diagram that
  depicts the common groupings for the "ietf-energy-efficiency-common" module.

~~~~
{::include-fold ./yang/trees/common-tree.txt}
~~~~
{: #e-tree title="Common Energy Saving Management Tree Structure"}

  The description of the common groupings are provided below:

  "energy-consumption-data":
  : A YANG grouping that defines a set of parameters for common power consumption.

  "energy-saving-modes":
  : A YANG grouping that defines a list for energy saving mode and methods.

  "power-parameters":
  : A YANG grouping that defines a set of rated parameters, e.g., temperature, and volts.

  "energy-power-consumption-stats":
  : A YANG grouping that defines a set of parameters for energy and power monitoring.

# Common Energy Saving Management YANG Module {#sec-common}

The module imports types defined in {{!RFC6991}}.

~~~~ yang
<CODE BEGINS> file "ietf-energy-efficiency-common@2024-01-23.yang"
{::include-fold ./yang/ietf-energy-efficiency-common.yang}
<CODE ENDS>
~~~~

# Security Considerations

  This section is modeled after the template described in {{Section 3.7 of ?I-D.ietf-netmod-rfc8407bis}}.

   The "ietf-energy-efficiency-common" YANG module defines a data model that is
   designed to be accessed via YANG-based management protocols, such as
   NETCONF {{?RFC6241}} and RESTCONF {{?RFC8040}}. These protocols have to
   use a secure transport layer (e.g., SSH {{?RFC4252}}, TLS {{?RFC8446}}, and
   QUIC {{?RFC9000}}) and have to use mutual authentication.

   The Network Configuration Access Control Model (NACM) {{!RFC8341}}
   provides the means to restrict access for particular NETCONF or
   RESTCONF users to a preconfigured subset of all available NETCONF or
   RESTCONF protocol operations and content.

   The YANG module defines a set of identities, types, and
   groupings. These nodes are intended to be reused by other YANG
   modules. The module by itself does not expose any data nodes that
   are writable, data nodes that contain read-only state, or RPCs.
   As such, there are no additional security issues related to
   the YANG module that need to be considered.

   Modules that use the groupings that are defined in this document
   should identify the corresponding security considerations.

# IANA Considerations

## The "IETF XML" Registry

This document requests IANA to register the following URIs
in the "ns" sub-registry within the "IETF XML Registry" {{!RFC3688}}:

~~~~
   URI: urn:ietf:params:xml:ns:yang:ietf-energy-efficiency-common
   Registrant Contact: The IESG.
   XML: N/A, the requested URIs are XML namespaces.
~~~~

##  The "YANG Module Names" Registry

   This document requests IANA to register the following YANG modules
   in the "YANG Module Names" registry {{!RFC6020}} within
   the "YANG Parameters" registry group.

~~~~
   name: ietf-energy-saving-common
   prefix: esm-common
   namespace: urn:ietf:params:xml:ns:yang:ietf-energy-efficiency-common
   Maintained by IANA? N
   Reference: RFC XXXX
~~~~

--- back

# Acknowledgments
{:numbered="false"}

   This work has benefited from the discussions that occurred during the Sustainable
   Networking Side Meeting in IETF#117 and the "e-impact" IAB workshop. In
   particular, {{?I-D.cx-green-green-metrics}} assess several
   sustainability-related attributes such as power consumption, energy
   efficiency, and carbon footprint associated with a network, its
   equipment, and the services that are provided over it and suggest a
   set of metrics that provide network observability and can be used to
   optimize a network's "greenness". {{?I-D.manral-bmwg-power-usage}}
   and {{?I-D.cprjgf-bmwg-powerbench}}
   provide suggestions for measuring power usage of live networks under
   different traffic loads and various switch router configuration
   settings.

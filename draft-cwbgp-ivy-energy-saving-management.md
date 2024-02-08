---
title: "A YANG Data Model for Energy Saving Management"
abbrev: "Energy Saving Management"
category: std

docname: draft-cwbgp-ivy-energy-saving-management-latest
submissiontype: IETF
number:
date:
consensus: true
v: 3
area: "Operations and Management"
workgroup: "Network Inventory YANG"
keyword:
 - xxx
 - xxx
 - xxxx

author:
 -
   fullname: Gen Chen
   organization:  Huawei
   country: China
   email: chengen@huawei.com
 -
   fullname: Qin Wu
   organization: Huawei
   country: China
   email: bill.wu@huawei.com
 -
   fullname: Mohamed Boucadair
   organization: Orange
   country: France
   email:  mohamed.boucadair@orange.com
 -
   fullname: Oscar Gonzales de Dios
   organization: Telefonica I+D
   country: Spain
   email:  oscar.gonzalezdedios@telefonica.com
 -
   fullname: Carlos Pignataro
   organization: North Carolina State University
   country: United States of America
   email: cpignata@gmail.com, cmpignat@ncsu.edu


normative:

informative:


--- abstract

   This document defines a YANG module for power and energy management
   of devices.


--- middle

# Introduction

   With the growth of networks and the increase of awareness about the
   environmental impact, it is important to ensure energy efficiency in
   the operation of network infrastructure.  Operators are thus seeking
   for more information to reflect the power consumption of a network
   and the contribution of involved nodes.  However, there are no
   standard mechanisms to report and control power usage of different
   networking equipment under different network configuration and
   conditions.  For example, in 'tidal network' in which traffic volume
   undergoes significant fluctuations at different times, various energy
   management methods might be envisaged to optimize the energy
   efficiency at the network scale, e.g., by selectively disabling ports
   or cards on specific network nodes based on (forecast) traffic
   patterns.

   This document defines a YANG data model for use in energy management
   of network devices.  Such model can be used for monitoring the energy
   consumption of network devices, such as (but are not limited to)
   routers, switches, security gateways, hosts, or servers.  Where
   applicable, device monitoring extends to the individual components of
   the device.

# Conventions and Definitions

{::boilerplate bcp14-tagged}

   The meanings of the symbols in the YANG tree diagrams are defined in
   {{?RFC8340}}.

   The following terms are used in the document:

   Network Inventory:
   :  A collection of data for network devices and
      their components managed by a specific management system
      {{!I-D.ietf-ivy-network-inventory-yang}}.

   Chassis:
   :  A physical container that allows installation of power
      modules, fan modules, and various types of boards and cards
      {{!I-D.ietf-ivy-network-inventory-yang}}.

   Network Element:
   :  A manageable network entity that contains hardware
      and software units, e.g. a network device installed on one or
      several chassis {{!I-D.ietf-ivy-network-inventory-yang}}.

   Board and Card:
   : A pluggable equipment can be inserted into one or
      several slots/ sub-slots and can afford a specific transmission
      function independently {{!I-D.ietf-ivy-network-inventory-yang}}. The
      core modular units for processing data.  Depending on functions,
      they can be classified into Main Processing Unit (MPU), Switch
      Fabric Unit (SFU), Line Processing Unit (LPU), and other types.
      MPU is responsible for system control, management, and monitoring.
      SFU is responsible for line-rate data switching on the data plane.
      LPU is responsible for data packet processing and traffic
      management.

   Port and Interface:
   :  A port is a physical entity that is used for
      connections.  While an interface is a logical entity for
      connections.

# YANG Prefixes

   Names of data nodes and other data model objects are prefixed using
   the standard prefix associated with the corresponding YANG imported
   modules, as shown in {{pref}}.

| Prefix | YANG Module |  Reference   |
| ianahw | iana-hardware          | [IANA_YANG] |
| ni     | ietf-network-inventory | RFC IIII    |
{: #pref title="Prefixes and Corresponding YANG modules"}

> RFC Editor Note: Please replace IIII with the RFC number assigned to {{!I-D.ietf-ivy-network-inventory-yang}}.

# Energy Saving Management Data Model Overview

   As described in {{!I-D.ietf-network-inventory-yang}}, the Network
   Inventory YANG data model is used to maintain the base network
   inventory information.  This document defines the YANG module "ietf-
   energy-saving-management", which augments network element of the
   network Inventory base model with energy saving modes and also
   augments the component of the network inventory base model with
   energy consumption and energy saving attributes.

   At the network element level, the data model covers configuration of
   the energy saving mode and a set of related parameters to manage
   (e.g., retrieve, adjust) the status of power units, fans, boards,
   cards, ports, processors, and links.  For example, the adjustment
   methods include frequency tuning, shutdown, or sleep mode.  In
   addition, the methods also support the energy saving configuration
   for the 'tidal' traffic flow, where related components can be turned
   off, e.g., during "idle" hours to optimize the energy consumption and
   then woken up based on some triggered (e.g., busy hours or other
   scheduled events).

   The data model defines energy saving modes representing some energy
   consumption levels, which are basic, standard, deep, optimal and
   custom.  For each consumption level, there is a combination of
   methods to reach the energy saving target level.

   At the component level, the data model includes a set of monitoring
   statistics for energy consumption and also energy saving operator
   state of each component within the network device.

## Network Element Specific Information

   Network element specific attributes can be defined in the network
   element list node as shown in{{ne-tree}}.

~~~~
  augment /nw:networks/nw:network/nw:node:
    +--ro energy-power-consumption
    |  +--ro total-energy-consumption?   yang:gauge64
    |  +--ro saved-energy?               yang:gauge64
    |  +--ro eer?                        decimal64
    +--ro energy-saving-modes
       +--ro energy-saving-mode* [mode]
          +--ro mode       identityref
          +--ro methods
             +--ro method* [method-name]

  augment /ni:network-elements/ni:network-element:
    +--rw energy-management
       +--ro energy-monitoring-capability?   boolean
       +--ro energy-saving-modes
          +--ro energy-saving-mode* [mode]
             +--ro mode       identityref
             +--ro methods
                +--ro method* [method-name]
                   +--ro method-name    identityref

~~~~
{: #ne-tree title="Network Element Specific Energy Tree Structure"}


##  Component Specific Information

   Component-specific attributes can be defined under the component list
   node as shown in Figure 2.

~~~~
module: ietf-energy-saving-mgt
  +--rw component-energy-monitoring
     +--ro energy-consumption
     |  +--ro average-power?     yang:gauge64
     |  +--ro saved-power?       yang:gauge64
     |  +--ro current-power?     yang:gauge64
     |  +--ro current-volts?     int32
     |  +--ro current-amperes?   int32
     |  +--ro temperature?       int32
     +--rw energy-saving
     |  +--ro enabled?      boolean
     |  +--ro oper-state?   identityref
     +--ro inventory-component-ref?   -> /ni:network-elements/network-element/components/component/name

  augment /ni:network-elements/ni:network-element/ni:components/ni:component:
    +--ro temperature-upper-bound?    int32
    +--ro temperature-middle-bound?   int32
    +--ro temperature-lower-bound?    int32
    +--ro rated-power?                yang:gauge64
    +--ro expected-volts?             int32
    +--ro low-volts-bound?            int32
    +--ro low-volts-fatal?            int32
    +--ro high-volts-bound?           int32
    +--ro high-volts-fatal?           int32
~~~~
{: #cs-tree title="Component-Specifc Energy Tree Structure"}

#  Energy Saving Management Tree Diagram

  {{e-tree}} shows the tree diagram of the YANG data model defined in
   module "ietf-energy-saving-management" (Section 6).

~~~~
module: ietf-energy-saving-mgt
  +--rw component-energy-monitoring
     +--ro energy-consumption
     |  +--ro average-power?     yang:gauge64
     |  +--ro saved-power?       yang:gauge64
     |  +--ro current-power?     yang:gauge64
     |  +--ro current-volts?     int32
     |  +--ro current-amperes?   int32
     |  +--ro temperature?       int32
     +--ro energy-saving
     |  +--ro enabled?      boolean
     |  +--ro oper-state?   identityref
     +--ro inventory-component-ref?   -> /ni:network-elements/network-element/components/component/name

  augment /nw:networks/nw:network/nw:node:
    +--ro energy-power-consumption
    |  +--ro total-energy-consumption?   yang:gauge64
    |  +--ro saved-energy?               yang:gauge64
    |  +--ro eer?                        decimal64
    +--rw energy-saving-modes
       +--ro energy-saving-mode* [mode]
          +--rw mode       identityref
          +--rw methods
             +--rw method* [method-name]
                +--rw method-name    identityref
  augment /ni:network-elements/ni:network-element:
    +--rw energy-management
       +--ro energy-monitoring-capability?   boolean
       +--ro energy-saving-modes
          +--ro energy-saving-mode* [mode]
             +--ro mode       identityref
             +--ro methods
                +--ro method* [method-name]
                   +--ro method-name    identityref
  augment /ni:network-elements/ni:network-element/ni:components/ni:component:
    +--ro temperature-upper-bound?    int32
    +--ro temperature-middle-bound?   int32
    +--ro temperature-lower-bound?    int32
    +--ro rated-power?                yang:gauge64
    +--ro expected-volts?             int32
    +--ro low-volts-bound?            int32
    +--ro low-volts-fatal?            int32
    +--ro high-volts-bound?           int32
    +--ro high-volts-fatal?           int32

~~~~
{: #e-tree title="Energy Saving Management Tree Structure"}

# Energy Saving YANG Module

The module imports XXX and uses types defined in XXX.

~~~~ yang
<CODE BEGINS> file "ietf-energy-saving-mgt@2024-01-23.yang"
{::include-fold ./yang/ietf-energy-saving-mgt.yang}
<CODE ENDS>
~~~~

## Security Considerations

   The YANG modules specified in this document define a schema for data
   that is designed to be accessed via network management protocol such
   as NETCONF {{!RFC6241}} or RESTCONF {{!RFC8040}}.  The lowest NETCONF layer
   is the secure transport layer, and the mandatory-to-implement secure
   transport is Secure Shell (SSH) {{!RFC6242}}.  The lowest RESTCONF layer
   is HTTPS, and the mandatory-to-implement secure transport is TLS
   {{!RFC8446}}.

   The Network Configuration Access Control Model (NACM) {{!RFC8341}}
   provides the means to restrict access for particular NETCONF or
   RESTCONF users to a preconfigured subset of all available NETCONF or
   RESTCONF protocol operations and content.

   There are a number of data nodes defined in this YANG module that are
   writable/creatable/deletable (i.e., config true, which is the
   default).  These data nodes may be considered sensitive or vulnerable
   in some network environments.  Write operations (e.g., edit-config)
   to these data nodes without proper protection can have a negative
   effect on network operations.  These are the subtrees and data nodes
   and their sensitivity/vulnerability:

 /em:energy-management/em:energy-saving-mode:
 : This leaf specifies the energy saving mode set globally on a device.

 /em:energy-saving/em:enable:
 : This leaf enable/disables energy saving state of specific component.

   Some of the readable data nodes in this YANG module may be considered
   sensitive or vulnerable in some network environments.  It is thus
   important to control read access (e.g., via get, get-config, or
   notification) to these data nodes.  These are the subtrees and data
   nodes and their sensitivity/vulnerability:

   'TBC':
   : ....

# IANA Considerations

## The "IETF XML" Registry

   This document registers one XML namespace URN in the 'IETF XML
   registry', following the format defined in {{!RFC3688}}.

~~~~
   URI: urn:ietf:params:xml:ns:yang:ietf-energy-saving-mgt
   Registrant Contact: The IESG.
   XML: N/A, the requested URIs are XML namespaces.
~~~~

##  The "YANG Module Names" Registry

   This document registers one module name in the 'YANG Module Names'
   registry, defined in {{!RFC6020}}.

~~~~
   name: ietf-energy-saving-management
   prefix: em
   namespace: urn:ietf:params:xml:ns:yang:ietf-energy-saving-mgt
   Maintained by IANA? N
   Reference: RFC XXXX
~~~~

--- back

# Acknowledgments
{:numbered="false"}

   This work has benefited from the discussions of Sustainable
   Networking Side Meeting in IETF117 and e-impact IAB workshop.  In
   particular, {{?I-D.cx-opsawg-green-metrics}} assess a number of
   sustainability-related attributes such as power consumption, energy
   efficiency, and carbon footprint associated with a network, its
   equipment, and the services that are provided over it and suggest a
   set of metrics that provide network observability and can be used to
   optimize a network's "greenness" . {{?I-D.manral-bmwg-power-usage}}
   provides suggestions for measuring power usage of live networks under
   different traffic loads and various switch router configuration
   settings.

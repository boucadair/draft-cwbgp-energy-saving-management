---
title: "YANG Data Models for Energy Saving Management"
abbrev: "Energy Saving Management"
category: std

docname: draft-cwbgp-green-energy-saving-management-latest
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
   fullname: Gen Chen
   organization:  Huawei
   country: China
   email: chengen@huawei.com
 -
   fullname: Qin Wu
   role: editor
   organization: Huawei
   country: China
   email: bill.wu@huawei.com
 -
   fullname: Mohamed Boucadair
   role: editor
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
   email: cpignata@gmail.com

normative:

informative:


--- abstract

   This document defines YANG modules for energy saving management at both device and network levels. Also, the document specifies
   a common module that is used independent of the model layer.

--- middle

# Introduction

   With the growth of networks and the increase of awareness about the
   environmental impact, it is important to ensure energy efficiency in
   the operation of network infrastructures.  Operators are thus seeking
   for more information to reflect the power consumption of a network
   and the contribution of involved nodes.

   However, there are no standard mechanisms to report and control power
   usage or energy consumption of different networking equipment under
   different network configuration and conditions.  For example, in
   a 'Tidal network' in which traffic volume undergoes significant
   fluctuations at different times, various energy management methods
   might be envisaged to optimize the energy efficiency at the network
   scale, e.g., by selectively disabling ports or cards on specific network
   nodes based on (forecast) traffic patterns.

   This document defines YANG modules for use in energy management within a network.
   The modules cover both network and device levels ({{Section 3.5.1 of ?I-D.ietf-netmod-rfc8407bis}}).
   The modules can be used, e.g., for monitoring the energy
   consumption of network devices, such as (but are not limited to)
   routers, switches, security gateways, hosts, or servers.  Where
   applicable, device monitoring extends to the individual components of
   the device.

   The network model augments the "ietf-network" module {{!RFC8345}}, while the inventory model augments
   the "ietf-network-inventory" module {{!I-D.ietf-ivy-network-inventory-yang}} with the following rationale:

   * Parameters that reflect the saving modes and methods are considered
     as capabilities, and are thus maintained in the inventory.
   * Required parameters to monitor, control, and adjust nodes and components behaviors
     are added to the network topology as this allows operator to better assess
     the implications on node-specific action on the overall network.

The document leverages types defined in {{?RFC3418}} and {{?RFC6933}}.

## Notes to the RFC Editor

   > Note to the RFC Editor: This section is to be removed prior to publication.

   This document contains placeholder values that need to be replaced
   with finalized values at the time of publication.  This note
   summarizes all the substitutions that are needed.

   Please apply the following replacements:

   * XXXX --> the RFC number assigned to this I-D
   * IIII --> the RFC number assigned to {{!I-D.ietf-ivy-network-inventory-yang}}
   * 2024-01-23 --> the actual date of the publication of this document

# Conventions and Definitions

{::boilerplate bcp14-tagged}

   The meanings of the symbols in the YANG tree diagrams are defined in
   {{?RFC8340}}.

   The document uses the terms defined in {{?I-D.bclp-green-terminology}} and {{?I-D.ietf-ivy-network-inventory-yang}}.

# YANG Prefixes

   Names of data nodes and other data model objects are prefixed using
   the standard prefix associated with the corresponding YANG imported
   modules, as shown in {{pref}}.

| Prefix | YANG Module |  Reference   |
| ianahw | iana-hardware          | [IANA_YANG] |
| ni     | ietf-network-inventory | {{!I-D.ietf-ivy-network-inventory-yang}}    |
| yang   | ietf-yang-types | {{!RFC6991}}    |
{: #pref title="Prefixes and Corresponding YANG modules"}


# Energy Saving Management Data Model Overview

## Overview

   As described in {{!I-D.ietf-ivy-network-inventory-yang}}, the Network
   Inventory YANG data model is used to maintain the base network
   inventory information.  This document defines the YANG module "ietf-ni-energy-saving",
   which augments network element of the
   network Inventory base model with energy saving modes, associated
   energy saving methods and augments the component of the network
   inventory base model with capability related power attributes.

   "ietf-ntw-energy-saving" augments the node of abstract
   network model defined in {{!RFC8345}} with energy consumption and
   power usage related attributes. At the network element level, the data model covers configuration of
   the energy saving mode and a set of related parameters to manage
   (e.g., retrieve or adjust) the status of power units, fans, boards,
   cards, ports, processors, and links.  For example, the adjustment
   methods include frequency tuning, shutdown, or sleep mode.  In
   addition, the methods also support the energy saving configuration
   for the 'tidal' traffic flow, where related components can be turned
   off, e.g., during "idle" hours to optimize the energy consumption and
   then woken up based on some triggered (e.g., busy hours or other
   scheduled events).

   The data model defines energy saving modes representing some energy
   consumption levels, which are basic, standard, or deep.  For each
   consumption level, there is a combination of methods to reach the energy
   saving target level.

   At the component level, the data model includes a set of monitoring
   statistics for energy consumption and energy saving operational
   state of each component within the network device. It also includes threshold
   related power parameters such as rated power, expected volts.

   In order to ease reuse of various parameters independent of the module layer,
   this document also defines a common model: "ietf-energy-saving-common".

The structure of each module is provided in the following subsections.

##  Common Energy Saving Management Module Structure

  {{e-tree}} shows the tree diagram of the YANG data model defined in {{sec-module}}.

~~~~
{::include-fold ./yang/trees/common-tree.txt}
~~~~
{: #e-tree title="Common Energy Saving Management Tree Structure"}

## Energy Saving Management Network Model

   The structure of the ESM Network Model is depicted in {{ne-tree}}.

~~~~
{::include-fold ./yang/trees/esm-ntw-tree.txt}
~~~~
{: #ne-tree title="ESM Network Model Tree Structure"}

##  ESM Inventory Model

   The structure of the ESM Network Inventory Model is depicted in {{cs-tree}}.

~~~~
{::include-fold ./yang/trees/esm-ni-tree.txt}
~~~~
{: #cs-tree title="ESM Inventory Model Tree Structure"}

# YANG Modules {#sec-module}

## Common Module {#sec-common}

The module imports types defined in {{!RFC6991}}.

~~~~ yang
<CODE BEGINS> file "ietf-energy-saving-common@2024-01-23.yang"
{::include-fold ./yang/ietf-energy-saving-common.yang}
<CODE ENDS>
~~~~

## Network Module {#sec-ntw}

The module imports "ietf-network" {{!RFC8345}} and "ietf-energy-saving-common".

~~~~ yang
<CODE BEGINS> file "ietf-ntw-energy-saving@2024-01-23.yang"
{::include-fold ./yang/ietf-ntw-energy-saving.yang}
<CODE ENDS>
~~~~

## Network Inventory Module {#sec-ni}

The module imports "ietf-network-inventory" {{!I-D.ietf-ivy-network-inventory-yang}} and "ietf-energy-saving-common".

~~~~ yang
<CODE BEGINS> file "ietf-ni-energy-saving@2024-01-23.yang"
{::include-fold ./yang/ietf-ni-energy-saving.yang}
<CODE ENDS>
~~~~

# Security Considerations

  This section uses the template described in Section 3.7 of {{?I-D.ietf-netmod-rfc8407bis}}.

   The YANG modules specified in this document define a schema for data
   that is designed to be accessed via network management protocol such
   as NETCONF {{!RFC6241}} or RESTCONF {{!RFC8040}}.These network management
   protocols are required to use a secure transport layer and mutual
   authentication, e.g., SSH {{?RFC6242}} without the "none" authentication
   option, Transport Layer Security (TLS) {{?RFC8446}} with mutual X.509
   authentication, and HTTPS with HTTP authentication ({{Section 11 of ?RFC9110}}).

   The Network Configuration Access Control Model (NACM) {{!RFC8341}}
   provides the means to restrict access for particular NETCONF or
   RESTCONF users to a preconfigured subset of all available NETCONF or
   RESTCONF protocol operations and content.

   There are several data nodes defined in this YANG module that are
   writable/creatable/deletable (i.e., config true, which is the
   default).  These data nodes may be considered sensitive or vulnerable
   in some network environments.  Write operations (e.g., edit-config)
   to these data nodes without proper protection can have a negative
   effect on network operations. Specifically, the following subtrees and data nodes have particular
sensitivities/vulnerabilities:

 energy-saving-modes:
 : This leaf specifies the energy saving mode set globally on a device.

 esm-ntw:energy-saving/esm-ntw:enabled:
 : This leaf enable/disables energy saving state of specific component.

   Some of the readable data nodes in this YANG module may be considered
   sensitive or vulnerable in some network environments.  It is thus
   important to control read access (e.g., via get, get-config, or
   notification) to these data nodes. Specifically, the following subtrees and data nodes have particular
sensitivities/vulnerabilities:

   'TBC':
   : ....

# IANA Considerations

## The "IETF XML" Registry

This document requests IANA to register the following URIs
in the "ns" sub-registry within the "IETF XML Registry" {{!RFC3688}}:

~~~~
   URI: urn:ietf:params:xml:ns:yang:ietf-energy-saving-common
   Registrant Contact: The IESG.
   XML: N/A, the requested URIs are XML namespaces.

   URI: urn:ietf:params:xml:ns:yang:ietf-ntw-energy-saving
   Registrant Contact: The IESG.
   XML: N/A, the requested URIs are XML namespaces.

   URI: urn:ietf:params:xml:ns:yang:ietf-ni-energy-saving
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
   namespace: urn:ietf:params:xml:ns:yang:ietf-energy-saving-common
   Maintained by IANA? N
   Reference: RFC XXXX

   name: ietf-ntw-energy-saving
   prefix: esm-ntw
   namespace: urn:ietf:params:xml:ns:yang:ietf-ntw-energy-saving
   Maintained by IANA? N
   Reference: RFC XXXX

   name: ietf-ni-energy-saving
   prefix: esm-ni
   namespace: urn:ietf:params:xml:ns:yang:ietf-ni-energy-saving
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

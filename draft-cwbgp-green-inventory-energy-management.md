---
title: "A Network Inventory Data Model for Energy Efficiency Management"
abbrev: "Inventory Energy Management"
category: std

docname: draft-cwbgp-green-inventory-energy-management-latest
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
 - network inventory

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
    fullname: Emile Stephan
    role: editor
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

As a complement to the YANG Network Topology Data Model for Energy Efficiency
Management, which is used for monitoring the dynamic energy consumption of network
devices, this document defines YANG Network Inventory Data Model for Energy
Efficiency Management that can be used for maintaining capability related energy
efficiency attributes. The model provides both network view and device view of
energy efficiency related inventory information.


--- middle

# Introduction

With the growth of networks and the increase of awareness about the environmental
impact, it is important to ensure energy efficiency in the operation of network
infrastructures. Operators are thus seeking for more information to reflect the
power consumption of a network and the contribution of involved nodes.

However, there are no standard mechanisms to report either capability related
energy efficiency attributes or dynamic power consumption of different networking
equipment under different network configuration and conditions.
{{?I-D.cwbgp-green-energy-saving-management}} defines YANG module which is used
for monitoring the dynamic energy consumption of network devices at both network
and device levels ({{Section 3.5.1 of ?I-D.ietf-netmod-rfc8407bis}}).

As a complement to the YANG Network Topology Data Model for Energy Efficiency
Management {{?I-D.cwbgp-green-energy-saving-management}}, this document defines
YANG Network Inventory Data Model for Energy Efficiency Management that can be
used for maintaining capability related energy efficiency attributes. The model
provides both network view and device view of energy efficiency related inventory
information.

 The inventory model augments the "ietf-network-inventory" module {{!I-D.ietf-ivy-network-inventory-yang}}
 with the following rationale:

   * Parameters that reflect the saving modes and methods are considered as
     capabilities, and are thus maintained in the inventory.

The document leverages types defined in {{!RFC3418}} and {{!RFC6933}}.

## Notes to the RFC Editor

   > Note to the RFC Editor: This section is to be removed prior to publication.

   This document contains placeholder values that need to be replaced
   with finalized values at the time of publication.  This note
   summarizes all the substitutions that are needed.

   Please apply the following replacements:

   * XXXX --> the RFC number assigned to this I-D
   * 2024-01-23 --> the actual date of the publication of this document

# Conventions and Definitions

{::comment}{::boilerplate bcp14-tagged}{:/comment}

   The meanings of the symbols in the YANG tree diagrams are defined in
   {{?RFC8340}}.

   The document uses the terms defined in {{?I-D.bclp-green-terminology}} and
   {{!I-D.ietf-ivy-network-inventory-yang}}.

# YANG Prefixes

    Names of data nodes and other data model objects are prefixed using
    the standard prefix associated with the corresponding YANG imported
    modules, as shown in {{pref}}.

   | Prefix | YANG Module |  Reference   |
   | ianahw | iana-hardware          | {{!RFC8348}} |
   | ni     | ietf-network-inventory | {{!I-D.ietf-ivy-network-inventory-yang}} |
   | yang   | ietf-yang-types | {{!RFC6991}} |
   {: #pref title="Prefixes and Corresponding YANG modules"}


# Energy Saving Management Data Model Overview

## Overview

As described in {{!I-D.ietf-ivy-network-inventory-yang}}, the Network Inventory
YANG data model is used to maintain the base network inventory information.
This document defines the YANG module "ietf-ni-energy-saving", which augments
network element of the network Inventory base model with energy saving modes,
associated energy saving methods and augments the component of the network
inventory base model with capability related power attributes.

The data model defines energy saving modes representing some energy consumption
levels, which are basic, standard, or deep. For each consumption level,
there is a combination of methods to reach the energy saving target level.

At the component level, the data model includes a set of threshold related power
parameters such as rated power, expected volts.

##  ESM Inventory Model

   The structure of the ESM Network Inventory Model is depicted in {{cs-tree}}.

~~~~
{::include-fold ./yang/trees/esm-ni-tree.txt}
~~~~
{: #cs-tree title="ESM Inventory Model Tree Structure"}

# Network Inventory Energy Saving YANG Module

The module imports "ietf-network-inventory" {{!I-D.ietf-ivy-network-inventory-yang}}
and "ietf-energy-saving-common".

~~~~ yang
<CODE BEGINS> file "ietf-ni-energy-saving@2024-01-23.yang"
{::include-fold ./yang/ietf-ni-energy-saving.yang}
<CODE ENDS>
~~~~


# Security Considerations

This section is modeled after the template described in {{Section 3.7 of ?I-D.ietf-netmod-rfc8407bis}}.

The "ietf-ni-energy-saving" YANG module defines a data model that is designed
to be accessed via YANG-based management protocols, such as NETCONF {{?RFC6241}}
and RESTCONF {{?RFC8040}}. These protocols have to use a secure transport layer
(e.g., SSH {{?RFC4252}}, TLS {{?RFC8446}}, and QUIC {{?RFC9000}}) and have to use
mutual authentication.

The Network Configuration Access Control Model (NACM) {{!RFC8341}} provides the means
to restrict access for  particular NETCONF or RESTCONF users to a preconfigured
subset of all available NETCONF or RESTCONF protocol operations and content.

Some of the readable data nodes in this YANG module may be considered
sensitive or vulnerable in some network environments.  It is thus
important to control read access (e.g., via get, get-config, or
notification) to these data nodes. Specifically, the following
subtrees and data nodes have particular sensitivities/
vulnerabilities:

   'TBC':
   : ....

# IANA Considerations

## The "IETF XML" Registry

This document requests IANA to register the following URIs
in the "ns" sub-registry within the "IETF XML Registry" {{!RFC3688}}:

~~~~
   URI: urn:ietf:params:xml:ns:yang:ietf-ni-energy-saving
   Registrant Contact: The IESG.
   XML: N/A, the requested URIs are XML namespaces.
~~~~

##  The "YANG Module Names" Registry

   This document requests IANA to register the following YANG modules
   in the "YANG Module Names" registry {{!RFC6020}} within
   the "YANG Parameters" registry group.

~~~~
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

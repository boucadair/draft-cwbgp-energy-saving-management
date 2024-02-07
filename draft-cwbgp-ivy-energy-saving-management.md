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
area: OPS
workgroup: WG Working Group
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

   As described in [I-D.ietf-network-inventory-yang], the Network
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
   element list node as shown in Figure 1.

~~~~
      augment /ni:network-elements/ni:network-element:
      +--rw energy-management
         +--ro energy-monitoring-capability?   boolean
         +--rw energy-saving-mode?             energy-saving-mode-name
         +--ro method-name?                    energy-saving-method-name
         +--ro eer?                            decimal64
~~~~

##  Component Specific Information

   Component-specific attributes can be defined under the component list
   node as shown in Figure 2.

~~~~
     augment /ni:network-elements/ni:network-element/ni:components/ni:component:
       +--ro energy-consumption
       |  +--ro total-energy-consumption?   uint64 <--- udpate the module
       |  +--ro saved-energy                unit64
       |  +--ro average-power?              gauge64 <--- udpate the module
       |  +--ro current-power?              gauge64
       |  +--ro saved-power?                int64
       |  +--ro rated-power?                int64
       |  +--ro instant-voltage?            int64
       |  +--ro instant-current?            int64 <--- what this about?
       |  +--ro temperature?                int32
       +--rw energy-saving
          +--rw enabled?      boolean
          +--ro oper-state?   energy-saving-oper-state
~~~~

#  Energy Saving Management Tree Diagram

   Figure 3 shows the tree diagram of the YANG data model defined in
   module "ietf-energy-saving-management" (Section 6).

~~~~
    module: ietf-energy-saving-management
     augment /ni:network-elements/ni:network-element:
     +--rw energy-management
        +--ro energy-monitoring-capability?   boolean
        +--rw energy-saving-mode?             energy-saving-mode-name
        +--ro method-name?                    energy-saving-method-name
        +--ro eer?                            decimal64

     augment /ni:network-elements/ni:network-element/ni:components/ni:component:
       +--ro energy-consumption
       |  +--ro total-energy-consumption?   uint32
       |  +--ro saved-power                 unint32
       |  +--ro average-power?              int32
       |  +--ro saved-power?                int32
       |  +--ro current-power?              int32
       |  +--ro rated-power?                int32
       |  +--ro instant-voltage?            int32
       |  +--ro instant-current             int32
       |  +--ro temperature?                int32
       +--rw energy-saving
          +--rw mode-enabled? boolean
          +--ro oper-state?   energy-saving-oper-state

           Figure 3: Energy Saving Management Tree Diagram
~~~~

# Energy Saving YANG Module


~~~~ yang
<CODE BEGINS> file "ietf-energy-saving-mgt@2024-01-23.yang"

module ietf-energy-saving-management {
  yang-version 1;
  namespace "urn:ietf:params:xml:ns:yang:ietf-energy-saving-mgt";
  prefix em;

  import ietf-network-inventory {
    prefix ni;
    reference
      "RFC IIII: A YANG Data Model for Network Inventory";
  }

  import iana-hardware {
    prefix ianahw;
     reference
      "https://www.iana.org/assignments/iana-hardware/iana-hardware.xhtml";
  }

  organization
    "IETF IVY Working Group.";
  contact
    "WG Web:   <https://datatracker.ietf.org/wg/opsawg/>;
     WG List:  <mailto:opsawg@ietf.org>
     Author:   Gen Chen  <mailto:chengen@huawei.com>
     Author:   Qin Wu <mailto:bill.wu@huawei.com>
     Author:   Mohamed Boucadair <mailto:mohamed.boucadair@huawei.com>";
  description
    "This module contains a collection of YANG definitions for power 
     and energy management of devices.";

  revision 2024-01-23 {
    description
      "Initial revision.";
    reference
      "RFC XXXX: A YANG Data Model for Energy Saving Management";
  }

  identity channel {
    base ianahw:hardware-class; 
    description 
      "This identity is applicable if the hardware class is some sort 
       of networking channel capable of receiving and/or transmitting 
       networking traffic."; 
  } 

  typedef energy-saving-mode-name { <=== Med: be defined as identities
    type enumeration {
      enum "basic" {
        value 1;
        description 
           "Basic energy saving mode. In this mode, the system 
            will shut down idle modules and put them in sleep mode.";
      }
      enum "standard" {
        value 2;
        description 
           "Standard energy saving mode. In this mode, the system 
            will extend basic energy saving model with more advanced  
            Lossless energy saving features, e.g., power module 
            schedule.";
      }
      enum "deep" {
        value 3;
        description "Deep energy saving mode.";
      }
    }
    description "Energy saving mode.";
  }

  typedef energy-saving-method-name { <=== Med: be defined as identities
    type enumeration {
      enum "zone-based-fan-speed-adjustment" {
        value 1;
        description "The system will collect information about the 
                    temperatures of the service boards in the chassis
                    and the zones where the service boards reside.
                    According to the current temperature and target 
                    temperature of each board, the system implements 
                    stepless speed adjustment in different zones.";
      }

      enum "unused-high-speed-interface-shutdown" {
        value 2;
        description "When detecting an unused high-speed interface, the 
                     system automatically or manually shuts down the 
                     interface to reduce power consumption of the interface 
                     circuits. When the interface needs to run service, the 
                     system will automatically wake up the interface and 
                     restore the interface to the normal working state.";
      }

      enum "unused-port-shutdown" {
        value 3;
        description "When detecting an unused user port, the system automatically 
                     or manually shuts down the interface circuits and optical 
                     module of the port to reduce port power consumption. When 
                     detecting that the port needs to run service, the system 
                     automatically enables the port and restores the port to the 
                     normal running state, without affecting application of the 
                     board.";
      }

      enum "unused-board-shutdown" {
        value 4;
        description "When detecting an unused board, the system automatically 
                     shuts down the power supply of the board,ensuring zero 
                     power consumption of an unused board. When detecting that 
                     the board needs to run service,the system automatically 
                     powers on the board and restores the board to the normal 
                     running state, without affecting application of the whole 
                     product.";
      }

      enum "dynamic-frequency-adjustment" {
        value 5;
        description "When detecting that a service board is carrying a small 
                     service load, the system automatically reduces the working 
                     frequency of the service processing module of the board
                     while maintaining the service quality. In this way, power 
                     consumption of the service processing module is reduced. 
                     When the service load of the board increases, the system 
                     automatically increases the working frequency of the service 
                     processing module to meet service needs.";
      }

      enum "unused-channel-shutdown" {
        value 6;
        description "When an unused channel is detected, the unused channel is 
                     closed. Dynamically open the channel when detecting that 
                     there are services on the channel.";
      }
      
      enum "intelligent-power-module-scheduling" {
        value 7;
        description "Power modules intelligently schedule internal power supply 
                     based on the power load. When the power load decreases, 
                     some power supply are automatically disabled. 
                     When the power load increases, the disabled power supply
                     are enabled again. ";
      }

      enum "intelligent-board-scheduling" {
        value 8;
        description "Boards intelligently schedule internal forwarding resources 
                     based on the service load. When the service load decreases, 
                     some forwarding resources are automatically disabled or the 
                     working frequency of the forwarding resources is reduced. 
                     When the service load increases, the disabled forwarding 
                     resources are enabled again or the working frequency of 
                     forwarding resources is improved. In the case of burst 
                     traffic, packet forwarding may be delayed, but packets 
                     will not be lost.";
      }
    }
    description "Energy saving methods.";
  }


  typedef energy-saving-oper-state { <=== Med: be defined as identities
    type enumeration {
      enum energy-saving-mode {
        value 1;
        description "Indicates that the device supports energy-saving mode.";
      }

      enum energy-none-saving-mode {
        value 2;
        description "Indicates that the device does not support energy-saving 
                    mode or does not have enough resources.";
      }

      enum energy-saving-deactivated {
        value 3;
        description "Indicates that the device in no energy-saving status.";
      }

      enum energy-saving-activated {
        value 4;
        description "Indicates that the device in energy-saving running status.";
      }
    }
    description "The device energy saving operator state.";
  }

  typedef energy-saving-operator {
    type enumeration {
      enum power-on {
        value 1;
        description "Power-on for energy saving.";
      }

      enum power-off {
        value 2;
        description "Power-off for energy saving.";
      }
    }
    description "Energy saving operator.";
  }

  grouping energy-consumption-data{
    leaf total-energy-consumption {
      type uint64;
      units "Wh";
      description
        "Accumulated energy consumption of equipment.";
    }
    leaf saved-energy {
      type uint64;
      units "Wh";
      description
        "Saved energy consumption of equipment.";
    }
    leaf average-power {
      type gauge64;
      units "mW";
      description
        "The average power of monitoring class.";
    }
    leaf saved-power {
      type int64;
      units "mW";
      description "The saved power of monitoring class.";
    }
    leaf current-power {
      type int32;
      units "mW";
      description "The current power of monitoring class.";
    }
    leaf rated-power {
      type int32;
      units "mW";
      description "The rated power of monitoring class.";
    }
    leaf instant-voltage {
      type int32;
      units "mV";
      description
        "The instant voltage of monitoring class.";
    }
    leaf instant-current {
      type int32;
      units "mA";
      description
        "The instant current of monitoring class.";
    } 
    leaf temperature {
      type int32;
      units "0.01 C";
      description "The temperature of the component.";
    }
    description
      "Statistics of the energy monitoring.";
  }
  augment "/ni:network-elements/ni:network-element" {
  container energy-management {
    description
      "Statistics of the energy management.";
      leaf energy-monitoring-capability {
        config false;
        type boolean;
        description
          "Indicates whether monitoring can be performed.";
      }
    leaf energy-saving-mode {
       type energy-saving-mode-name;
       description "The energy saving mode.";
    }

   leaf method-name {
       config false;
       type energy-saving-method-name;
       description "The energy saving method name.";
    }
   leaf eer {
       type decimal64 {
         fraction-digits 18;
       }
      units "Gbps/Watt";
      description "The energy efficiency rating (EER) is a metric 
      generally defined as a functional unit divided by the energy 
      used. Various types of equipment have their own EER definitions.";
   }
  }
 }

  augment "/ni:network-elements/ni:network-element/ni:components/ni:component"
   {
    description "Energy monitoring data for components.";

    container energy-consumption {
      config false;
      description
        "Statistics of component about energy monitoring.";
      uses energy-consumption-data;
    }

    container energy-saving {
      description "Configure : Statistics of component about 
                   energy monitoring.";
      leaf enabled {
        type boolean;
          default "true";
        description "Enable/disable : the energy-saving state 
                     of the component.";
      }

      leaf oper-state {
        type energy-saving-oper-state;
        config false;
        description "The device energy saving operator state.";
      }
    }
  }
}

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



# Impact Malaria Data Hub - Tech Specs 

[![Build Status](https://travis-ci.com/INyabuto/im-data-hub.svg?branch=master)](https://travis-ci.com/INyabuto/im-data-hub)

## Background

The Impact Maria (IM) Data Hub is a web-based project monitoring system used to collect, analyze, monitor and report IM indicator data. [__IMPACT Malaria__](https://imdpactmalaria.org) is a five year contract funded by the US President’s Malaria Initiative (PMI) to work with national malaria programs to fight malaria and save lives by strengthening diagnosis, treatment, and drug-based prevention for those most at risk, particularly children and pregnant women.

The [__IMPACT Malaria Data Hub__](https://imdatahub.org) is the IMPACT Malaria project monitoring system database for IM indicators. It is a web based database in a District Health Information Software 2 (DHIS2) instance and it houses all IM indicator data for project monitoring and use. It is primarily designed with data users in mind, and so its configuration comes with approaches specifically designed to enable monitoring and promote the use of IM data.

The IM Data Hub is used in IM countries in Africa and Asia and it collects a tremendous amount of data in the following tracks:

1.  Case Management
2.  Malaria in pregnancy 
3.  Seasonal Malaria Chemoprevention
4.  Global Technical Leadership.

It is used by multiple partners at different levels, from Ministries of Health (MoHs), National Malaria Control Programs (NMCPs), donors like the President's Malaria Initiative (PMI), implementers (PSI, Jhpiego, University of California San Francisco (UCSF)) to track project monitoring and performance.

### Purpose
The IM Data Hub was developed:

1. To monitor IM indicator data
2. Provide access to IM indicator data at district, country and global level
3. Enable central/global level data management
4. Track project progress and country performance 
5. Promote data use for decision making

### Servers
The IM Data Hub has two istances:

- A __development instance__ at [dev.imdatahub.org](https://dev.imdatahub.org) hosted on a ST-3 plan from BAO Systems since Nov 22nd, 2018 for prototyping, testing and piloting. Analytics run daily at 00:00 and 12:00 UTC (EAT -3h)
- A __production instance__ at [imdatahub.org](https://imdatahub.org) hosted on a ST-3 plan from BAO Systems since Nov 27th, 2019 for actual monitoring and reporting. Analytics run daily at 00:00 and 12:00 UTC (EAT -3h)

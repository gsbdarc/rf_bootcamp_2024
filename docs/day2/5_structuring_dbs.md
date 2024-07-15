---
title: 5. Structuring Complex Datasets
layout: page
nav_order: 5
parent: Day 2
updateDate: 2024-07-10
---

# {{ page.title }}
---

- As RFs, you will likely be tasked with processing raw data and constructing cleaned datasets for use in downstream analyses
- (For now) the most common data format used in the social sciences is the tabular data format, i.e. data structured as tables
- How you organize data into tables can have big implications for simplicity of your code and computational efficiency of analyses

- Suppose you are Zillow, and you’re building a comprehensive database of residential property characteristics and transactions
- You’ve convinced the property tax assessor’s office in every county in the US to send you their records on residential properties and their transactions 
- After harmonizing data formats across counties, you realize have the following information about every housing unit in the US:
    - Property county, address, and county-specific unique identifier
    - Property characteristics like lot/building square footage, # stories/bedrooms/bathrooms, etc.
    - Every transaction (date and price) of each property going back to 1996


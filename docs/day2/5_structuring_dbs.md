---
title: 5. Structuring Complex Datasets
layout: page
nav_order: 5
parent: Day 2
updateDate: 2024-07-10
---

# {{ page.title }}
---

## Structuring datasets

- As RFs, you will likely be tasked with processing raw data and constructing cleaned datasets for use in downstream analyses
- (For now) the most common data format used in the social sciences is the tabular data format, i.e. data structured as tables
- How you organize data into tables can have big implications for simplicity of your code and computational efficiency of analyses

- Suppose you are Zillow, and you’re building a comprehensive database of residential property characteristics and transactions
- You’ve convinced the property tax assessor’s office in every county in the US to send you their records on residential properties and their transactions 
- After harmonizing data formats across counties, you realize have the following information about every housing unit in the US:
    - Property county, address, and county-specific unique identifier
    - Property characteristics like lot/building square footage, # stories/bedrooms/bathrooms, etc.
    - Every transaction (date and price) of each property going back to 2000

### A first attempt at a data structure

- Below is an example of how one might first try structuring these data into a single table:

`property_transactions.csv`:

| county | id | address | sale_date | sale_price | lot_sq_ft | bldg_sq_ft | num_stories | num_bedrooms | num_bathrooms |

- The structure above is not a bad first pass, but there are several issues with it, including the following:
    - If a property is transacted multiple times, its characteristics are duplicated in multiple rows (inefficient storage)
    - How would you keep track of properties that have never transacted since 2000?
    - It’s annoying that it takes two columns (County and ID) to uniquely identify a property

### A better data structure

- Here's an alternative structure for these data that attempts to deal with these issues by separating the data into two separate files, one containing a list of all properties, and another just containing information pertinent to transactions:

`properties.csv`:

| uuid | address | lot_sq_ft | bldg_sq_ft | num_stories | num_bedrooms | num_bathrooms |

`transactions.csv`:

| uuid | sale_date | sale_price |

- `uuid` is a string of numbers and letters that uniquely identifies a property
    - You can create `uuid`s for each property by [hashing](https://blog.sonatype.com/what-is-hashing-a-look-at-unique-identifiers-in-software) the concatenation of each property’s county and county-specific ID, for example

- Splitting the dataset into two tables solves the problems with the first approach:
    - A property’s characteristics are only stored once in `properties.csv`
    - All properties can be present in `properties.csv`, not just those that were transacted
    - Having `uuid` in both tables allows for joining property characteristics onto transactions if desired

- Of course, there are still issues with this data structure:
    - What if you want to keep track of who owns which properties?
    - Property owners often subdivide or merge properties; how would you keep track of which properties were ancestors/descendants of each other?

- Database design is the topic of decades of academic research and industry innovation, and we’ve only just scratched the surface!
    - [This blog post](https://support.microsoft.com/en-us/office/database-design-basics-eb2159cf-1e30-401a-8084-bd4f9c9ca1f5) goes into some more depth, and if you want more, take [CS145](https://explorecourses.stanford.edu/search?view=catalog&filter-coursestatus-Active=on&page=0&catalog=&academicYear=&q=cs145&collapse=) in the Fall (if it's being offered).

## Tips for dealing with large tabular datasets

- Tabular datasets can get large very quickly (e.g. several GBs), reading/writing large files gets slow

- The `.csv` file format is an inefficient representation of the underlying data; use the more efficient [`.parquet`](https://towardsdatascience.com/demystifying-the-parquet-file-format-13adb0206705) files instead!
    - Most languages support `.parquet` files through third-party packages ([R](https://arrow.apache.org/docs/r/), Python: [Pandas](https://arrow.apache.org/docs/python/pandas.html)/[Polars](https://pola-rs.github.io/polars-book/user-guide/io/parquet/)); for STATA users, [this package](https://github.com/mcaceresb/stata-parquet) was the best I could find…
- Another tip: **partition** your data into multiple files by some variable, e.g. city for the property table and transaction year for the transactions table in the example
    - Make a folder with the name of the table that stores files named after each value of the partitioning variable

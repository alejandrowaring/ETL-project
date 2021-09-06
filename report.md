# Extraction

My Original data sources came from two places
 - [Kaggle cars Data set](https://www.kaggle.com/ljanjughazyan/cars1) as a CSV, referred to as "Kaggle Data Set"
 - [Federal Chambver of Automotive Industries VFACTS](https://www.fcai.com.au/sales/get-vfacts) as a PDF "VFACTS Data Set"

The CSV was well formatted for direct extraction, however the PDF Document was limited, and only a sample from Jan 2012. In order to get this data into the best possible format I manually extracted the aggregate data for each make of car that already existed on pages 14 and 18. I didn't gather the Light Commercial or Heavy Commercial data into the csv as the prospective client for the data would be a car company looking to make a road vehicle for private use and not commercial vehicles.

# Transformation

As the data came exactly as required from the VFACTS Data Set, the only required transformation required was the addition of a sum of the Passenger and SUV vehicle counts

As for the Kaggle Data Set, firstly the Drive Train column was dropped, the Invoice column was dropped as the MSRP gives a better indication of the market from the point of view of a manufacturer, and the Type column was dropped as it is a duplicate of the car types we encounter in the VFACTS Data Set. The MSRP column was then converted from a string with currency symbols, into an float so that math functions can be applied to it. Next, an aggregation of each make's cars was created in order to get a more understandable data set for the client rather than searching through hundreds of car models to get the information. Each of the columns regarding the car information was aggregated by the Minimum value, Mean Value, and the Maximum Value. This will allow an overview of the market and where each make stands, and can be easily graphed out.

Next the two datasets were merged together, with an inner join to drop any empty or null values from either data set, and only include the data that spans across both datasets, an ID was assigned to each make, and the column were given a more appropriate name.

# Load

A postgresql was chosen for this project as the data is already strongly structured and wont need to be edited beyond the initial loading, and any new data that may need to be added can be added as a new table, as the data has been broken down into categories. The tables each tell their own story for the data, with different specifications in each table, which can be queried by the client to get a different picture.
The generated make ID number is used as the primary key in all tables as there will always be a 1 to 1 relationship between the tables. The aggregation columns have all been loaded in as floats, as the averages should all be seen as floats, and having consistency over the data-types for each field will allow for additional math to be done on the data without the need of converting between data types.

The process used for the loading stage was to create the postgresql database that was based on the [ERD](ERD.schema) generated using the query found [here](create_table_queries.sql)

Next the Data was loaded in via the notebook by creating a list for each table containing the column names

```
make_sql_list = ['id','make','origin','car_count']
pricing_spec_list = ['id','min_msrp','avg_msrp','max_msrp']
engine_spec_list = ['id','min_engine_size','avg_engine_size','max_engine_size','min_cylinders','avg_cylinders','max_cylinders','min_horsepower','avg_horsepower','max_horsepower']
fuel_spec_list = ['id','min_mpg_city','avg_mpg_city','max_mpg_city','min_mpg_highway','avg_mpg_highway','max_mpg_highway']
chassis_spec_list = ['id','min_weight','avg_weight','max_weight','min_wheelbase','avg_wheelbase','max_wheelbase','min_length','avg_length','max_length']
sales_data_list = ['id','passenger_vol','suv_vol','total_vol']
```

Then using each of the lists to write the columns into the appropriate table in postgreSQL

```
final_df[pricing_spec_list].to_sql(name='pricing_spec',con=engine,if_exists='append',index=False)
final_df[engine_spec_list].to_sql(name='engine_spec',con=engine,if_exists='append',index=False)
final_df[fuel_spec_list].to_sql(name='fuel_spec',con=engine,if_exists='append',index=False)
final_df[chassis_spec_list].to_sql(name='chassis_spec',con=engine,if_exists='append',index=False)
final_df[sales_data_list].to_sql(name='sales_data',con=engine,if_exists='append',index=False)
```
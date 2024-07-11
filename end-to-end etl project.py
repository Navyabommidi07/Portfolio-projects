#!/usr/bin/env python
# coding: utf-8

# In[1]:


pip install kaggle


# In[2]:


import kaggle


# In[7]:


get_ipython().system('kaggle datasets download ankitbansal06/retail-orders -d orders.csv')


# In[26]:


import pandas as pd 
df = pd.read_csv(r'C:\Users\DELL\Downloads\navya\retail-orders\orders.csv',na_values=['Not Available','unknown'])


# In[27]:


df.head(20)


# In[28]:


df ['Ship Mode'].unique()


# In[37]:


# rename columns names..make them lower case and replace space withunderscore
#df.rename(columns={'Order Id':'order_id','City':'city'})-- long process to do it for every column
df.columns=df.columns.str.lower() # first convert to string"str" then lower() and add back to df.columns
df.columns=df.columns.str.replace(' ','_')# coverting into lowercase done now replacing " " to '_' done 
df.columns


# In[38]:


df.head(10)


# In[45]:


#derive new columns discount,sale price and profit
df['discount']=df['list_price']*df['discount_percent']*.01
df['sale_price']=df['list_price']-df['discount']
df['profit']=df['sale_price']-df['cost_price']
df


# In[49]:


# convert order date from object data type to datetime
df.dtypes
df['order_date']=pd.to_datetime(df['order_date'],format="%Y-%m-%d")
df.dtypes


# In[50]:


# drop cost price list price and discount percent columns
df.drop(columns=['list_price','cost_price','discount_percent'],inplace=True)


# In[51]:


df


# In[76]:


# load the data into sql server using replace option
import sqlalchemy as sal
engine= sal.create_engine('mssql:DESKTOP-74C4SN3\SQLEXPRESS/mater?driver=ODBC+Driver+17+for+SQL+Server')
conn=engine.connect()


# In[53]:


pip install pypyodbc


# In[57]:


import pypyodbc as odbc
driver_name ='ODBC+Driver+17+for+SQL+Server'
server_name='DESKTOP-74C4SN3\SQLEXPRESS'
database_name='master'
connection_string= f'
    driver={{{driver_name}}};
    server={server_name};
    database={database_name};
    Trust_Connection=yes;
"""    
conn=odbc.connect(connection_string)
print(conn)


# In[73]:


import pypyodbc as odbc
import sqlalchemy as sal
# Replace with your SQL Server connection details
server = 'DESKTOP-74C4SN3\\SQLEXPRESS'
database = 'master'
driver = 'ODBC+Driver+17+for+SQL+Server'
# Create the connection string
conn_str = f'mssql+pyodbc://{server}/{database}?driver={driver}'
# Create SQLAlchemy engine
engine = sal.create_engine(conn_str)
# Connect to the engine
conn = engine.connect()


 


# In[77]:


df.to_sql('df_orders',con=conn,index=False,if_exists='append')


# In[ ]:





# Imports
import plotly.express as px
import dash
import dash_core_components as dcc
import dash_html_components as html
import pymysql

# Connect to database
conn = pymysql.connect(host='localhost', user='root', password='root', database='dash')
cursor = conn.cursor()

# Select from the views
cursor.execute('select * from sales_by_employee')
employee_result = cursor.fetchall()

cursor.execute('select * from sales_by_product')
product_result = cursor.fetchall()

# Spit the results into lists
employees, e_sales, e_revenue = [], [], []
for i in employee_result:
    employees.append(i[0])
    e_sales.append(int(i[1]))
    e_revenue.append(int(i[2]))

products, p_sales, p_revenue = [], [], []
for i in product_result:
    products.append(i[0])
    p_sales.append(int(i[1]))
    p_revenue.append(int(i[2]))

emp_data = dict(Employee=employees, Revenue=e_revenue, Sales=e_sales)
pro_data = dict(Product=products, Revenue=p_revenue, Sales=p_sales)


# Plot and create dashboard
sales_by_employee = px.bar(emp_data, x='Employee', y=['Sales', 'Revenue'], title='Sales by Employee',
                           labels={'variable': 'Legend', 'value': 'Value'}
                           )

sales_by_product = px.bar(pro_data, x='Product', y=['Sales', 'Revenue'], title='Sales by Product',
                          labels={'variable': 'Legend', 'value': 'Value'}
                          )
app = dash.Dash()

app.layout = html.Div([
    dcc.Graph(figure=sales_by_employee),
    dcc.Graph(figure=sales_by_product)
])
app.run_server(debug=True, use_reloader=False)
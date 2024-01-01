import numpy as np
from flask import Flask, jsonify
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression


app = Flask(__name__)

car = pd.read_csv('carsdf.csv')
@app.route('/')
def train_linear_regression():
    import pandas as pd
    from sklearn.model_selection import train_test_split
    import statsmodels.api as sm
    from sklearn.preprocessing import StandardScaler
    from sklearn.linear_model import LinearRegression

    df = pd.read_csv('encoded.csv')

    # Assuming 'Price_Log' is the target variable
    X = df.drop(['Price_Log', 'Price'], axis=1)
    y = df['Price_Log']

    #X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=1)

    # Add a constant term for the intercept
    X_train_statsmodels = sm.add_constant(X)
    model_statsmodels = sm.OLS(y, X_train_statsmodels).fit()

    # Ensure X_test has the same columns as X_train_statsmodels
    X_test_statsmodels = sm.add_constant(X)
    X_test_statsmodels = X_test_statsmodels[X_train_statsmodels.columns]  # Align columns

    # Predict with the statsmodels model
    y_pre = model_statsmodels.predict(X_test_statsmodels)

    # Count the number of cars for each company
    company_counts = car['Brand'].value_counts()

    # Plot the bar chart
    plt.bar(company_counts.index, company_counts.values, color='skyblue')
    plt.xlabel('Company')
    plt.ylabel('Number of Cars')
    plt.title('Number of Cars per Company')

    # Save the bar chart image
    plt.savefig('bar_chart.png')
    # plt.close()

    # Count the number of cars for each fuel type
    fuel_counts = car['Fuel_Type'].value_counts()

    # Plot the pie chart
    plt.pie(fuel_counts, labels=fuel_counts.index, autopct='%1.1f%%', startangle=90)
    plt.title('Distribution of Cars by Fuel Type')

    # Save the pie chart image
    plt.savefig('pie_chart.png')
    plt.close()
    pre_data = pd.read_csv('Parameters.csv')
    #Confidence interval

    def CI(X, confidence_level=0.95):

        meann = np.mean(X)
        stdd = np.std(X, ddof=1)

        lower = meann - (0.1915 * stdd)
        upper = meann + (0.1915 * stdd)
        return lower, upper

    lower, upper = CI(y_pre)
    hist_values_Price_Log, bin_edges_Price_Log, _ = plt.hist(df['Price_Log'], bins='auto')
    hist_values_Year, bin_edges_Year, _ = plt.hist(df['Year'], bins='auto')
    hist_values_Kilometers_Driven, bin_edges_Kilometers_Driven, _ = plt.hist(df['Kilometers_Driven'], bins='auto')

    hist_values_Engine, bin_edges_Engine, _ = plt.hist(df['Engine'], bins='auto')
    hist_values_Mileage, bin_edges_Mileage, _ = plt.hist(df['Mileage'], bins='auto')

    hist_values_Seats, bin_edges_Seats, _ = plt.hist(df['Seats'], bins='auto')
    hist_values_Power, bin_edges_Power, _ = plt.hist(df['Power'], bins='auto')
    # Prepare JSON response
    histogram_data = {
        'values_Price_Log': hist_values_Price_Log.tolist(),
        'bin_edges_Price_Log': bin_edges_Price_Log.tolist(),
        'hist_values_Year':hist_values_Year.tolist(),
        'bin_edges_Year':bin_edges_Year.tolist(),
        'hist_values_Kilometers_Driven':hist_values_Kilometers_Driven.tolist(),
        'bin_edges_Kilometers_Driven': bin_edges_Kilometers_Driven.tolist(),
        'hist_values_Mileage':hist_values_Mileage.tolist(),
        'bin_edges_Mileage':bin_edges_Mileage.tolist(),
        'hist_values_Engine':hist_values_Engine.tolist(),
        'bin_edges_Engine':bin_edges_Engine.tolist(),
        'hist_values_Power':hist_values_Power.tolist(),
        'bin_edges_Power':bin_edges_Power.tolist(),
        'hist_values_Seats': hist_values_Seats.tolist(),
        'bin_edges_Seats':bin_edges_Seats.tolist()
    }
    summary_info = {

        'f_statistic': dict(
            zip(model_statsmodels.summary().tables[0].data[0], model_statsmodels.summary().tables[0].data[1])),
        'rsquared': float(model_statsmodels.summary().tables[0].data[6][1]),
        'adj_rsquared': float(model_statsmodels.summary().tables[0].data[7][1]),

    }

    results = {
        'LRM': {'y': y.tolist(), 'yhat': y_pre.tolist(), 'coefficients_bs':   model_statsmodels.params[1:].tolist(),'constant_as':model_statsmodels.params[0].tolist(),'summary_of_model': summary_info, 'Variables': pre_data['Variables'].tolist(), 'Parameters': pre_data['Parameters'].tolist(), 'CI_L':lower,'CI_U':upper},
        'scatter_data': {'Year':df['Year'].tolist(), 'Kilometers_Driven':df['Kilometers_Driven'].tolist(),	'Mileage':df['Mileage'].tolist(),	'Engine':df['Engine'].tolist(),	'Power':df['Power'].tolist(),'Seats':df['Seats'].tolist()},
        'histogram_of_price_Log': {'hist': histogram_data},
        'bar_chart_data': {'labels': company_counts.index.tolist(), 'values': company_counts.values.tolist()},
        'pie_chart_data': {'labels': fuel_counts.index.tolist(), 'values': fuel_counts.values.tolist()}
    }

    return jsonify({'result': results})


if __name__ == '__main__':
    # Run the Flask application
    app.run(debug=True)
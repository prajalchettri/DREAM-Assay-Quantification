% Sample experimental data (replace with your own data)
x_data = [0,10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180];
y_data = [1.00,1.00,0.87,0.62,0.40,0.31,0.27,0.25,0.25,0.24,0.24,0.24,0.24,0.24,0.24,0.24,0.24,0.23,0.23];
%y_data = [1.000,0.989,0.981,0.974,0.955,0.926,0.882,0.838,0.794,0.750,0.710,0.672,0.633,0.593,0.558,0.520,0.487,0.455,0.424];
%y_data = [1.000,0.924,0.797,0.666,0.557,0.474,0.418,0.381,0.359,0.346,0.339,0.335,0.332,0.331,0.330,0.329,0.329,0.328,0.328];
%yData = [1.000,0.894,0.746,0.614,0.499,0.397,0.328,0.285,0.268,0.262,0.258,0.256,0.255,0.254,0.253,0.252,0.252,0.252,0.251];
%yData = [1.000,0.999,0.865,0.616,0.396,0.308,0.269,0.253,0.248,0.244,0.243,0.241,0.240,0.239,0.238,0.236,0.235,0.234,0.233];
%yData = [1.000,1.001,0.988,0.854,0.709,0.570,0.444,0.352,0.289,0.262,0.244,0.235,0.229,0.226,0.224,0.221,0.219,0.217,0.216];
%Define the sigmoidal function model
sigmoidalModel = fittype('a + (b-a) / (1 + exp(c*(x-d)))', ...
    'coefficients', {'a', 'b', 'c', 'd'});

% Provide initial guess values for the coefficients
startPoint = [1, 0.24, 0.01, 40];

% Fit the model to the data with initial guess values
fitResult = fit(x_data', y_data', sigmoidalModel, 'StartPoint', startPoint);

% Get the best-fitted coefficients
bestCoefficients = coeffvalues(fitResult);

% Evaluate the fitted model over a range of x values
x_range = linspace(min(x_data), max(x_data), 100);
y_fit = feval(fitResult, x_range);

% Display the best-fitted coefficients
disp('Best-fitted coefficients:');
disp(bestCoefficients);

% Plot the experimental data and the fitted curve
figure;
plot(x_data, y_data, 'o', 'DisplayName', 'Experimental Data');
hold on;
plot(x_range, y_fit, 'r', 'DisplayName', 'Sigmoidal Fit');
xlabel('Time (in seconds)');
ylabel('Absorbance at 600 nm');
title('Sigmoidal Curve Fitting');
legend('Location', 'Best');
%grid on;
% Calculate the minimum and maximum values of the sigmoidal curve
min_value = bestCoefficients(1); % Lower asymptote (floor)
max_value = bestCoefficients(2); % Upper asymptote (ceiling)

% Calculate the x-value when the curve reaches 10% of the minimum
ten_percent_min_x = fminbnd(@(x) abs(feval(fitResult, x) - (min_value + 0.1 * (max_value - min_value))), min(x_data), max(x_data));

% Calculate the x-value when the curve reaches 90% of the maximum
ninety_percent_max_x = fminbnd(@(x) abs(feval(fitResult, x) - (max_value - 0.1 * (max_value - min_value))), min(x_data), max(x_data));

% Display the points
disp(['10% of Minimum (x): ', num2str(ten_percent_min_x)]);
disp(['90% of Maximum (x): ', num2str(ninety_percent_max_x)]);
disp(['Difference in time (s): ',num2str(ninety_percent_max_x - ten_percent_min_x)]);
% Plot the points on the curve
%plot(ten_percent_min_x, (min_value + 0.1 * (max_value - min_value)), 'ms', 'DisplayName', '10% of Minimum');
 %plot(ninety_percent_max_x, (max_value - 0.1 * (max_value - min_value)), 'cd', 'DisplayName', '90% of Maximum');
    
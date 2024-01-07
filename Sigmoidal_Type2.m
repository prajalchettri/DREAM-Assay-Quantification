% Define the inverse sigmoidal function
inverseSigmoidal = @(params, x) params(1) + params(2) ./ (1 + exp((x - params(3)) / params(4)));

% Generate some example data (you should replace this with your own data)
%xData = linspace(0, 10, 100);
%yData = 2 + 1 ./ (1 + exp((xData - 5) / 1.5)) + 0.1 * randn(size(xData));
xData = [0,10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200,210,220,230,240,250,260,270,280,290,300,310,320,330,340,350,360,370,380,390,400,410,420,430,440,450,460,470,480,490,500,510,520,530,540,550,560,570,580,590,600];
yData = [1.00,0.98,0.87,0.75,0.64,0.55,0.49,0.45,0.42,0.39,0.38,0.37,0.37,0.37,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.36,0.35,0.35,0.35,0.35,0.35,0.35,0.35,0.35,0.35,0.35,0.35,0.35,0.35,0.35,0.35,0.35,0.35];
%yData = [1.000,0.894,0.746,0.614,0.499,0.397,0.328,0.285,0.268,0.262,0.258,0.256,0.255,0.254,0.253,0.252,0.252,0.252,0.251];
%yData = [1.000,0.999,0.865,0.616,0.396,0.308,0.269,0.253,0.248,0.244,0.243,0.241,0.240,0.239,0.238,0.236,0.235,0.234,0.233];
%yData = [1.000,1.001,0.988,0.854,0.709,0.570,0.444,0.352,0.289,0.262,0.244,0.235,0.229,0.226,0.224,0.221,0.219,0.217,0.216];

% Initial parameter guess
initialGuess = [0.36, 0.77, 30, 17]; % You should adjust these values

% Fit the data to the inverse sigmoidal function using lsqcurvefit
paramsFit = lsqcurvefit(inverseSigmoidal, initialGuess, xData, yData);

% Extract the fitted parameters
fittedParam1 = paramsFit(1);
fittedParam2 = paramsFit(2);
fittedParam3 = paramsFit(3);
fittedParam4 = paramsFit(4);

% Display the fitted parameters
disp(['Fitted Parameters:']);
disp(['Parameter 1: ', num2str(fittedParam1)]);
disp(['Parameter 2: ', num2str(fittedParam2)]);
disp(['Parameter 3: ', num2str(fittedParam3)]);
disp(['Parameter 4: ', num2str(fittedParam4)]);

% Plot the data and the fitted curve
yFit = inverseSigmoidal(paramsFit, xData);

figure;
plot(xData, yData, 'o', xData, yFit, '-')
xlabel('Time (in seconds)');
ylabel('Absorbance at 600 nm');
legend('Experimental Data (Water)', 'Fitted Curve');


% Find the minimum and maximum points in the fitted curve
[minValue, minIndex] = min(yFit);
[maxValue, maxIndex] = max(yFit);

% Calculate 10% and 90% points
tenPercentPoint = minValue + 0.1 * (maxValue - minValue);
ninetyPercentPoint = maxValue - 0.1 * (maxValue - minValue);

% Find the corresponding x values for these points
tenPercentX = xData(find(yFit >= tenPercentPoint, 1, 'first'));
ninetyPercentX = xData(find(yFit <= ninetyPercentPoint, 1, 'first'));

% Display the values
disp(['10% of the minimum point: ', num2str(tenPercentX)]);
disp(['90% of the maximum point: ', num2str(ninetyPercentX)]);


% Calculate the difference between the x-coordinate values
xCoordinateDifference = ninetyPercentX - tenPercentX;

% Display the values
disp(['10% of the minimum point: ', num2str(tenPercentPoint)]);
disp(['90% of the maximum point: ', num2str(ninetyPercentPoint)]);
disp(['Difference in x-coordinates: ', num2str(xCoordinateDifference), ' units']);

% Calculate the goodness of the fit (R-squared value)
SSR = sum((yData - yFit).^2); % Sum of squared residuals
SST = sum((yData - mean(yData)).^2); % Total sum of squares
R2 = 1 - SSR / SST;

% Display the R-squared value
disp(['Goodness of Fit (R-squared value): ', num2str(R2)]);

% ... (Your existing code for fitting the sigmoidal model)

% ... (Your existing code for fitting the sigmoidal model)

% Get the best-fitted coefficients
bestCoefficients = coeffvalues(fitResult);

% Calculate the corresponding x-coordinate values for the fitted parameters
xValueParam1 = fminbnd(@(x) abs(inverseSigmoidal(bestCoefficients, x) - fittedParam1), min(x_data), max(x_data));
xValueParam2 = fminbnd(@(x) abs(inverseSigmoidal(bestCoefficients, x) - fittedParam2), min(x_data), max(x_data));
xValueParam3 = fminbnd(@(x) abs(inverseSigmoidal(bestCoefficients, x) - fittedParam3), min(x_data), max(x_data));
xValueParam4 = fminbnd(@(x) abs(inverseSigmoidal(bestCoefficients, x) - fittedParam4), min(x_data), max(x_data));

% Display the corresponding x-coordinate values
disp(['Corresponding x-coordinate value for fitted parameter 1: ', num2str(xValueParam1)]);
disp(['Corresponding x-coordinate value for fitted parameter 2: ', num2str(xValueParam2)]);
disp(['Corresponding x-coordinate value for fitted parameter 3: ', num2str(xValueParam3)]);
disp(['Corresponding x-coordinate value for fitted parameter 4: ', num2str(xValueParam4)]);

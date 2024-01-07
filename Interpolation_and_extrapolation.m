
% Sample experimental data (replace with your own data)
x_data = [0,10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180];
y_data = [1.00, 0.99,0.98,0.97,0.96,0.93,0.88,0.84,0.79,0.75,0.71,0.67,0.63,0.59,0.56,0.52,0.49,0.46,0.42];
% Define the sigmoidal function model
sisigmoidalModel = fittype('a + (b-a) / (1 + exp(c*(x-d)))', ...
    'coefficients', {'a', 'b', 'c', 'd'});

% Provide initial guess values for the coefficients
startPoint = [0.33, 1, 0.02, 103];

% Fit the model to the data with initial guess values
fitResult = fit(x_data', y_data', sigmoidalModel, 'StartPoint', startPoint);

% Get the best-fitted coefficients
bestCoefficients = coeffvalues(fitResult);

% Display the best-fitted coefficients
disp('Best-fitted coefficients:');
disp(['Parameter ''a'': ', num2str(bestCoefficients(1))]);
disp(['Parameter ''b'': ', num2str(bestCoefficients(2))]);
disp(['Parameter ''c'': ', num2str(bestCoefficients(3))]);
disp(['Parameter ''d'': ', num2str(bestCoefficients(4))]);

% Calculate the x-coordinate when the curve reaches the lower asymptote (parameter 'a')
x_a = fminbnd(@(x) abs(feval(fitResult, x) - bestCoefficients(1)), min(x_data), max(x_data));

% Calculate the x-coordinate when the curve reaches the upper asymptote (parameter 'b')
x_b = fminbnd(@(x) abs(feval(fitResult, x) - bestCoefficients(2)), min(x_data), max(x_data));

% Display the x-coordinate values for parameters 'a' and 'b'
disp(['X-coordinate for parameter ''a'': ', num2str(x_a)]);
disp(['X-coordinate for parameter ''b'': ', num2str(x_b)]);

% Extend the x_data range for extrapolation
extendedXData = [x_data,250,260,270,280,290,300,310,320,330,340,350,360,370,380,390,400,410,420,430,440,450,460,470,480,490,500,510,520,530,540,550,560,570,580,590,600,610,620,630,640,650,660,670,680,690,700,710,720,730,740,750,760,770,780,790,800,810,820,830,840,850,860,870,880,890,900,910,920,930,940,950,960,970,980,990,1000];

% Predict y values using the fitted parameters
extendedYFit = feval(fitResult, extendedXData);
%extendedYFit = interp(x,5);
% Plot the extrapolated curve
figure;
plot(extendedXData, extendedYFit, '-', 'DisplayName', 'Extrapolated Curve');
%stem(extendedXData);
%stem(extendedYFit);
hold on;
plot(x_data, y_data, 'o', 'DisplayName', 'Experimental Data');
xlabel('Time (in seconds)');
ylabel('Absorbance at 600 nm');
title('Extrapolation of Sigmoidal Curve');
legend('Experimental Data', 'Extrapolated Curve', 'Location', 'Best');

% Display legend
legend('Location', 'Best');

% Display the fitted parameters on the plot
text(min(x_data), max(y_data), ['a: ', num2str(bestCoefficients(1))], 'VerticalAlignment', 'top');
text(min(x_data), max(y_data), ['b: ', num2str(bestCoefficients(2))], 'VerticalAlignment', 'bottom');

% Extrapolated value to be investigated
extrapolatedValue = bestCoefficients(1);

% Check if the extrapolated value is within the range
if extrapolatedValue >= min(y_data) && extrapolatedValue <= max(y_data)
    % Perform linear interpolation
    idx = find(y_data <= extrapolatedValue, 1, 'last');
    if isempty(idx)
        idx = 1;
    end
    if idx < numel(y_data)
        x1 = x_data(idx);
        x2 = x_data(idx + 1);
        y1 = y_data(idx);
        y2 = y_data(idx + 1);
        interpolatedX = x1 + (extrapolatedValue - y1) * (x2 - x1) / (y2 - y1);
        disp(['Interpolated x-coordinate for value ', num2str(extrapolatedValue), ': ', num2str(interpolatedX)]);
    else
        disp('Extrapolation not possible; the value is out of range.');
    end
else
    % Perform linear extrapolation using the last two data points
    slope = (y_data(end) - y_data(end-1)) / (x_data(end) - x_data(end-1));
    extrapolatedX = x_data(end) + (extrapolatedValue - y_data(end)) / slope;
    disp(['Extrapolated x-coordinate for value ', num2str(extrapolatedValue), ': ', num2str(extrapolatedX)]);
end
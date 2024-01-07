This code uses the Type-1 sigmoidal function. Additionally, this code can be used to extrapolate the data points to estimate the lower asymptote point. 
To get better resolution between two data  points to pin-point (in time-axis) the maximum slope point, one can use the in-built interpolate function of Matlab given by the following syntax:

yq = interp1(x,y,xq); where yq is the interpolated array of points, xq defines the query points to be a finer sampling over the range of x. 
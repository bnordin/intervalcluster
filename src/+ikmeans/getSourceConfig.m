%> @file setupEngyTime.m
%> @brief Defines the getSourceConfig function
%> @details The getSourceConfig function parses the specifed tab-delimited file and returns # of Centroids and # of blocks.
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Reads the specified file and returns the contents as variables
%> @details The getSourceConfig function parses the specifed tab-delimited file and returns # of Centroids and # of blocks.
%
%> @param configFile The tab-delimited file containing centroid and block counts
%> @return nCentroids The number of centroids specifed in the file
%> @return nBlocks The number of blocks specified in the file
% ======================================================================
function [nCentroids, nBlocks] = getSourceConfig(configFile)
	nCentroids = 0;
	nBlocks = 0;
	d = importdata(configFile);
	for di=1:length(d.data)
		dtext = char(d.textdata(di));
		switch dtext
			case 'nCentroids'
				nCentroids = d.data(di);
			case 'nBlocks'
				nBlocks = d.data(di);
			otherwise
				error(strcat('Incorrect value (',d.textdata(di),') in source config file: ',configFile));
		end %switch
	end % for
end % function


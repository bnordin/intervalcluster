%> @file runone.m
%> @brief Sets up the required parameters and executes a single K-Means run
%> @details Sets up the required parameters and executes a single K-Means run
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================

ikmeans.setupGlobal; % defines p,rootPath,dataPath,resultsPath,fileWriterId

% SET THE PARAMETERS

%fname='EngyTime';
%fname='Hepta';
%fname='Lsun';
%fname='Tetra';
fname='TwoDiamonds';
%fname='WingNut';
[nCentroids,nBlocks] = ikmeans.getSourceConfig(strcat(dataPath,filesep,fname,'.config.csv'));

p.dataType = ikmeans.entity.dataType.STANDARD;
%p.dataType = ikmeans.entity.dataType.INTERVAL;
%p.dataType = ikmeans.entity.dataType.WIDEINTERVAL;

p.initType = ikmeans.entity.initType.PEAK;
%p.initType = ikmeans.entity.initType.FORGY;

p.randSeed = 6140724;

p.resultsPath=strcat(resultsPath,filesep,lower(fname));
p.membershipFile = strcat(dataPath,filesep,fname,'_amembership.csv');
p.filename = strcat(fname,'.csv');
p.basename = fname;
p.nCentroids = nCentroids;
p.nBlocks = nBlocks;

% SETUP LOGGING

p.writers(fileWriterId).fileName = strcat(p.resultsPath,filesep,lower(sprintf('%s_%s_%s_%s_%6.0f_log.txt', ...
	p.basename, ...
	ikmeans.entity.dataType.toString(p.dataType), ...
	ikmeans.entity.initType.toFixedString(p.initType), ...
	'final', ...
	p.randSeed)));
%p.writers(fileWriterId).fileName
p.writers(fileWriterId).fileId = fopen(p.writers(fileWriterId).fileName,'w'); % log after and generate file name

% EXECUTE THE RUN
run = ikmeans.logic.runL.run(p);

% CLEANUP
fclose(p.writers(fileWriterId).fileId);

clear dataPath resultsPath rootPath w p fileWriterId fname nBlocks nCentroids;


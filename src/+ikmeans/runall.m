%> @file runall.m
%> @brief Sets up experiment parameter combinations to execute a batch of runs
%> @details Sets up experiment parameter combinations to execute a batch of runs and saves reports complied from the results of each run
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
ikmeans.setupGlobal;  % defines p,rootPath,dataPath,resultsPath,fileWriterId

% set parameters common to all sources
batch = ikmeans.entity.batch();
batch.parameters = p;
batch.dataTypes = [ikmeans.entity.dataType.STANDARD ikmeans.entity.dataType.INTERVAL ikmeans.entity.dataType.WIDEINTERVAL];
%batch.dataTypes = [ikmeans.entity.dataType.WIDEINTERVAL];
%batch.dataTypes = [ikmeans.entity.dataType.STANDARD];
batch.initTypes = [ikmeans.entity.initType.FORGY ikmeans.entity.initType.PEAK];
%batch.initTypes = [ikmeans.entity.initType.PEAK];
%batch.rands = 6140723:6140723;
batch.rands = 6140723:6140732;
batch.fid = fileWriterId;

% add individual sources (comment out to skip a source)
fname='EngyTime'; [nCentroids,nBlocks] = ikmeans.getSourceConfig(strcat(dataPath,filesep,fname,'.config.csv'));
	id=length(batch.fnames) + 1;
	batch.membershipFiles(id) = cellstr(strcat(dataPath,filesep,fname,'_amembership.csv'));
	batch.resultPaths(id) = cellstr(strcat(resultsPath,filesep,lower(fname)));
	batch.fnames(id) = cellstr(fname);
	batch.centroidCounts(id) = nCentroids;
	batch.blockCounts(id) = nBlocks;
fname='Hepta'; [nCentroids,nBlocks] = ikmeans.getSourceConfig(strcat(dataPath,filesep,fname,'.config.csv'));
	id=length(batch.fnames) + 1;
	batch.membershipFiles(id) = cellstr(strcat(dataPath,filesep,fname,'_amembership.csv'));
	batch.resultPaths(id) = cellstr(strcat(resultsPath,filesep,lower(fname)));
	batch.fnames(id) = cellstr(fname);
	batch.centroidCounts(id) = nCentroids;
	batch.blockCounts(id) = nBlocks;
fname='Lsun'; [nCentroids,nBlocks] = ikmeans.getSourceConfig(strcat(dataPath,filesep,fname,'.config.csv'));
	id=length(batch.fnames) + 1;
	batch.membershipFiles(id) = cellstr(strcat(dataPath,filesep,fname,'_amembership.csv'));
	batch.resultPaths(id) = cellstr(strcat(resultsPath,filesep,lower(fname)));
	batch.fnames(id) = cellstr(fname);
	batch.centroidCounts(id) = nCentroids;
	batch.blockCounts(id) = nBlocks;
fname='Tetra'; [nCentroids,nBlocks] = ikmeans.getSourceConfig(strcat(dataPath,filesep,fname,'.config.csv'));
	id=length(batch.fnames) + 1;
	batch.membershipFiles(id) = cellstr(strcat(dataPath,filesep,fname,'_amembership.csv'));
	batch.resultPaths(id) = cellstr(strcat(resultsPath,filesep,lower(fname)));
	batch.fnames(id) = cellstr(fname);
	batch.centroidCounts(id) = nCentroids;
	batch.blockCounts(id) = nBlocks;
fname='TwoDiamonds'; [nCentroids,nBlocks] = ikmeans.getSourceConfig(strcat(dataPath,filesep,fname,'.config.csv'));
	id=length(batch.fnames) + 1;
	batch.membershipFiles(id) = cellstr(strcat(dataPath,filesep,fname,'_amembership.csv'));
	batch.resultPaths(id) = cellstr(strcat(resultsPath,filesep,lower(fname)));
	batch.fnames(id) = cellstr(fname);
	batch.centroidCounts(id) = nCentroids;
	batch.blockCounts(id) = nBlocks;
fname='WingNut'; [nCentroids,nBlocks] = ikmeans.getSourceConfig(strcat(dataPath,filesep,fname,'.config.csv'));
	id=length(batch.fnames) + 1;
	batch.membershipFiles(id) = cellstr(strcat(dataPath,filesep,fname,'_amembership.csv'));
	batch.resultPaths(id) = cellstr(strcat(resultsPath,filesep,lower(fname)));
	batch.fnames(id) = cellstr(fname);
	batch.centroidCounts(id) = nCentroids;
	batch.blockCounts(id) = nBlocks;

% execute the entire batch of runs
runs = ikmeans.logic.runL.batch(batch);

% save reports complied from the results
ikmeans.logic.reportL.saveAggregateReport(runs,strcat(resultsPath,filesep,'aggregateReport.csv'));
ikmeans.logic.reportL.saveQualityReport(runs,strcat(resultsPath,filesep,'qualityReport.csv'));


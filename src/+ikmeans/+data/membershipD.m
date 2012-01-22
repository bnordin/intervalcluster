%> @file membershipD.m
%> @brief Reads or writes membership information to a file
%> @details Reads or writes membership information to a file
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Reads or writes membership information to a file
%> @details Reads or writes membership information to a file
% ======================================================================
classdef membershipD

methods(Static)

	% ======================================================================
	%> @brief Reads membership information from a file
	%> @details Reads membership information from a tab-delimited file
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.membership
	%> @param r Experiment run information
	%> @param membership The membership container to save the loaded data into
	%> @param fileName The file that contains the membership information
	%> @retval r Experiment run information
	%> @retval membership The updated membership container
	% ======================================================================
	function [r,membership] = load(r,membership,fileName)
		import ikmeans.entity.*
		
		membership.values = dlmread(fileName, '\t');
	end % function

	% ======================================================================
	%> @brief Saves membership information to a file
	%> @details Saves membership information to a tab-delimited file
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.membership
	%> @param r Experiment run information
	%> @param membership The membership information to save
	%> @param fileName The destination file
	%> @retval r Experiment run information
	% ======================================================================
	function r = save(r,membership, fileName)
		import ikmeans.entity.*
		
		dlmwrite(fileName, membership.values,'\t');
	end % function

end % methods
end % classdef


<!---

    Slatwall - An Open Source eCommerce Platform
    Copyright (C) ten24, LLC
	
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
	
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
	
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    Linking this program statically or dynamically with other modules is
    making a combined work based on this program.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
	
    As a special exception, the copyright holders of this program give you
    permission to combine this program with independent modules and your 
    custom code, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting program under terms 
    of your choice, provided that you follow these specific guidelines: 

	- You also meet the terms and conditions of the license of each 
	  independent module 
	- You must not alter the default display of the Slatwall name or logo from  
	  any part of the application 
	- Your custom code must not alter or create any files inside Slatwall, 
	  except in the following directories:
		/integrationServices/

	You may copy and distribute the modified version of this program that meets 
	the above guidelines as a combined work under the terms of GPL for this program, 
	provided that you include the source code of that other code when and as the 
	GNU GPL requires distribution of source code.
    
    If you modify this program, you may extend this exception to your version 
    of the program, but you are not obligated to do so.

Notes:

--->
<cfif thisTag.executionMode is "start">
	<cfparam name="attributes.hibachiScope" type="any" default="#request.context.fw.getHibachiScope()#" />
	<cfparam name="attributes.auditTypeList" type="string" default="create,update,delete" />
	<cfparam name="attributes.baseObjectList" type="string" default="" />
	<cfparam name="attributes.object" type="any" default="" />
	<cfparam name="attributes.recordsShow" type="string" default="10" hint="This is the total number of audit records to display" />
	<cfparam name="attributes.auditSmartList" type="any" default="" />
	
	<cfset thisTag.hibachiAuditService = attributes.hibachiScope.getBean('HibachiAuditService') />
	<cfset thisTag.mode = "" />
	<cfset thisTag.auditSmartList = "" />
	<cfset thisTag.auditArray = [] />
	
	<cfif isObject(attributes.auditSmartList)>
		<cfset thisTag.mode = "auditSmartList" />
		<cfset thisTag.auditSmartList = attributes.auditSmartList />
	<cfelseif isObject(attributes.object) >
		<cfset thisTag.mode = "object" />
		<cfset thisTag.auditSmartList = attributes.object.getAuditSmartList() />
	<cfelse>
		<cfset thisTag.mode = "baseObjectList" />
		<!--- Determine which base object types to display --->
		<cfset thisTag.auditSmartList = thisTag.hibachiAuditService.getAuditSmartList() />
		<cfif listLen(attributes.baseObjectList)>
			<cfset thisTag.auditSmartList.addInFilter("baseObject", attributes.baseObjectList) />
		</cfif>
	</cfif>
	
	<cfif listLen(attributes.auditTypeList)>
		<cfset thisTag.auditSmartList.addInFilter("auditType", attributes.auditTypeList) />
	</cfif>
	
	<!---
		
		SELECT a FROM SlatwallAudit a INNER JOIN FETCH
		
	--->
	
	
	<cfset thisTag.auditSmartList.addOrder("auditDateTime|DESC") />
	
	<!--- Display page or all --->
	<cfif isNumeric(attributes.recordsShow) and attributes.recordsShow gt 0>
		<cfset thisTag.auditSmartList.setPageRecordsShow(attributes.recordsShow) />
		<cfset thisTag.auditArray = thisTag.auditSmartList.getPageRecords() />
	<cfelse>
		<cfset thisTag.auditArray = thisTag.auditSmartList.getRecords() />
	</cfif>
	
	<cfset thisTag.columnCount = 5 />
	
	<cfoutput>
		<table class="table table-striped table-bordered table-condensed">
			<tbody>
				<cfif arraylen(thisTag.auditArray)>
					<cfset currentYear = "" />
					<cfset currentMonth = "" />
					<cfset currentDay = "" />
					<cfloop array="#thisTag.auditArray#" index="currentAudit">
						<cfset thisDate = currentAudit.getAuditDateTime() />
						<cfset thisYear = year(currentAudit.getAuditDateTime()) />
						<cfset thisMonth = year(currentAudit.getAuditDateTime()) />
						<cfset thisDay = year(currentAudit.getAuditDateTime()) />
						<tr>
							<td colspan="3">Monday - May 3rd 2014</td>
						</tr>
						<tr>
							<!--- TODO: Change to just time --->
							<td style="white-space:nowrap;width:1%;"><strong>#currentAudit.getFormattedValue("auditDateTime")#</strong> - 
								#currentAudit.getSessionAccountFullName()#
							</td>
							<td class="primary">
								<cfif thisTag.mode neq 'object'><strong>#currentAudit.getFormattedValue('auditType')# #currentAudit.getBaseObject()#</strong> - 
								<cfif listFindNoCase("create,update", currentAudit.getAuditType())>
									<cf_HibachiActionCaller action="admin:entity.detail#currentAudit.getBaseObject()#" queryString="#currentAudit.getBaseObject()#ID=#currentAudit.getBaseID()#" text="#currentAudit.getTitle()#" />
								<cfelse>
									#currentAudit.getTitle()#
								</cfif>
								<br />
								</cfif>
								<cfif currentAudit.getAuditType() eq 'update'>
									Changed: 
									<cfset data = deserializeJSON(currentAudit.getData()) />
									<cfset isFirstFlag = true />
									<cfloop collection="#data.newPropertyData#" item="property"><cfif not isFirstFlag>,</cfif> #attributes.hibachiScope.rbKey("entity.#currentAudit.getBaseObject()#.#property#")#<cfset isFirstFlag = false /></cfloop>
								</cfif>
							</td>
							<td class="admin admin1">
								<cf_HibachiActionCaller action="admin:entity.preprocessaudit" queryString="processContext=rollback&#currentAudit.getPrimaryIDPropertyName()#=#currentAudit.getPrimaryIDValue()#" class="btn btn-mini" modal="true" icon="eye-open" iconOnly="true" />
							</td>
						</tr>
					</cfloop>
				<cfelse>
					<tr><td colspan="#thisTag.columnCount#" style="text-align:center;"><em>#attributes.hibachiScope.rbKey("entity.audit.norecords")#</em></td></tr>
				</cfif>
			</tbody>
		</table>
	</cfoutput>
</cfif>
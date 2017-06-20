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
<cfimport prefix="swa" taglib="../../../tags" />
<cfimport prefix="hb" taglib="../../../org/Hibachi/HibachiTags" />


<cfparam name="rc.fulfillmentBatch" type="any" />
<cfparam name="rc.edit" type="boolean" default="false" />
<cfoutput>
<hb:HibachiEntityDetailForm object="#rc.fulfillmentBatch#" edit="#rc.edit#">
	<hb:HibachiEntityActionBar type="detail" object="#rc.fulfillmentBatch#" edit="#rc.edit#"></hb:HibachiEntityActionBar>
	<cfset totalFulfilled = rc.fulfillmentBatch.getFulfillmentsCompletedTotal()>
	<cfset totalOnBatch = rc.fulfillmentBatch.getTotalQuantityOnBatch()>
	<cfset totalFulfillments = arrayLen( rc.fulfillmentBatch.getFulfillmentBatchItems())>
	
	<cfif totalFulfilled gt 0>
			<cfset totalPercentFulfilled = (totalFulfilled/totalOnBatch)*100 >
	<cfelse>
		<cfset totalPercentFulfilled = 0 >
	</cfif>
	<cfif arrayLen(rc.fulfillmentBatch.getLocations())>
		<cfset defaultLocation = rc.fulfillmentBatch.getLocations()[1].getLocationPathName()>
	</cfif>
	
	<section class="s-pick-pack-detail container" ng-init="expanded = true" ng-cloak>
		<div class="row s-detail-modules-wrapper">	
			<!--- Icon Properties --->
			<sw-card-layout card-class="col-sm-6 col-md-6 col-lg-4 s-detail-module s-md-content-block">
				<sw-card-view id="batchNumber" card-size="sm">
					<sw-card-icon icon-name="shopping-cart"></sw-card-icon>
					<sw-card-header add-border="false">Batch ID</sw-card-header>
					<sw-card-body>
						<cfif rc.edit eq "true">
							<swa:SlatwallPropertyDisplay object="#rc.fulfillmentBatch#" property="fulfillmentBatchNumber" value="#rc.fulfillmentBatch.getFulfillmentBatchNumber()#" title=" " edit="false"></swa:SlatwallPropertyDisplay>
						<cfelse>
							#rc.fulfillmentBatch.getFulfillmentBatchNumber()#
						</cfif>
					</sw-card-body>
				</sw-card-view>
				
				<sw-card-view id="assignedAccount" card-size="sm">
					<sw-card-icon icon-name="user"></sw-card-icon>
					<sw-card-header add-border="false">User</sw-card-header>
					<cfif !isNull(rc.fulfillmentBatch.getAssignedAccount())>
						<sw-card-body>#rc.fulfillmentBatch.getAssignedAccount().getFirstName()# #rc.fulfillmentBatch.getAssignedAccount().getLastName()#</sw-card-body>
					</cfif>
				</sw-card-view>

				<sw-card-view id="location" card-size="sm">
					<sw-card-icon icon-name="building"></sw-card-icon>
					<sw-card-header add-border="false">Location</sw-card-header>
					<sw-card-body><cfif !isNull(defaultLocation)> #defaultLocation# <cfelse> None. </cfif></sw-card-body>
				</sw-card-view>
			</sw-card-layout>
			
			<!--- Description --->
			<sw-card-layout class="col-sm-6 col-md-6 col-lg-4 s-detail-module s-md-content-block">
				<sw-card-view id="description" card-title="Description">
					<sw-card-body>
						<cfif rc.edit eq "true">
							<swa:SlatwallPropertyDisplay fieldclass="form-control" object="#rc.fulfillmentBatch#" property="description" value="#rc.fulfillmentBatch.getDescription()#" edit="#rc.edit#"></swa:SlatwallPropertyDisplay>
						<cfelse>
							#rc.fulfillmentBatch.getDescription()#
						</cfif>
					</sw-card-body>
				</sw-card-view>
			</sw-card-layout>
			
			<!--- Status --->
			<sw-card-layout class="col-sm-6 col-md-6 col-lg-4 s-detail-module s-md-content-block">
				<sw-card-view id="status">
					<sw-card-header>Status</sw-card-header>
					
					<!--- Number of fulfillments total --->
					<sw-card-list-item title="Fulfillment Items" value="#totalOnBatch#" strong="true"></sw-card-list-item>
					
					<!--- Number of fulfillments fulfilled --->
					<sw-card-list-item title="Completed" value="#totalFulfilled#"></sw-card-list-item>
					
					<!--- Progress Bar --->
					<sw-card-progress-bar value-min="0" value-max="100" value-now="#totalPercentFulfilled#"></sw-card-progress-bar>
					
				</sw-card-view>
			</sw-card-layout>
		</div>
		
		<sw-fulfillment-batch-detail fulfillment-batch-id="#rc.fulfillmentBatch.getFulfillmentBatchID()#">Loading ...</sw-fulfillment-batch-detail>
		
</hb:HibachiEntityDetailForm>
</cfoutput>

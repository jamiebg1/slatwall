<!---

    Slatwall - An e-commerce plugin for Mura CMS
    Copyright (C) 2011 ten24, LLC

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
    
    Linking this library statically or dynamically with other modules is
    making a combined work based on this library.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
 
    As a special exception, the copyright holders of this library give you
    permission to link this library with independent modules to produce an
    executable, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting executable under
    terms of your choice, provided that you also meet, for each linked
    independent module, the terms and conditions of the license of that
    module.  An independent module is a module which is not derived from
    or based on this library.  If you modify this library, you may extend
    this exception to your version of the library, but you are not
    obligated to do so.  If you do not wish to do so, delete this
    exception statement from your version.

Notes:

--->
<cfcomponent extends="BaseDAO">
	
	<cffunction name="deleteAllOrders">
			<cfquery datasource="#application.configBean.getDataSource()#">
				UPDATE SlatwallSession SET orderID = null;
				DELETE FROM SlatwallAttributeValue WHERE attributeValueType = 'orderItem';
				DELETE FROM SlatwallOrderDelivery;
				DELETE FROM SlatwallOrderDeliveryItem;
				DELETE FROM SlatwallTaxApplied;
				DELETE FROM SlatwallPromotionApplied;
				DELETE FROM SlatwallOrderItem;
				DELETE FROM SlatwallOrderShippingMethodOption;
				DELETE FROM SlatwallOrderFulfillment;
				DELETE FROM SlatwallCreditCardTransaction;
				DELETE FROM SlatwallOrderPayment;
				DELETE FROM SlatwallOrder;
			</cfquery>
	</cffunction>
	
	<cffunction name="deleteAllProducts">
			<cfquery datasource="#application.configBean.getDataSource()#">
				DELETE FROM SlatwallAttributeValue WHERE attributeValueType = 'product';
				DELETE FROM SlatwallPromotionReward WHERE rewardType='product';
				DELETE FROM SlatwallAttributeSetAssignment WHERE attributeSetAssignmentType='product';
				DELETE FROM SlatwallProductContent;
				DELETE FROM SlatwallProductCategory;
				UPDATE SlatwallProduct SET defaultSkuID = null;
				DELETE FROM SlatwallSkuOption;
				DELETE FROM SlatwallSku;
				DELETE FROM SlatwallProduct;
			</cfquery>
	</cffunction>
	
	<cffunction name="deleteAllBrands">
			<cfquery datasource="#application.configBean.getDataSource()#">
				DELETE FROM SlatwallBrand;
			</cfquery>
	</cffunction>
	
	<cffunction name="deleteAllProductTypes">
			<cfquery datasource="#application.configBean.getDataSource()#">
				DELETE FROM SlatwallAttributeSetAssignment WHERE attributeSetAssignmentType='productType';
				DELETE FROM SlatwallProductType;
			</cfquery>
	</cffunction>
	
	<cffunction name="deleteAllOptions">
			<cfquery datasource="#application.configBean.getDataSource()#">
				DELETE FROM SlatwallOption;
				DELETE FROM SlatwallOptionGroup;
			</cfquery>
	</cffunction>
	
</cfcomponent>
/*

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

*/
component displayname="Order Shipping" entityname="SlatwallOrderShipping" table="SlatwallOrderShipping" persistent=true accessors=true output=false extends="slatwall.com.entity.BaseEntity" {
	
	// Persistant Properties
	property name="orderShippingID" ormtype="string" length="32" fieldtype="id" generator="uuid" unsavedvalue="" default="";
	property name="cost" ormtype="float";
	
	// Related Object Properties
	property name="order" cfc="order" fieldtype="many-to-one" fkcolumn="orderID";
	property name="address" cfc="Address" fieldtype="many-to-one" fkcolumn="addressID";
	property name="shippingMethod" cfc="ShippingMethod" fieldtype="many-to-one" fkcolumn="shippingMethodID";
	property name="orderShippingItems" singularname="orderShippingItem" cfc="OrderItem" fieldtype="one-to-many" fkcolumn="orderShippingID" inverse="true" cascade="all";
	
	public any function init() {
		if(isNull(variables.orderShippingItems)) {
			variables.orderShippingItems = [];
		}
		
		return super.init();
	}
	
	/******* Association management methods for bidirectional relationships **************/
	
	// Order (many-to-one)
	
	public void function setOrder(required Order order) {
		variables.order = arguments.order;
		if(!arguments.order.hasOrderShipping(this)) {
			arrayAppend(arguments.order.getOrderShippings(),this);
		}
	}
	
	public void function removeOrder(Order order) {
	   if(!structKeyExists(arguments,"order")) {
	   		arguments.order = variables.order;
	   }
       var index = arrayFind(arguments.order.getOrderShippings(),this);
       if(index > 0) {
           arrayDeleteAt(arguments.order.getOrderShippings(), index);
       }
       structDelete(variables,"order");
    }
    
    // Order Shipping Items (one-to-many)
    public void function addOrderShippingItem(required OrderShippingItem orderShippingItem) {
    	arguments.orderShippingItem.addOrderShipping(this);
    }
    
    public void function removeOrderShippingItem(required OrderShippingItem orderShippingItem) {
    	arguments.orderShippingItem.removeOrderShipping(this);
    }
    
    
}

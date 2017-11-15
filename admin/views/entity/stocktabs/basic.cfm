<cfimport prefix="swa" taglib="../../../../tags" />
<cfimport prefix="hb" taglib="../../../../org/Hibachi/HibachiTags" />

<cfparam name="rc.stock" type="any" />
<cfparam name="rc.sku" type="any" default="#rc.stock.getSku()#" />
<cfparam name="rc.location" type="any" default="#rc.stock.getLocation()#" />
<cfoutput>
	<hb:HibachiPropertyRow>
		<hb:HibachiPropertyList>
			<hb:HibachiPropertyDisplay object="#rc.sku#" property="activeFlag" >
			<hb:HibachiPropertyDisplay object="#rc.sku#" property="skuName">
			<hb:HibachiPropertyDisplay object="#rc.sku#" property="skuCode" >
			<hb:HibachiPropertyDisplay object="#rc.location#" property="locationName" >
			<hb:HibachiPropertyDisplay object="#rc.sku#" property="userDefinedPriceFlag" >
			<hb:HibachiPropertyDisplay object="#rc.sku#" property="price">
			<hb:HibachiPropertyDisplay object="#rc.sku#" property="listPrice" >
			<hb:HibachiPropertyDisplay object="#rc.stock#" property="calculatedAverageCost" edit="false"/>
			<hb:HibachiPropertyDisplay object="#rc.stock#" property="calculatedAverageLandedCost" edit="false" />
			<hb:HibachiPropertyDisplay object="#rc.sku#" property="currentMargin" edit="false">
			<hb:HibachiPropertyDisplay object="#rc.sku#" property="currentLandedMargin" edit="false">
			<hb:HibachiPropertyDisplay object="#rc.sku#" property="currentAssetValue" edit="false">
			<hb:HibachiPropertyDisplay object="#rc.sku#" property="averagePriceSold" edit="false">
			<hb:HibachiPropertyDisplay object="#rc.sku#" property="averageProfit" edit="false">
			<hb:HibachiPropertyDisplay object="#rc.sku#" property="averageLandedProfit" edit="false">
			<hb:HibachiPropertyDisplay object="#rc.sku#" property="averageMarkup" edit="false">
			<hb:HibachiPropertyDisplay object="#rc.sku#" property="averageLandedMarkup" edit="false">
		</hb:HibachiPropertyList>
	</hb:HibachiPropertyRow>
</cfoutput>

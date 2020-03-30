[{oxstyle include=$oViewConf->getModuleUrl("rs-variantview", "out/src/style/css.css")}]

[{assign var="blCanBuy" value=$aVariantSelections.blPerfectFit}]
[{if !$blHasActiveSelections}]
    [{if !$blCanBuy && !$oDetailsProduct->isParentNotBuyable()}]
        [{assign var="blCanBuy" value=true}]
    [{/if}]
[{/if}]


[{capture name="rsscript"}]
    [{capture}]<script>[{/capture}]    
        
        $('#variants .rsvariantview-selection-row[data-selection-id]').click(function() {
            let id = $(this).attr('data-selection-id');
            let name = $(this).attr('data-selection-name');
            
            let form = $($('form.js-oxWidgetReload')[0]);
            form.append('<input type="hidden" name="'+name+'" value="'+id+'">');
            
            $("#zoomModal").remove();
            
            $.ajax({
                url: form.attr('action'),
                context: $('#details_container')[0],
                data: form.serialize(),
                dataType: 'html'
            }).done(function(html) {
                $(this).parent().html(html);
                return "undefined" != typeof WidgetsHandler && (
                    WidgetsHandler.reloadWidget("oxwarticledetails"), 
                    WidgetsHandler.reloadWidget("oxwrating"), 
                    WidgetsHandler.reloadWidget("oxwreview")
                );
            });
        });

    [{capture}]</script>[{/capture}]
[{/capture}]
[{oxscript add=$smarty.capture.rsscript}]


<div id="variants" class="container grid-striped"> 
                            
    [{assign var="blHasActiveSelections" value=false}]
    [{foreach from=$aVariantSelections.selections item=oList key=iKey}]
        [{if $oList->getActiveSelection()}]
            [{assign var="blHasActiveSelections" value=true}]
        [{/if}]
        
        [{assign var="oSelections" value=$oList->getSelections()}]
        [{if $oSelections}]
            
            [{assign var=bHasUnitPrice value=false}]
            [{foreach from=$oSelections item=oSelection}]
                [{assign var=id value=$oSelection->getValue()}]
                [{assign var=oProductVariant value=$oView->variantview_loadProduct($id)}]
                [{if $oProductVariant}]
                    [{assign var="oUnitPrice" value=$oProductVariant->getUnitPrice()}]
                    [{if $oUnitPrice}]
                        [{assign var=bHasUnitPrice value=true}]
                    [{/if}]
                [{/if}]
            [{/foreach}]
            
            <input type="hidden" name="[{$sFieldName|default:"varselid"}][[{$iKey}]]" value="[{if $oActiveSelection}][{$oActiveSelection->getValue()}][{/if}]">
            <div class="row header font-weight-bold py-2">
                <div class="col col-3">[{$oList->getLabel()}]</div>
                <div class="col col-3">[{oxmultilang ident="rs_variantview_table_header_price"}]</div>
                [{if $bHasUnitPrice}]
                    <div class="col col-3">[{oxmultilang ident="rs_variantview_table_header_price_unit"}]</div>
                    <div class="col col-3">[{oxmultilang ident="rs_variantview_table_header_delivery"}]</div>
                [{else}]
                    <div class="col col-6">[{oxmultilang ident="rs_variantview_table_header_delivery"}]</div>
                [{/if}]
            </div>

            [{foreach from=$oSelections item=oSelection}]
                [{assign var=id value=$oSelection->getValue()}]
                [{assign var=oProductVariant value=$oView->variantview_loadProduct($id)}]
                [{if $oProductVariant}]
                    
                    
                    [{*assign var=blBuyable value=false}]
                    [{if $oProductVariant->isBuyable()}]
                        [{assign var=blBuyable value=true}]
                    [{/if*}]
                    
                    <div class="rsvariantview-selection-row py-2 row content [{if $oSelection->isDisabled()}] disabled js-disabled[{/if}]"
                        data-selection-id="[{$id}]"
                        data-selection-name="[{$sFieldName|default:"varselid"}][[{$iKey}]]"
                         >
                        <div class="col title col-3">
                            <input type="radio" name="varselid_radio[]" value="[{$oSelection->getValue()}]" [{if $oSelection->isActive()}] checked [{/if}]">
                            [{$oSelection->getName()}]
                        </div>
                        <div class="col price col-3">

                            [{oxhasrights ident="SHOWARTICLEPRICE"}]
                                [{if $oProductVariant->getTPrice()}]
                                    <del class="price-old">[{oxprice price=$oProductVariant->getTPrice() currency=$currency}]</del>
                                    <br />
                                [{/if}]
                            [{/oxhasrights}]


                            [{oxhasrights ident="SHOWARTICLEPRICE"}]
                                [{block name="details_productmain_price_value"}]
                                    [{if $oProductVariant->getFPrice()}]
                                        <label id="productPrice" class="price-label">
                                            [{assign var="sFrom" value=""}]
                                            [{assign var="oPrice" value=$oProductVariant->getPrice()}]
                                            [{if $oProductVariant->isParentNotBuyable()}]
                                                [{assign var="oPrice" value=$oProductVariant->getVarMinPrice()}]
                                                [{if $oProductVariant->isRangePrice()}]
                                                    [{assign var="sFrom" value="PRICE_FROM"|oxmultilangassign}]
                                                [{/if}]
                                            [{/if}]
                                            <span[{if $oProductVariant->getTPrice()}] class="text-danger"[{/if}]>
                                                <span class="price-from">[{$sFrom}]</span>
                                                <span class="price">[{oxprice price=$oPrice currency=$currency}]</span>
                                                [{if $oView->isVatIncluded()}]
                                                    <span class="price-markup">*</span>
                                                [{/if}]
                                                <span class="d-none">
                                                    <span itemprop="price">[{oxprice price=$oPrice currency=$currency}]</span>
                                                </span>
                                            </span>
                                        </label>
                                    [{/if}]
                                    [{if $oProductVariant->loadAmountPriceInfo()}]
                                        [{include file="page/details/inc/priceinfo.tpl"}]
                                    [{/if}]
                                [{/block}]
                            [{/oxhasrights}]

                        </div>
                        [{if $bHasUnitPrice}]
                            <div class="col priceunit col-3">
                                [{assign var="oUnitPrice" value=$oProductVariant->getUnitPrice()}]
                                [{if $oUnitPrice}]
                                    [{oxprice price=$oUnitPrice currency=$currency}]/[{$oProductVariant->getUnitName()}]
                                [{/if}]
                            </div>
                        [{/if}]
                        <div class="col delivery [{if $bHasUnitPrice}]col-3[{else}]col-6[{/if}]">

                            [{if $oProductVariant->getStockStatus() == -1}]
                                <span class="stockFlag notOnStock">
                                    <i class="fa fa-circle text-danger"></i>
                                    [{if $oProductVariant->oxarticles__oxnostocktext->value}]
                                        <link itemprop="availability" href="http://schema.org/OutOfStock"/>
                                        [{$oProductVariant->oxarticles__oxnostocktext->value}]
                                    [{elseif $oViewConf->getStockOffDefaultMessage()}]
                                        <link itemprop="availability" href="http://schema.org/OutOfStock"/>
                                        [{oxmultilang ident="MESSAGE_NOT_ON_STOCK"}]
                                    [{/if}]
                                    [{if $oProductVariant->getDeliveryDate()}]
                                        <link itemprop="availability" href="http://schema.org/PreOrder"/>
                                        [{oxmultilang ident="AVAILABLE_ON"}] [{$oProductVariant->getDeliveryDate()}]
                                    [{/if}]
                                </span>
                            [{elseif $oProductVariant->getStockStatus() == 1}]
                                <link itemprop="availability" href="http://schema.org/InStock"/>
                                <span class="stockFlag lowStock">
                                    <i class="fa fa-circle text-warning"></i> [{oxmultilang ident="LOW_STOCK"}]
                                </span>
                            [{elseif $oProductVariant->getStockStatus() == 0}]
                                <span class="stockFlag">
                                    <link itemprop="availability" href="http://schema.org/InStock"/>
                                    <i class="fa fa-circle text-success"></i>
                                    [{if $oProductVariant->oxarticles__oxstocktext->value}]
                                        [{$oProductVariant->oxarticles__oxstocktext->value}]
                                    [{elseif $oViewConf->getStockOnDefaultMessage()}]
                                        [{oxmultilang ident="READY_FOR_SHIPPING"}]
                                    [{/if}]
                                </span>
                            [{/if}]

                        </div>
                    </div>
                [{/if}]
            [{/foreach}]
        [{/if}]
    [{/foreach}]
</div>


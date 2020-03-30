<?php

namespace rs\variantview\Application\Component\Widget;

use oxdb;

class ArticleDetails extends ArticleDetails_parent
{
    
    protected $_variantview_loadProduct=[];
    
    public function variantview_loadProduct($sSelId)
    {
        if(!isset($this->_variantview_loadProduct[$sSelId]))
        {
            $oCurrentProduct = $this->getProduct();

            $sParentId = $oCurrentProduct->oxarticles__oxparentid->value;
            if($sParentId==="")
                $sParentId = $oCurrentProduct->getId();

            $sTable = getViewName('oxarticles');
            $sSql="SELECT oxid FROM $sTable WHERE md5(oxvarselect)='$sSelId' and OXPARENTID='$sParentId'";
            $sOxid = oxDb::getDb(oxDB::FETCH_MODE_ASSOC)->getOne($sSql);

            $oProduct = oxNew(\OxidEsales\Eshop\Application\Model\Article::class);
            if (!$oProduct->load($sOxid)) {
                    $oProduct = null;
            }
            $this->_variantview_loadProduct[$sSelId] = $oProduct;
        }
        return $this->_variantview_loadProduct[$sSelId];
    }


    protected $_variantview_getRatingCount=null;

    public function getRatingCount()
    {
        $ret = parent::getRatingCount();

        if ($this->_variantview_getRatingCount === null) {
            $this->_variantview_getRatingCount = false;
            if ($this->isReviewActive() && ($oDetailsProduct = $this->getProduct())) {
                
                if($oParentProduct = $oDetailsProduct->getParentArticle())
                {
                    $oDetailsProduct=$oParentProduct;
                    $this->_variantview_getRatingCount = $oDetailsProduct->getArticleRatingCount(true);
                }
                else
                {
                    $this->_variantview_getRatingCount=$ret;
                }
            }
        }

        return $this->_variantview_getRatingCount;
    }
    
    protected $_variantview_getRatingValue=null;

    public function getRatingValue()
    {
        $ret = parent::getRatingValue();

        if ($this->_variantview_getRatingValue === null) {
            $this->_variantview_getRatingValue = (double) 0;
            if ($this->isReviewActive() && ($oDetailsProduct = $this->getProduct())) {

                if($oParentProduct = $oDetailsProduct->getParentArticle())
                {
                    $oDetailsProduct=$oParentProduct;
                    $this->_variantview_getRatingValue = round($oDetailsProduct->getArticleRatingAverage(true), 1);
                }
                else
                {
                    $this->_variantview_getRatingValue=$ret;
                }
            }
        }

        return (double) $this->_variantview_getRatingValue;
    }
}

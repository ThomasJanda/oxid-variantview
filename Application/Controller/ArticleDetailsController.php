<?php

namespace rs\variantview\Application\Controller;

class ArticleDetailsController extends ArticleDetailsController_parent
{
    /*
    protected $_rs_variantview_force_parent = false;
    
    public function saveReview()
    {
        $this->_rs_variantview_force_parent=true;
        
        $ret = parent::saveReview();
        
        $this->_rs_variantview_force_parent=false;

        return $ret;
    }
    
    
    public function getProduct()
    {
        $oProduct = parent::getProduct();

        if($this->_rs_variantview_force_parent && $oProduct)
        {
            if($oParentProduct = $oProduct->getParentArticle())
                $oProduct=$oParentProduct;
        }

        return $oProduct;
    }
     */
}

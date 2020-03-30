<?php

namespace rs\variantview\Application\Model;


class Article extends Article_parent
{
    public function getVariantSelections($aFilterIds = null, $sActVariantId = null, $iLimit = 0)
    {

        if(($sActVariantId===null || $sActVariantId==="") && $aFilterIds===null && $this->oxarticles__oxparent->value=="")
        {
            if($aVariants = $this->getVariants(false))
            {
                if(!is_array($aVariants))
                    $aVariants=$aVariants->getArray();
            
                $sActVariantId = key($aVariants);
            }
        }

        return parent::getVariantSelections($aFilterIds, $sActVariantId, $iLimit);
    }
}
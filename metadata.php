<?php

$sMetadataVersion = '2.0';

$aModule = array(
    'id'               => 'rs-variantview',
    'title'            => '*RS Display variants at the detail view as table',
    'description'      => '',
    'thumbnail'        => '',
    'version'          => '1.0.0',
    'author'           => '',
    'url'              => '',
    'email'            => '',
    'extend'           => array(
        \OxidEsales\Eshop\Application\Component\Widget\ArticleDetails::class => rs\variantview\Application\Component\Widget\ArticleDetails::class,
        \OxidEsales\Eshop\Application\Model\Article::class => rs\variantview\Application\Model\Article::class,
        \OxidEsales\Eshop\Application\Controller\ArticleDetailsController::class => rs\variantview\Application\Controller\ArticleDetailsController::class,
    ),
    'templates' => array(
        'productmain__details_productmain_variantselections.tpl' => 'rs/variantview/views/tpl/page/details/inc/productmain__details_productmain_variantselections.tpl',
    ),
    'blocks'      => array(
        array(
            'template' => 'page/details/inc/productmain.tpl',
            'block'    => 'details_productmain_variantselections',
            'file'     => '/views/blocks/page/details/inc/productmain__details_productmain_variantselections.tpl',
        ),
        array(
            'template' => 'page/details/inc/productmain.tpl',
            'block'    => 'details_productmain_tprice',
            'file'     => '/views/blocks/page/details/inc/productmain__details_productmain_tprice.tpl',
        ),
        array(
            'template' => 'page/details/inc/productmain.tpl',
            'block'    => 'details_productmain_price',
            'file'     => '/views/blocks/page/details/inc/productmain__details_productmain_price.tpl',
        ),
        array(
            'template' => 'page/details/inc/productmain.tpl',
            'block'    => 'details_productmain_stockstatus',
            'file'     => '/views/blocks/page/details/inc/productmain__details_productmain_stockstatus.tpl',
        ),
        array(
            'template' => 'page/details/inc/productmain.tpl',
            'block'    => 'details_productmain_priceperunit',
            'file'     => '/views/blocks/page/details/inc/productmain__details_productmain_priceperunit.tpl',
        ),

    ),
);

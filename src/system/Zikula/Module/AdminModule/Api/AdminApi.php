<?php
/**
 * Copyright Zikula Foundation 2009 - Zikula Application Framework
 *
 * This work is contributed to the Zikula Foundation under one or more
 * Contributor Agreements and licensed to You under the following license:
 *
 * @license GNU/LGPLv3 (or at your option, any later version).
 * @copyright Zikula Foundation
 * @package Zikula
 * @subpackage ZikulaAdminModule
 *
 * Please see the NOTICE file distributed with this source code for further
 * information regarding copyright and licensing.
 */

namespace Zikula\Module\AdminModule\Api;

use ModUtil;
use Zikula\Module\AdminModule\Entity\AdminCategoryEntity;
use SecurityUtil;
use System;
use DataUtil;
use Symfony\Component\HttpKernel\Exception\AccessDeniedHttpException;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

/**
 * API functions used by administrative controllers
 *
 */
class AdminApi extends \Zikula_AbstractApi
{
    /**
     * create an admin category
     *
     * @param mixed[] $args {<ul>
     *      <li>@type string $name        name of the category</li>
     *      <li>@type string $description description of the category</li>
     *                       </ul>}
     *
     * @return int|bool admin category ID on success, false on failure
     *
     * @throws \InvalidArgumentException Thrown if invalid parameters are received in $args
     */
    public function create($args)
    {
        // Argument check
        if (!isset($args['name']) || !strlen($args['name']) ||
            !isset($args['description'])) {
            throw new \InvalidArgumentException(__('Invalid arguments array received'));
        }

        $args['sortorder'] = ModUtil::apiFunc('ZikulaAdminModule', 'admin', 'countitems');

        $item = new AdminCategoryEntity();
        $item->merge($args);
        $this->entityManager->persist($item);
        $this->entityManager->flush();

        // Return the id of the newly created item to the calling process
        return $item['cid'];
    }

    /**
     * update an admin category
     *
     * @param mixed[] $args {<ul>
     *      <li>@type int    $cid         the ID of the category</li>
     *      <li>@type string $name        the new name of the category</li>
     *      <li>@type string $description the new description of the category</li>
     *                       </ul>}
     *
     * @return bool true on success, false on failure
     *
     * @throws \InvalidArgumentException Thrown if invalid parameters are received in $args
     * @throws Symfony\Component\HttpKernel\Exception\NotFoundHttpException Thrown if item to be updated isn't found
     * @throws Symfony\Component\HttpKernel\Exception\AccessDeniedHttpException Thrown if the user doesn't have permission to update the item
     */
    public function update($args)
    {
        // Argument check
        if (!isset($args['cid']) || !is_numeric($args['cid']) ||
            !isset($args['name']) || !strlen($args['name']) ||
            !isset($args['description'])) {
            throw new \InvalidArgumentException(__('Invalid arguments array received'));
        }

        // Get the existing item
        $item = ModUtil::apiFunc('ZikulaAdminModule', 'admin', 'get', array('cid' => $args['cid']));

        if (empty($item)) {
            throw new NotFoundHttpException($this->__('Sorry! No such item found.'));
        }

        // Security check (old item)
        if (!SecurityUtil::checkPermission('ZikulaAdminModule::Category', "$item[name]::$args[cid]", ACCESS_EDIT)) {
            throw new AccessDeniedHttpException();
        }

        $item->merge($args);
        $this->entityManager->flush();

        // Let the calling process know that we have finished successfully
        return true;
    }

    /**
     * delete an admin category
     *
     * @param  int[] $args {<ul>
     *      <li>@type int $args['cid'] ID of the category</li>
     *                      </ul>}
     *
     * @return bool true on success, false on failure
     *
     * @throws \InvalidArgumentException Thrown if invalid parameters are received in $args
     * @throws Symfony\Component\HttpKernel\Exception\NotFoundHttpException Thrown if item to be updated isn't found
     * @throws \RuntimeException Thrown if the category to be deleted is the default for new modules or 
     *                                  if the category to be deleted is the initial category to be displayed
     */
    public function delete($args)
    {
        if (!isset($args['cid']) || !is_numeric($args['cid'])) {
            throw new \InvalidArgumentException(__('Invalid arguments array received'));
        }

        $item = ModUtil::apiFunc('ZikulaAdminModule', 'admin', 'get', array('cid' => $args['cid']));
        if (empty($item)) {
            throw new NotFoundHttpException($this->__('Sorry! No such item found.'));
        }

        // Avoid deletion of the default category
        $defaultcategory = $this->getVar('defaultcategory');
        if ($item['cid'] == $defaultcategory) {
            throw new \RuntimeException($this->__('Error! You cannot delete the default module category used in the administration panel.'));
        }

        // Avoid deletion of the start category
        $startcategory = $this->getVar('startcategory');
        if ($item['cid'] == $startcategory) {
            throw new \RuntimeException($this->__('Error! This module category is currently set as the category that is initially displayed when you visit the administration panel. You must first select a different category for initial display. Afterwards, you will be able to delete the category you have just attempted to remove.'));
        }

        // move all modules from the category to be deleted into the
        // default category.
        $query = $this->entityManager->createQueryBuilder()
                                     ->update('Zikula\Module\AdminModule\Entity\AdminModuleEntity', 'm')
                                     ->set('m.cid', $defaultcategory)
                                     ->where('m.cid = :cid')
                                     ->setParameter('cid', $item['cid'])
                                     ->getQuery();

        $query->getResult();

        // Now actually delete the category
        $this->entityManager->remove($item);
        $this->entityManager->flush();

        // Let the calling process know that we have finished successfully
        return true;
    }

    /**
     * get all admin categories
     *
     * @param int[] $args {<ul>
     *      <li>@type int $startnum starting record number</li>
     *      <li>@type int $numitems number of items to get</li>
     *                     </ul>}
     *
     * @return array|bool array of items, or false on failure
     */
    public function getall($args)
    {
        // Optional arguments.
        if (!isset($args['startnum']) || !is_numeric($args['startnum'])) {
            $args['startnum'] = null;
        }
        if (!isset($args['numitems']) || !is_numeric($args['numitems'])) {
            $args['numitems'] = null;
        }

        $items = array();

        // Security check
        if (!SecurityUtil::checkPermission('ZikulaAdminModule::', '::', ACCESS_READ)) {
            return $items;
        }

        $entity = 'Zikula\Module\AdminModule\Entity\AdminCategoryEntity';
        $items = $this->entityManager->getRepository($entity)->findBy(array(), array('sortorder' => 'ASC'), $args['numitems'], $args['startnum']);

        return $items;
    }

    /**
     * utility function to count the number of items held by this module
     *
     * @return int number of items held by this module
     */
    public function countitems()
    {
        $query = $this->entityManager->createQueryBuilder()
                                     ->select('count(c.cid)')
                                     ->from('Zikula\Module\AdminModule\Entity\AdminCategoryEntity', 'c')
                                     ->getQuery();

        return (int)$query->getSingleScalarResult();;
    }

    /**
     * get a specific category
     *
     * @param int[] $args {<ul>
     *      <li>@type int $cid id of example item to get</li>
     *                     </ul>}
     *
     * @return array|bool item array, or false on failure
     *
     * @throws \InvalidArgumentException Thrown if invalid parameters are received in $args
     */
    public function get($args)
    {
        // Argument check
        if (!isset($args['cid']) ||!is_numeric($args['cid'])) {
            throw new \InvalidArgumentException(__('Invalid arguments array received'));
        }

        // retrieve the category object
        $entity = 'Zikula\Module\AdminModule\Entity\AdminCategoryEntity';
        $category = $this->entityManager->getRepository($entity)->findOneBy(array('cid' => (int)$args['cid']));

        if (!$category) {
            return array();
        }

        // Return the item array
        return $category;
    }

    /**
     * add a module to a category
     *
     * @param mixed[] $args {<ul>
     *      <li>@type  string $module   name of the module</li>
     *      <li>@type  int    $category number of the category</li>
     *                       </ul>}
     *
     * @return int|bool admin category ID on success, false on failure
     *
     * @throws \InvalidArgumentException Thrown if invalid parameters are received in $args
     * @throws Symfony\Component\HttpKernel\Exception\AccessDeniedHttpException Thrown if the user doesn't have permission to add the category
     */
    public function addmodtocategory($args)
    {
        if (!isset($args['module']) ||
            (!isset($args['category']) || !is_numeric($args['category']))) {
            throw new \InvalidArgumentException(__('Invalid arguments array received'));
        }

        // this function is called durung the init process so we have to check in installing
        // is set as alternative to the correct permission check
        if (!System::isInstalling() && !SecurityUtil::checkPermission('ZikulaAdminModule::Category', "::", ACCESS_ADD)) {
            throw new AccessDeniedHttpException();
        }

        $entity = 'Zikula\Module\AdminModule\Entity\AdminModuleEntity';

        // get module id
        $mid = (int)ModUtil::getIdFromName($args['module']);

        $item = $this->entityManager->getRepository($entity)->findOneBy(array('mid' => $mid));
        if (!$item) {
            $item = new $entity;
        }

        $values = array();
        $values['cid'] = (int)$args['category'];
        $values['mid'] = $mid;
        $values['sortorder'] = ModUtil::apiFunc('ZikulaAdminModule', 'admin', 'countModsInCat', array('cid' => $args['category']));

        $item->merge($values);
        $this->entityManager->persist($item);
        $this->entityManager->flush();

        // Return success
        return true;
    }

    /**
     * Get the category a module belongs to
     *
     * @param int[] $args {<ul>
     *      <li>@type int $mid id of the module</li>
     *                     </ul>}
     *
     * @return int|false category id, or false on failure
     *
     * @throws \InvalidArgumentException Thrown if invalid parameters are received in $args
     */
    public function getmodcategory($args)
    {
        // create a static result set to prevent multiple sql queries
        static $catitems = array();

        // Argument check
        if (!isset($args['mid']) || !is_numeric($args['mid'])) {
            throw new \InvalidArgumentException(__('Invalid arguments array received'));
        }

        // check if we've already worked this query out
        if (isset($catitems[$args['mid']])) {
            return $catitems[$args['mid']];
        }

        $entity = 'Zikula\Module\AdminModule\Entity\AdminModuleEntity';

        // retrieve the admin module object array
        $associations = $this->entityManager->getRepository($entity)->findAll();
        if (!$associations) {
            return false;
        }

        foreach ($associations as $association) {
            $catitems[$association['mid']] = $association['cid'];
        }

        // Return the category id
        if (isset($catitems[$args['mid']])) {
            return $catitems[$args['mid']];
        }

        return false;
    }

    /**
     * Get the sort order of a module
     *
     * @param int[] $args {<ul>
     *      <li>@type int $mid id of the module</li>
     *                     </ul>}
     *
     * @return int|bool category id, or false on failure
     *
     * @throws \InvalidArgumentException Thrown if invalid parameters are received in $args
     */
    public function getSortOrder($args)
    {
        // Argument check
        if (!isset($args['mid']) || !is_numeric($args['mid'])) {
            throw new \InvalidArgumentException(__('Invalid arguments array received'));
        }

        static $associations = array();

        if (empty($associations)) {
            $associations = $this->entityManager->getRepository('Zikula\Module\AdminModule\Entity\AdminModuleEntity')->findAll();
        }

        $sortorder = -1;
        foreach ($associations as $association) {
            if ($association['mid'] == (int)$args['mid']) {
                $sortorder = $association['sortorder'];
                break;
            }
        }

        if ($sortorder >= 0) {
            return $sortorder;
        } else {
            return false;
        }
    }

    /**
     * Get the category a module belongs to
     *
     * @param int[] $args {<ul>
     *      <li>@type int $mid id of the module</li>
     *                     </ul>}
     *
     * @return array|bool array of styles if successful, or false on failure
     *
     * @throws \InvalidArgumentException Thrown if invalid parameters are received in $args
     */
    public function getmodstyles($args)
    {
        // check our input and get the module information
        if (!isset($args['modname']) ||
            !is_string($args['modname']) ||
            !is_array($modinfo = ModUtil::getInfoFromName($args['modname']))) {
            throw new \InvalidArgumentException(__('Invalid arguments array received'));
        }

        if (!isset($args['exclude']) || !is_array($args['exclude'])) {
            $args['exclude'] = array();
        }

        // create an empty result set
        $styles = array();

        $osmoddir = DataUtil::formatForOS($modinfo['directory']);
        $base = ($modinfo['type'] == ModUtil::TYPE_SYSTEM) ? 'system' : 'modules';

        $mpath = ModUtil::getModuleRelativePath($modinfo['name']);
        if ($mpath) {
            $path = $mpath.'/Resources/public/css';
        }

        if ((isset($path) && is_dir($dir = $path)) || is_dir($dir = "$base/$osmoddir/style") || is_dir($dir = "$base/$osmoddir/pnstyle")) {
            $handle = opendir($dir);
            while (false !== ($file = readdir($handle))) {
                if (stristr($file, '.css') && !in_array($file, $args['exclude'])) {
                    $styles[] = $file;
                }
            }
        }

        // return our results
        return $styles;
    }

    /**
     * get available admin panel links
     *
     * @return array array of admin links
     */
    public function getlinks()
    {
        $links = array();

        if (SecurityUtil::checkPermission('ZikulaAdminModule::', '::', ACCESS_READ)) {
            $links[] = array('url' => ModUtil::url('ZikulaAdminModule', 'admin', 'view'), 'text' => $this->__('Module categories list'), 'icon' => 'list');
        }
        if (SecurityUtil::checkPermission('ZikulaAdminModule::', '::', ACCESS_ADD)) {
            $links[] = array('url' => ModUtil::url('ZikulaAdminModule', 'admin', 'newcat'), 'text' => $this->__('Create new module category'), 'icon' => 'plus');
        }
        if (SecurityUtil::checkPermission('ZikulaAdminModule::', '::', ACCESS_ADMIN)) {
            $links[] = array('url' => ModUtil::url('ZikulaAdminModule', 'admin', 'help'), 'text' => $this->__('Help'), 'icon' => 'info');
            $links[] = array('url' => ModUtil::url('ZikulaAdminModule', 'admin', 'modifyconfig'), 'text' => $this->__('Settings'), 'icon' => 'wrench');
        }

        return $links;
    }

    /**
     * count modules in a given category
     *
     * @param int[] $args {<ul>
     *      <li>@type int $cid id of the category</li>
     *                     </ul>}
     *
     * @return int   number of modules
     *
     * @throws \InvalidArgumentException Thrown if invalid parameters are received in $args
     */
    public function countModsInCat($args)
    {
        if (!isset($args['cid']) || !is_numeric($args['cid'])) {
            throw new \InvalidArgumentException(__('Invalid arguments array received'));
        }

        $query = $this->entityManager->createQueryBuilder()
                                     ->select('count(m.amid)')
                                     ->from('Zikula\Module\AdminModule\Entity\AdminModuleEntity', 'm')
                                     ->where('m.cid = :cid')
                                     ->setParameter('cid', $args['cid'])
                                     ->getQuery();

        return (int)$query->getSingleScalarResult();
    }
}

<?php

/*
 * This file is part of the Zikula package.
 *
 * Copyright Zikula Foundation - http://zikula.org/
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

/**
 * Display an existing Zikula block.
 *
 *  The block is choosen by its id.
 *  The block state is ignored, so even deactivated blocks can be shown.
 *  The parameters specific to the block can be overridden.
 *
 * Available parameters:
 *  - id        (numeric)   ID of the block to be displayed
 *  - name      (string)    Name of the block to be displayed (not used)
 *  - title     (string)    Overrides the block title
 *  - position  (string)    Overrides the block position
 *  - assign    (string)    The name of a template variable to which the output
 *                          of the block is assigned, instead of sending the
 *                          output to the template (optional)
 * - Any additional parameters are passed to the block as block variables,
 *   overriding any existing values.
 *
 * Examples:
 *
 * Insert the block with block ID (bid) 4 at the current position in the template
 *
 * <samp>{block id=4}</samp>
 *
 * Insert the block with block ID (bid) 5 at the current position in the
 * template, overriding the block's title.
 *
 * <samp>{block id=5 title='My Block 5'}</samp>
 *
 * Store the output generated by retrieving the block with ID 6 in the template
 * variable $myBlockContents.
 *
 * <samp>{block id=6 assign='myBlockContents'}</samp>
 *
 * @param array       $params All attributes passed to this function from the template
 * @param Zikula_View $view   Reference to the {@link Zikula_View} object
 *
 * @return string The block
 *
 * @todo the attribute 'name' is not used
 */
function smarty_function_block($params, Zikula_View $view)
{
    $bid      = isset($params['bid']) ? (int)$params['bid'] : 0;
    $name     = isset($params['name']) ? $params['name'] : null;
    $title    = isset($params['title']) ? $params['title'] : null;
    $position = isset($params['position']) ? $params['position'] : null;
    $assign   = isset($params['assign']) ? $params['assign'] : null;

    // unset the variables for the function, leaving the ones for the block
    unset($params['bid']);
    unset($params['name']);
    unset($params['title']);
    unset($params['position']);
    unset($params['assign']);

    if (!$bid) {
        $view->trigger_error(__f('Error! in %1$s: the %2$s parameter must be specified.', ['block', 'bid']));

        return false;
    }

    //  render the block
    $blockinfo = BlockUtil::getBlockInfo($bid);

    // overwrite block title
    if ($title) {
        $blockinfo['title'] = $title;
    }

    if ($position) {
        $blockinfo['position'] = $position;
    }

    $blockinfo['bid'] = $bid; // bid is not return by BlockGetInfo.

    // Overwrite block specific config vars.
    // Only the new style is supported.
    if (count($params) > 0) {
        $_vars = BlockUtil::varsFromContent($blockinfo['content']);
        $_vars = array_merge($_vars, $params);
        $blockinfo['content'] = BlockUtil::varsToContent($_vars);
    }

    // We need the module name.
    $modinfo = ModUtil::getInfo($blockinfo['module']->getId());
    if (!is_array($modinfo) || !isset($modinfo['name'])) {
        $modinfo = ['name' => 'core'];
    }

    // show the block and capture its contents
    $content = BlockUtil::show($modinfo['name'], $blockinfo['bkey'], $blockinfo);

    if ($assign) {
        $view->assign($assign, $content);
    } else {
        return $content;
    }
}

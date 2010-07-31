<a id="defwindow" title="{gt text='Settings'}" class="btn ui-state-default ui-corner-all" href="#defwindow_content">
	<span class="ui-icon ui-icon-wrench">&nbsp;</span>
		{gt text='Settings'}
</a>
<a class="btn ui-state-default ui-corner-all" href="#">
	<span class="ui-icon ui-icon-person">&nbsp;</span>
		{gt text='My Account'}
</a>
<a class="btn ui-state-default ui-corner-all" href="{modurl modname=users type=user func=logout}">
    <span class="ui-icon ui-icon-power">&nbsp;</span>
		{gt text='Logout'}
</a>
						
<div id="defwindow_content" style="display: none;">
	<div class="side_sort sidebar-content">
		<div>
			 
				<div class="portlet ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">
					<div class="portlet-header ui-widget-header ui-corner-all">{gt text='Sidebar Position'}<span class="ui-icon ui-icon-circle-arrow-s">&nbsp;</span></div>
						<div class="portlet-content">
						    <ul class="sidebar-position">
								<li class="float-left">
									<a title="{gt text='Sidebar left'}" id="sidebar-left" href="javascript:void(0);" class="btn ui-state-default ui-corner-all">
										<span class="ui-icon ui-icon ui-icon-arrowthick-1-w">&nbsp;</span>
											{gt text='Sidebar left'}
									</a>
								</li>
								<li class="float-right">
									<a title="{gt text='Sidebar right'}" id="sidebar-right" href="javascript:void(0);" class="btn ui-state-default ui-corner-all">
										<span class="ui-icon ui-icon ui-icon-arrowthick-1-e">&nbsp;</span>
											{gt text='Sidebar right'}
									</a>
									</li>
							</ul>
						</div>
				</div>
		</div>
		<div class="portlet ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">
			<div class="portlet-header ui-widget-header ui-corner-all">{gt text='Theme Switcher'}<span class="ui-icon ui-icon-circle-arrow-s">&nbsp;</span></div>
				<div class="portlet-content">
					<ul id="style-switcher" class="side-menu">
						<li>
							<a class="set_theme" id="black" href="#" title="{gt text='Black'}">{gt text='Black'}</a>
						</li>
						<li>
							<a class="set_theme" id="gray" href="#" title="{gt text='Gray Standard'}">{gt text='Gray Standard'} </a>
						</li>
						<li>
							<a class="set_theme" id="gray_light" href="#" title="{gt text='Light Gray'}">{gt text='Light Gray'}</a>
						</li>
						<li>
							<a class="set_theme" id="green" href="#" title="{gt text='Green'}">{gt text='Green'}</a>
						</li>
						<li>
							<a class="set_theme" id="blue" href="#" title="{gt text='Blue'}">{gt text='Blue'}</a>
					    </li>
						<li>
							<a class="set_theme" id="hot" href="#" title="{gt text='Hot'}">{gt text='Hot'}</a>
						</li>
					</ul>
				</div>
		</div>
		<div class="portlet ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">
			<div class="portlet-header ui-widget-header ui-corner-all">{gt text='Change width'}<span class="ui-icon ui-icon-circle-arrow-s">&nbsp;</span></div>
				<div class="portlet-content">
					<ul class="side-menu layout-options">
						<li>
							<a href="javascript:void(0);" title="#"><strong>100%</strong> {gt text='width'}</a>
						</li>
						<li>
							<a href="javascript:void(0);" id="layout90" title="#"><strong>90%</strong> {gt text='width'}</a>
						</li>
						<li>
							<a href="javascript:void(0);" id="layout75" title="#"><strong>75%</strong> {gt text='width'}</a>
						</li>
						<li>
							<a href="javascript:void(0);" id="layout980" title="#"><strong>980px</strong> {gt text='width'}</a>
						</li>
						<li>
							<a href="javascript:void(0);" id="layout1280" title="#"><strong>1280px</strong> {gt text='width'}</a>
						</li>
						<li>
							<a href="javascript:void(0);" id="layout1400" title="#"><strong>1400px</strong> {gt text='width'}</a>
						</li>
						<li>
							<a href="javascript:void(0);" id="layout1600" title="Switch to 1600px layout"><strong>1600px</strong> {gt text='width'}</a>
						</li>
					</ul>
				</div>
		</div>
	</div>
</div>
<script type="text/javascript">
    var defwindow = new Zikula.UI.Window($('defwindow'));
</script>


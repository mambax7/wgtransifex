<{include file='db:wgtransifex_header.tpl' }>

<!-- Start index list -->
<table>
	<thead>
		<tr class='center'>
			<th><{$smarty.const._MA_WGTRANSIFEX_TITLE}>  -  <{$smarty.const._MA_WGTRANSIFEX_DESC}></th>
		</tr>
	</thead>
	<tbody>
		<tr class='center'>
			<td class='bold pad5'>
				<ul class='menu text-center'>
					<li><a href='<{$wgtransifex_url}>'><{$smarty.const._MA_WGTRANSIFEX_INDEX}></a></li>
					<li><a href='<{$wgtransifex_url}>/packages.php'><{$smarty.const._MA_WGTRANSIFEX_PACKAGES}></a></li>
				</ul>
			</td>
		</tr>
	</tbody>
	<tfoot>
		<tr class='center'>
			<td class='bold pad5'>
				<{if $adv}><{$adv}><{/if}>
			</td>
		</tr>
	</tfoot>
</table>
<!-- End index list -->

<{if $displaySingle}>
	<div class='wgtransifex-linetitle'><{$smarty.const._MA_WGTRANSIFEX_INDEX_LATEST_LIST}></div>
	<{if $packagesCount > 0}>
		<!-- Start show new packages in index -->
		<table class='table table-<{$table_type}>'>
			<tr>
				<!-- Start new link loop -->
				<{section name=i loop=$packages}>
					<td class='col_width<{$numb_col}> top center'>
						<{include file='db:wgtransifex_packages_list.tpl' package=$packages[i]}>
					</td>
					<{if $packages[i].count is div by $divideby}>
						</tr><tr>
					<{/if}>
				<{/section}>
				<!-- End new link loop -->
			</tr>
		</table>
	<{/if}>
<{/if}>

<{if $displayCollection}>
	<div class='wgtransifex-linetitle'><{$smarty.const._MA_WGTRANSIFEX_INDEX_LATEST_LIST}></div>
	<{if $projectsCount > 0}>
		<table class='table table-<{$table_type}>'>
			<tr>
				<!-- Start new link loop -->
				<{foreach item=packages from=$packagesList}>
				<td class='col_width<{$numb_col}> top center'>
					<{include file='db:wgtransifex_packages_prolist.tpl' packages=$packages}>
				</td>
				<{if $packages.count is div by $divideby}>
			</tr><tr>
				<{/if}>
				<{/foreach}>
				<!-- End new link loop -->
			</tr>
		</table>
	<{/if}>
<{/if}>
<{include file='db:wgtransifex_footer.tpl' }>

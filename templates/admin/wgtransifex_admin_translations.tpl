<!-- Header -->
<{include file='db:wgtransifex_admin_header.tpl' }>

<{if $projects_list}>
	<table class='table table-bordered'>
		<thead>
		<tr class='head'>
			<th class="center"><{$smarty.const._AM_WGTRANSIFEX_PROJECT_ID}></th>
			<th class="center"><{$smarty.const._AM_WGTRANSIFEX_PROJECT_NAME}></th>
			<th class="center"><{$smarty.const._AM_WGTRANSIFEX_PROJECT_STATUS}></th>
			<th class="center"><{$smarty.const._AM_WGTRANSIFEX_RESOURCES_NB}></th>
			<th class="center"><{$smarty.const._AM_WGTRANSIFEX_TRANSLATIONS_NB}></th>
			<th class="center"><{$smarty.const._AM_WGTRANSIFEX_PROJECT_DATE}></th>
			<th class="center width10"><{$smarty.const._AM_WGTRANSIFEX_FORM_ACTION}></th>
		</tr>
		</thead>
		<tbody>
		<{foreach item=project from=$projects_list}>
			<tr class='<{cycle values='odd, even'}>'>
				<td class='center'><{$project.id}></td>
				<td class='center'><{$project.name}></td>
				<td class='center'><img src="<{$modPathIcon32}>status<{$project.status}>.png" alt="<{$project.status_text}>" title="<{$project.status_text}>" /></td>
				<td class='center'><{$project.resources}></td>
				<td class='center'><{$project.translations}></td>
				<td class='center'><{$project.date}></td>
				<td class='center width20'>
					<{foreach item=language from=$project.languages}>
						<a href="translations.php?op=list&amp;tra_pro_id=<{$project.id}>&amp;tra_lang_id=<{$language.id}>" title="<{$smarty.const._AM_WGTRANSIFEX_TRANSLATIONS_SHOW}>">
							<img src="<{$modPathIcon16}>translations.png" alt="<{$smarty.const._AM_WGTRANSIFEX_TRANSLATIONS_SHOW}>" />&nbsp;<{$smarty.const._AM_WGTRANSIFEX_TRANSLATIONS_SHOW}> <{$language.name}></a><br>
					<{/foreach}>
				</td>
			</tr>
			<{/foreach}>
		</tbody>
	</table>
	<div class="clear">&nbsp;</div>
	<{if $pagenav}>
	<div class="xo-pagenav floatright"><{$pagenav}></div>
	<div class="clear spacer"></div>
	<{/if}>
<{/if}>

<{if $translations_list}>
	<table class='table table-bordered'>
		<thead>
			<tr class='head'>
				<th class="center"><{$smarty.const._AM_WGTRANSIFEX_TRANSLATION_ID}></th>
				<th class="center"><{$smarty.const._AM_WGTRANSIFEX_TRANSLATION_PRO_ID}></th>
				<th class="center"><{$smarty.const._AM_WGTRANSIFEX_TRANSLATION_RES_ID}></th>
				<th class="center"><{$smarty.const._AM_WGTRANSIFEX_TRANSLATION_LANG_ID}></th>
				<th class="center"><{$smarty.const._AM_WGTRANSIFEX_TRANSLATION_MIMETYPE}></th>
				<th class="center"><{$smarty.const._AM_WGTRANSIFEX_TRANSLATION_STATS}></th>
				<th class="center"><{$smarty.const._AM_WGTRANSIFEX_TRANSLATION_LOCAL}></th>
				<th class="center"><{$smarty.const._AM_WGTRANSIFEX_TRANSLATION_STATUS}></th>
				<th class="center"><{$smarty.const._AM_WGTRANSIFEX_TRANSLATION_DATE}></th>
				<th class="center"><{$smarty.const._AM_WGTRANSIFEX_TRANSLATION_SUBMITTER}></th>
				<th class="center width5"><{$smarty.const._AM_WGTRANSIFEX_FORM_ACTION}></th>
			</tr>
		</thead>
		<{if $translations_count}>
		<tbody>
			<{foreach item=translation from=$translations_list}>
			<tr class='<{cycle values='odd, even'}>'>
				<td class='center'><{$translation.id}></td>
				<td class='center'><{$translation.pro_id}></td>
				<td class='center'><{$translation.res_id}></td>
				<td class='center'><{$translation.lang_id}></td>
				<td class='center'><{$translation.mimetype}></td>
				<td class='center'>
					<{$smarty.const._AM_WGTRANSIFEX_TRANSLATION_REVIEWED}>: <{$translation.reviewed}> (<{$translation.reviewed_percentage}>%)<br>
					<{$smarty.const._AM_WGTRANSIFEX_TRANSLATION_TRANSLATED_WORDS}>: <{$translation.translated_words}><br>
					<{$smarty.const._AM_WGTRANSIFEX_TRANSLATION_UNTRANSLATED_WORDS}>: <{$translation.untranslated_words}><br>
					<{$smarty.const._AM_WGTRANSIFEX_TRANSLATION_TRANSLATED_ENT}>: <{$translation.translated_entities}><br>
					<{$smarty.const._AM_WGTRANSIFEX_TRANSLATION_UNTRANSLATED_ENT}>: <{$translation.untranslated_entities}><br>
					<{$smarty.const._AM_WGTRANSIFEX_TRANSLATION_LAST_UPDATE}>: <{$translation.last_update}><br>
					<{$smarty.const._AM_WGTRANSIFEX_TRANSLATION_COMPLETED}>: <{$translation.completed}><br>
				</td>
				<td class='center'><{$translation.local}></td>
				<td class='center'><img src="<{$modPathIcon32}>status<{$translation.status}>.png" alt="<{$translation.status_text}>" title="<{$translation.status_text}>" /></td>
				<td class='center'><{$translation.date}></td>
				<td class='center'><{$translation.submitter}></td>
				<td class="center  width5">
					<a href="translations.php?op=savetx&amp;tra_id=<{$translation.id}>&amp;tra_pro_id=<{$translation.tra_pro_id}>&amp;tra_res_id=<{$translation.tra_res_id}>&amp;tra_lang_id=<{$translation.tra_lang_id}>" title="<{$smarty.const._AM_WGTRANSIFEX_READTX_TRANSLATION}>"><img src="<{$modPathIcon16}>readtx.png" alt="<{$smarty.const._AM_WGTRANSIFEX_READTX_TRANSLATION}>" /></a>
					<a href="translations.php?op=edit&amp;tra_id=<{$translation.id}>" title="<{$smarty.const._EDIT}>"><img src="<{xoModuleIcons16 edit.png}>" alt="<{$smarty.const._EDIT}> translations" /></a>
					<a href="translations.php?op=delete&amp;tra_id=<{$translation.id}>" title="<{$smarty.const._DELETE}>"><img src="<{xoModuleIcons16 delete.png}>" alt="<{$smarty.const._DELETE}> translations" /></a>
				</td>
			</tr>
			<{/foreach}>
		</tbody>
		<{/if}>
	</table>
	<div class="clear">&nbsp;</div>
	<{if $pagenav}>
		<div class="xo-pagenav floatright"><{$pagenav}></div>
		<div class="clear spacer"></div>
	<{/if}>
<{/if}>
<{if $form}>
	<{$form}>
<{/if}>
<{if $error}>
	<div class="errorMsg"><strong><{$error}></strong></div>
<{/if}>

<!-- Footer -->
<{include file='db:wgtransifex_admin_footer.tpl' }>

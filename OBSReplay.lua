--[[
OBSReplay.lua - Github.com/Kyagara/obsreplay

This OBS studio script moves recordings, replays and screenshots to a folder named after the current scene.

Based on OBSPlay by Kwozy.
]]

local output_path = obslua.obs_frontend_get_current_record_output_path()
local output_path_prop_key = "output_path"

local REPLAY_EVENT = 0
local RECORDING_EVENT = 1
local SCREENSHOT_EVENT = 2

---------- OBS Functions ----------

function script_description()
	return [[
	<h2>OBS Replay</h2>
	<p>
	Moves recordings, replays and screenshots to a folder named after the current scene.
	</p>
	<p>
	Based on <a href="https://obsproject.com/forum/resources/obsplay-nvidia-shadowplay-alternative.1326/">OBSPlay</a> by <a href="https://obsproject.com/forum/members/kwozy.337414/">Kwozy</a>.
	</p>
]]
end

function script_load()
	obslua.obs_frontend_add_event_callback(obs_frontend_callback)
end

function obs_frontend_callback(callback, _private_data)
	if callback == obslua.OBS_FRONTEND_EVENT_REPLAY_BUFFER_SAVED then
		save(REPLAY_EVENT)
	elseif callback == obslua.OBS_FRONTEND_EVENT_RECORDING_STOPPED then
		save(RECORDING_EVENT)
	elseif callback == obslua.OBS_FRONTEND_EVENT_SCREENSHOT_TAKEN then
		save(SCREENSHOT_EVENT)
	end
end

function script_properties()
	local prop = obslua.obs_properties_create()
	obslua.obs_properties_add_path(prop, output_path_prop_key, "Output path:",
		obslua.OBS_PATH_DIRECTORY,
		nil,
		nil
	)

	return prop
end

function script_update(settings)
	output_path = obslua.obs_data_get_string(settings, output_path_prop_key)
end

function script_defaults(settings)
	obslua.obs_data_set_default_string(settings, output_path_prop_key, output_path)
end

---------- OBS Functions ----------

function save(event)
	local latest_file_path = ""

	if event == REPLAY_EVENT then
		latest_file_path = obslua.obs_frontend_get_last_replay()
	elseif event == RECORDING_EVENT then
		latest_file_path = obslua.obs_frontend_get_last_recording()
	elseif event == SCREENSHOT_EVENT then
		latest_file_path = obslua.obs_frontend_get_last_screenshot()
	end

	if latest_file_path ~= nil then
		local current_scene_name = get_current_scene_name()

		local new_file_name = current_scene_name .. " " .. latest_file_path:match(".*[/](.-)$")
		local scene_folder_path = output_path .. '\\' .. current_scene_name

		if not obslua.os_file_exists(scene_folder_path) then
			obslua.os_mkdir(scene_folder_path)
		end

		obslua.os_rename(latest_file_path, scene_folder_path .. '\\' .. new_file_name)
	end
end

function get_current_scene_name()
	local current_scene = obslua.obs_frontend_get_current_scene()
	local name = obslua.obs_source_get_name(current_scene)
	obslua.obs_source_release(current_scene)
	return name
end

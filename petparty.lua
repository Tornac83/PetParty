--[[
* Ashita - Copyright (c) 2014 - 2016 atom0s [atom0s@live.com]
*
* This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
* To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/ or send a letter to
* Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
*
* By using Ashita, you agree to the above license and its terms.
*
*      Attribution - You must give appropriate credit, provide a link to the license and indicate if changes were
*                    made. You must do so in any reasonable manner, but not in any way that suggests the licensor
*                    endorses you or your use.
*
*   Non-Commercial - You may not use the material (Ashita) for commercial purposes.
*
*   No-Derivatives - If you remix, transform, or build upon the material (Ashita), you may not distribute the
*                    modified material. You are, however, allowed to submit the modified works back to the original
*                    Ashita project in attempt to have it added to the original project.
*
* You may not apply legal terms or technological measures that legally restrict others
* from doing anything the license permits.
*
* No warranties are given.
]]--

_addon.author   = 'Tornac';
_addon.name     = 'petparty';
_addon.version  = '1.0.2';

require 'common'

WindowX    = 250 -- base size
WindowY    = 70 -- base size
Size       = 0
MJob       = 0
SJob       = 0

function FindJob(MainJob)
	if (MainJob == 1) then
	   return 'WAR'
	elseif (MainJob == 2) then
	   return 'MNK'
    elseif (MainJob == 3) then
	   return 'WHM'
	elseif (MainJob == 4) then
	   return 'BLM'
	elseif (MainJob == 5) then
	   return 'RDM'
	elseif (MainJob == 6) then
	   return 'THF'
	elseif (MainJob == 7) then
	   return 'PLD'
    elseif (MainJob == 8) then
	   return 'DRK'
	elseif (MainJob == 9) then
	   return 'BST'
	elseif (MainJob == 10) then
	   return 'BRD'
	elseif MainJob == 11 then
	   return 'RNG'
	elseif MainJob == 12 then
	   return 'SAM'
	elseif MainJob == 13 then
	   return 'NIN'
	elseif MainJob == 14 then
	   return 'DRG'
	elseif MainJob == 15 then
	   return 'SMN'
	elseif MainJob == 16 then
	   return 'BLU'
    elseif MainJob == 17 then
	   return 'COR'
	elseif MainJob == 18 then
	   return 'PUP'
	elseif MainJob == 19 then
	   return 'DNC'
	elseif MainJob == 20 then
	   return 'SCH'
	elseif MainJob == 21 then
	   return 'GEO'
	elseif MainJob == 22 then
	   return 'RUN'
	else
	   return "UNKNOWN"
	end
 end;
 
function WindowSizePerPet(Size)
	if Size == 1 then
		return 70
	elseif Size == 2 then
		return 110
	elseif Size == 3 then
		return 155
	elseif Size == 4 then
		return 200
	elseif Size == 5 then
		return 240
	else 
		return 285
	end
end;

----------------------------------------------------------------------------------------------------
-- func: render
-- desc: Called when the addon is rendering.
----------------------------------------------------------------------------------------------------
ashita.register_event('render', function()

    for i=0,5 do 
        -- Obtain the local player..
        local entityId = AshitaCore:GetDataManager():GetParty():GetMemberTargetIndex(i)
		local JobNumber = AshitaCore:GetDataManager():GetParty():GetMemberMainJob(i)
        local player = GetEntity(entityId)
			if (player ~= nil) then

				-- Obtain the players pet..				
				local pet = GetEntity(player.PetTargetIndex);
					if (pet ~= nil) then
						Size = Size + 1
					end
			end
	end

    for i=0,5 do 
        -- Obtain the local player..
        local entityId = AshitaCore:GetDataManager():GetParty():GetMemberTargetIndex(i)
		local JobNumber = AshitaCore:GetDataManager():GetParty():GetMemberMainJob(i)
	    local SJobNumber = AshitaCore:GetDataManager():GetParty():GetMemberSubJob(i)
        local player = GetEntity(entityId)
			if (player ~= nil) then
			
			
			MJob = FindJob(JobNumber)
			SJob = FindJob(SJobNumber)
				
				-- Obtain the players pet..
				local pet = GetEntity(player.PetTargetIndex);
					if (pet ~= nil) then
					
					--240 for 5
					--200 for 4
					--155 for 3
					--110 for 2
					-- 75 for 1
					
					-- Display the pet information..
					imgui.SetNextWindowSize(WindowX, WindowSizePerPet(Size), ImGuiSetCond_Always);
					if (imgui.Begin('Petparty') == false) then
						imgui.End();
						return;
					end
					
					-- Adding the pet name along with the player name.
					imgui.Text(MJob);
					imgui.SameLine();
					imgui.Text('/');
					imgui.SameLine();
					imgui.Text(SJob);
					imgui.SameLine();
					imgui.Text(player.Name);
					imgui.SameLine();
					imgui.Text(':');
					imgui.SameLine();
					imgui.Text(pet.Name);
					imgui.Separator();
					
					-- Set the progressbar color for health..
					imgui.PushStyleColor(ImGuiCol_PlotHistogram, 1.0, 0.61, 0.61, 0.6);
					imgui.Text('HP:');
					imgui.SameLine();
					imgui.PushStyleColor(ImGuiCol_Text, 1.0, 1.0, 1.0, 1.0);
					imgui.ProgressBar(pet.HealthPercent / 100, -1, 14);
					imgui.PopStyleColor(2);
					imgui.Separator();
					imgui.End();  					
				end
			end
	
	end
	
	Size = 0

end);

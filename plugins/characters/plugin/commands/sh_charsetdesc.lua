﻿local COMMAND = Command.new('charsetdesc')
COMMAND.name = 'CharSetDesc'
COMMAND.description = 'command.char_set_desc.description'
COMMAND.syntax = 'command.char_set_desc.syntax'
COMMAND.permission = 'assistant'
COMMAND.category = 'permission.categories.character_management'
COMMAND.arguments = 2
COMMAND.player_arg = 1
COMMAND.aliases = { 'setdesc', 'setdescription', 'physdesc' }

function COMMAND:on_run(player, targets, ...)
  local new_desc = table.concat({ ... }, ' ')
  local target = targets[1]

  Characters.set_desc(target, new_desc)
end

COMMAND:register()

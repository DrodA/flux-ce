﻿local COMMAND = Command.new('charattributeboost')
COMMAND.name = 'CharAttributeBoost'
COMMAND.description = 'command.char_attribute_boost.description'
COMMAND.syntax = 'command.char_attribute_boost.syntax'
COMMAND.permission = 'moderator'
COMMAND.category = 'permission.categories.character_management'
COMMAND.arguments = 4
COMMAND.player_arg = 1
COMMAND.aliases = { 'attboost', 'attboost', 'attributeboost', 'attributeboost', 'charattboost' }

function COMMAND:get_description()
  return t(self.description, table.concat(Attributes.get_id_list(), ', '))
end

function COMMAND:on_run(player, targets, attr_id, value, duration)
  local target = targets[1]
  local attribute = Attributes.find_by_id(attr_id)

  if attribute and attribute.boostable then
    Flux.Player:broadcast('char_attribute_boost.message', { get_player_name(player), target:name(), attribute.name, value, duration })

    target:attribute_boost(attr_id:to_id(), tonumber(value), tonumber(duration))
  else
    player:notify('error.attribute_not_valid', attr_id)
  end
end

COMMAND:register()

config.set('chatbox_message_margin', 2)
config.set('chatbox_message_fade_delay', 12)
config.set('chatbox_max_messages', 100)

local defaultMessageData = {
  sender = nil,
  listeners = {},
  data = {},
  position = nil,
  radius = 0,
  filter = nil,
  shouldTranslate = false,
  rich = false,
  size = 20,
  text = nil,
  teamChat = false
}

local filters = {}
local clientMode = false

function chatbox.AddFilter(id, data)
  filters[id] = data
end

function chatbox.CanHear(listener, messageData)
  if listener:HasInitialized() then
    local position, radius = messageData.position, messageData.radius

    if !isnumber(radius) then return false end
    if radius == 0 then return true end
    if radius < 0 then return false end

    if istable(position) then
      for k, v in pairs(position) do
        if v:Distance(listener:GetPos()) <= radius then
          return true
        end
      end
    end

    if position:Distance(listener:GetPos()) <= radius then
      return true
    end
  end

  return false
end

function chatbox.PlayerCanHear(listener, messageData)
  return plugin.call('PlayerCanHear', listener, messageData) or chatbox.CanHear(listener, messageData)
end

function chatbox.AddText(listeners, ...)
  local messageData = {
    sender = nil,
    listeners = listeners or {},
    data = {},
    position = nil,
    radius = 0,
    filter = nil,
    shouldTranslate = false,
    rich = false,
    size = 20,
    text = nil,
    teamChat = false,
    max_height = 20
  }

  if !istable(listeners) then
    if IsValid(listeners) then
      listeners = {listeners}
    else
      listeners = _player.GetAll()
    end
  end

  -- Compile the initial message data table.
  for k, v in ipairs({...}) do
    if isstring(v) then
      table.insert(messageData.data, v)

      if k == 1 then
        messageData.text = v
      end
    elseif isnumber(v) then
      table.insert(messageData.data, v)

      if messageData.max_height < v then
        messageData.max_height = v
      end
    elseif IsColor(v) then
      table.insert(messageData.data, v)
    elseif istable(v) then
      if !v.isData and !clientMode then
        table.merge(messageData, v)
      else
        table.insert(messageData.data, v)
      end
    elseif IsValid(v) then
      table.insert(messageData.data, v)
    end
  end

  for k, v in ipairs(listeners) do
    if chatbox.PlayerCanHear(v, messageData) then
      netstream.Start(v, 'Chatbox::AddMessage', messageData)
    end
  end
end

function chatbox.SetClientMode(bClientMode)
  clientMode = bClientMode
end

function chatbox.message_to_string(message_data, concatenator)
  local to_string = {}

  for k, v in pairs(message_data) do
    if isstring(v) then
      to_string[#to_string + 1] = v
    elseif IsValid(v) then
      local name = ''

      if v:IsPlayer() then
        name = hook.run('GetPlayerName', v) or v:Name()
      else
        name = tostring(v) or v:GetClass()
      end

      to_string[#to_string + 1] = name
    end
  end

  return table.concat(to_string, concatenator)
end

netstream.Hook('Chatbox::AddText', function(player, ...)
  if !IsValid(player) then return end

  chatbox.SetClientMode(true)
  chatbox.AddText(player, ...)
  chatbox.SetClientMode(false)
end)

netstream.Hook('Chatbox::PlayerSay', function(player, text, bTeamChat)
  if !IsValid(player) then return end

  local playerSayOverride = hook.run('PlayerSay', player, text, bTeamChat)

  if isstring(playerSayOverride) then
    if playerSayOverride == '' then return end

    text = playerSayOverride
  end

  local message = {
    hook.run('ChatboxGetPlayerIcon', player, text, bTeamChat) or {},
    hook.run('ChatboxGetPlayerColor', player, text, bTeamChat) or _team.GetColor(player:Team()),
    player,
    hook.run('ChatboxGetMessageColor', player, text, bTeamChat) or Color(255, 255, 255),
    ': ',
    text,
    {sender = player}
  }

  hook.run('ChatboxAdjustPlayerSay', player, text, message)

  chatbox.AddText(nil, unpack(message))
end)

PLUGIN:set_global('AttributesPlugin')

require_relative 'sv_hooks'

function AttributesPlugin:PluginIncludeFolder(extra, folder)
  for k, v in pairs(Attributes.types) do
    if extra == k then
      Attributes.include_type(k, v, folder..'/'..k..'/')

      return true
    end
  end
end

function AttributesPlugin:RegisterConditions()
  Conditions:register_condition('attribute', {
    name = 'condition.attribute.name',
    text = 'condition.attribute.text',
    get_args = function(panel, data)
      local attribute_name = ''
      local operator = util.operator_to_symbol(panel.data.operator) or ''
      local attribute_value = panel.data.attribute_value or ''

      if panel.data.attribute then
        attribute_name = Attributes.find_by_id(panel.data.attribute).name
      end

      return { operator, attribute_name, attribute_value }
    end,
    icon = 'icon16/chart_bar.png',
    check = function(player, data)
      if !data.operator or !data.attribute or !data.attribute_value then return false end

      return util.process_operator(data.operator, player:get_attribute(data.attribute), tonumber(data.attribute_value))
    end,
    set_parameters = function(id, data, panel, menu, parent)
      parent:create_selector(data.name, 'condition.attribute.message1', 'condition.attributes', Attributes.get_stored(),
      function(selector, value)
        selector:add_choice(t(value.name), function()
          panel.data.attribute = value.attr_id

          panel.update()

          Derma_StringRequest(
            t(data.name),
            t'condition.attribute.message2',
            '',
            function(text)
              panel.data.attribute_value = text

              panel.update()
            end)
        end)
      end)
    end,
    set_operator = 'relational'
  })
end

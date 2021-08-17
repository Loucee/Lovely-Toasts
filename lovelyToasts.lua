
--[[
	Author: Lucy van Sandwijk
	Website: https://loucee.dev
	GitHub: https://github.com/Loucee/Lovely-Toasts
]]

local yOffset = 15

local lovelyToasts = {
	canvasSize = { },
	style = {
		font = love.graphics.newFont(16),
		textColor = { 1, 1, 1, 1},
		backgroundColor = { 0, 0, 0, 0.5 },
		paddingLR = 25,
		paddingTB = 10
	},
	options = {
		tapToDismiss = false,
		queueEnabled = false,
		animationDuration = 0.3
	}
}

_toasts = { }

--------------------------------------------------------------------------------

function lovelyToasts.update(dt)
	if #_toasts > 0 then
		local current = _toasts[1]

		-- Update toast time
		current._timePassed = current._timePassed + dt

		-- Update alpha and y offset
		if (current._timePassed <= lovelyToasts.options.animationDuration) then
			current._alpha = math.min(100, current._alpha + (100 / lovelyToasts.options.animationDuration * dt))
		elseif (current._timePassed >= current.duration - lovelyToasts.options.animationDuration) then
			current._alpha = math.max(0, current._alpha - (100 / lovelyToasts.options.animationDuration * dt))
		end
		current._yOffset = math.max(0, current._yOffset - (yOffset / lovelyToasts.options.animationDuration * dt))
		
		-- Remove toast when duration ended
		if (current._timePassed >= current.duration) then
			table.remove(_toasts, 1)
		end
	end
end

function lovelyToasts.draw()
	if #_toasts > 0 then
		local screenW = lovelyToasts.canvasSize[1] or love.graphics.getWidth()
		local current = _toasts[1]

		-- Store current font and color to restore later
		local r, g, b, a = love.graphics.getColor()
		local font = love.graphics.getFont()

		local textWidth = lovelyToasts.style.font:getWidth(current.text)
		local textHeight = lovelyToasts.style.font:getHeight()
		local textX = (screenW / 2) - (textWidth / 2)
		local textY = lovelyToasts._yForPosition(current.position) - (textHeight / 2) + current._yOffset

		-- Draw toast background
		local bgR, bgG, bgB, bgA = unpack(lovelyToasts.style.backgroundColor)
		love.graphics.setColor(bgR, bgG, bgB, (bgA or 0.5) * (current._alpha / 100))
		love.graphics.rectangle("fill", 
			textX - lovelyToasts.style.paddingLR,
			textY - lovelyToasts.style.paddingTB,
			textWidth + (lovelyToasts.style.paddingLR * 2),
			textHeight + (lovelyToasts.style.paddingTB * 2),
			10, 10, 1000
		)

		-- Draw toast title
		local tR, tG, tB, tA = unpack(lovelyToasts.style.textColor)
		love.graphics.setColor(tR, tG, tB, (tA or 1) * (current._alpha / 100))
		love.graphics.setFont(lovelyToasts.style.font)
		love.graphics.print(current.text, textX, textY)

		-- Restore color and font
		love.graphics.setColor(r, g, b, a)
		love.graphics.setFont(font)
	end
end

function lovelyToasts.mousereleased(x, y, button)
	if button == 1 then
		lovelyToasts._dismissOnTouch(x, y)
	end
end

function lovelyToasts.touchreleased(id, x, y, dx, dy, pressure)
	lovelyToasts._dismissOnTouch(x, y)
end

--------------------------------------------------------------------------------

function lovelyToasts.show(text, duration, position)
	local t = {
		_timePassed = 0,
		_alpha = 0,
		_yOffset = yOffset,
		text = text,
		duration = (duration or 3) + (lovelyToasts.options.animationDuration * 2),
		position = position or "bottom"
	}

	if (lovelyToasts.options.queueEnabled) then
		table.insert(_toasts, t)
	else
		_toasts = { t }
	end
end

--------------------------------------------------------------------------------

function lovelyToasts._yForPosition(pos)
	local screenH = lovelyToasts.canvasSize[2] or love.graphics.getHeight()
	if (pos == "bottom") then
		return screenH * 0.8
	elseif (pos == "top") then
		return screenH * 0.2
	elseif (pos == "middle") then
		return screenH * 0.5
	end
	return pos
end

function lovelyToasts._dismissOnTouch(x, y)
	if #_toasts > 0 and lovelyToasts.options.tapToDismiss then
		local current = _toasts[1]

		local toastWidth = lovelyToasts.style.font:getWidth(current.text) + (lovelyToasts.style.paddingLR * 2)
		local toastHeight = lovelyToasts.style.font:getHeight() + (lovelyToasts.style.paddingTB * 2)
		local toastX = (love.graphics.getWidth() / 2) - (toastWidth / 2) - lovelyToasts.style.paddingLR
		local toastY = lovelyToasts._yForPosition(current.position) - (toastHeight / 2) - lovelyToasts.style.paddingTB

		if (x > toastX) and (x < toastX + toastWidth) and (y > toastY) and (y < toastY + toastHeight) then
			table.remove(_toasts, 1)
		end
	end
end

--------------------------------------------------------------------------------

return lovelyToasts

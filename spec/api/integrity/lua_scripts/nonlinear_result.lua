local result = 0

if USER_ANSWERS[0] then
    result = 0.2
end

if USER_ANSWERS[1] then
    result = 0.5
end

if USER_ANSWERS[2] then
    result = 0.7
end

if USER_ANSWERS[3] then
    result = 1
end

return result
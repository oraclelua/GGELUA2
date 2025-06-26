local key = "dhxy!123@hyxy#456"

local AES = {}

-- 加密
function AES:encrypt(message)
    if message == nil then
        return message
    end

    local encrypted = ""
    for i = 1, #message do
        local char = message:sub(i, i)
        local keychar = key:sub((i % #key) + 1, (i % #key) + 1)
        local xorchar = string.char(char:byte() ~ keychar:byte())
        encrypted = encrypted .. xorchar
    end
    return encrypted
end

-- 解密
function AES:decrypt(encrypted)
    if encrypted == nil then
        return encrypted
    end

    local decrypted = ""
    for i = 1, #encrypted do
        local char = encrypted:sub(i, i)
        local keychar = key:sub((i % #key) + 1, (i % #key) + 1)
        local xorchar = string.char(char:byte() ~ keychar:byte())
        decrypted = decrypted .. xorchar
    end
    return decrypted
end

return AES

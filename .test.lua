-- this works
local remote_url = "gitlab.com/t.thi/opera"
local owner, repo = remote_url:match "gitlab%.com[/:]([^/]+)/([^/]+)$"

print("remote_url: " .. remote_url)
if owner then
  print("owner: " .. owner)
end
if repo then
  print("repo: " .. repo)
end

-- this does not work
local remote_url = "https://gitlab.com/f5/volterra/ves.io/opera"
local owner, repo = remote_url:match "gitlab%.com[/:](.+/)([^/]+)$"

print("remote_url: " .. remote_url)
if owner then
  print("owner: " .. owner)
end
if repo then
  print("repo: " .. repo)
end

-- write a function that prints out n digits of pi

local function print_pi_digits(n)
  local pi_str = tostring(math.pi):gsub("%.", "")
  local formatted_str = pi_str:sub(1, 1) .. "." .. pi_str:sub(4, n + 2)
  print(formatted_str)
end

print_pi_digits(15)

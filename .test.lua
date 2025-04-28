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

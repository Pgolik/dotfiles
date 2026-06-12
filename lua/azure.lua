local azure = {}

local function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

local function lines_from(file)
  if not file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

function azure.get_remote()
  local organization = vim.fn.expand('$ORGANIZATION')
  local project = vim.fn.expand('$PROJECT')
  local full_path_repository = vim.fn.system("git rev-parse --show-toplevel")
  local rev = string.reverse(full_path_repository)
  local idx = string.find(rev, "/")
  if idx == nil then
    print("Not a git repository")
    return
  end
  local repository = string.gsub(string.reverse(string.sub(rev, 0, idx - 1)), "\n", "")
  local line = vim.fn.line('.')
  local path = vim.fn.expand('%.')
  vim.fn.setreg("+", "https://dev.azure.com/" ..
    organization ..
    '/' ..
    project ..
    "/_git/" ..
    repository ..
    '?path=' ..
    path ..
    '&line=' .. line .. '&lineEnd=' .. (line + 1) .. '&lineStartColumn=1&lineEndColumn=1&lineStyle=plain&_a=contents')
end

function azure.find_pr()
  local organization = vim.fn.expand('$ORGANIZATION')
  local project = vim.fn.expand('$PROJECT')
  local branch = string.gsub(vim.fn.system("git branch --show-current"), "\n", "")
  local full_path_repository = vim.fn.system("git rev-parse --show-toplevel")
  local creds = lines_from(vim.fn.expand('$HOME') .. "/.git-credentials")[1]
  local start_idx = string.find(creds, "://") + 3
  local stop_idx = string.find(creds, "@")
  local pat = string.sub(creds, start_idx, stop_idx - 1)
  local rev = string.reverse(full_path_repository)
  local idx = string.find(rev, "/")
  if idx == nil then
    print("Not a git repository")
    return
  end
  local repository = string.gsub(string.reverse(string.sub(rev, 0, idx - 1)), "\n", "")
  local pr_url = "https://dev.azure.com/" .. organization .. '/' .. project ..
      "/_apis/git/repositories/" .. repository .. "/pullrequests?searchCriteria.sourceRefName=refs/heads/" .. branch ..
      '&searchCriteria.status=active'

  local result = vim.fn.system("curl -X GET -H 'Content-Type: application/json' -u " .. pat .. " \"" .. pr_url .. "\"")
  start_idx = string.find(result, "\"pullRequestId\":")
  stop_idx = string.find(result, ",", start_idx)
  local line = vim.fn.line('.')
  local path = vim.fn.expand('%.')
  local pr_number = string.sub(result, start_idx + 16, stop_idx - 1)
  vim.fn.setreg("+", "https://dev.azure.com/ABB-PAMA-BVL/GCPro/_git/" ..
    repository ..
    "/pullrequest/" ..
    pr_number ..
    '?path=/' ..
    path ..
    '&line=' .. line .. '&lineEnd=' .. (line + 1) .. '&lineStartColumn=1&lineEndColumn=1&lineStyle=plain&_a=files')
end

return azure

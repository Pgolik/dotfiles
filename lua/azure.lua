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

local function get_pat()
  local creds = lines_from(vim.fn.expand('$HOME') .. "/.git-credentials")[1]
  local start_idx = string.find(creds, "://") + 3
  local stop_idx = string.find(creds, "@")
  return string.sub(creds, start_idx, stop_idx - 1)
end

local function get_repository()
  local full_path_repository = vim.fn.system("git rev-parse --show-toplevel")
  local rev = string.reverse(full_path_repository)
  local idx = string.find(rev, "/")
  if idx == nil then
    print("Not a git repository")
    return nil
  end
  return string.gsub(string.reverse(string.sub(rev, 0, idx - 1)), "\n", "")
end

local function get_path(repository)
  local path = vim.fn.expand('%.')
  local path_indx = string.find(path, repository, 1, true)
  print(path_indx, path, repository)
  if path_indx ~= nil then
    local git_idx = string.find(path, ".git/")
    if git_idx ~= nil then
      local git_end_idx = string.find(path, "/", git_idx + 5)
      path = string.sub(path, git_end_idx + 1)
    else
      path = string.sub(path, path_indx + string.len(repository) + 1)
    end
  end
  return path
end

local function get_env_variables()
  local repository = get_repository()
  return {
    organization = vim.fn.expand('$ORGANIZATION'),
    project      = vim.fn.expand('$PROJECT'),
    pat          = get_pat(),
    repository   = repository,
    line         = vim.fn.line('.'),
    path         = get_path(repository),
  }
end


function azure.get_remote()
  local env = get_env_variables()
  if env.repository == nil then
    print("Not a git repository")
    return
  end
  vim.fn.setreg("+", "https://dev.azure.com/" ..
    env.organization ..
    '/' ..
    env.project ..
    "/_git/" ..
    env.repository ..
    '?path=' ..
    env.path ..
    '&line=' ..
    env.line .. '&lineEnd=' .. (env.line + 1) .. '&lineStartColumn=1&lineEndColumn=1&lineStyle=plain&_a=contents')
end

local function get_pr_info(env)
  local pr_url = "https://dev.azure.com/" .. env.organization .. '/' .. env.project ..
      "/_apis/git/repositories/" .. repository .. "/pullrequests?searchCriteria.sourceRefName=refs/heads/" .. branch ..
      '&searchCriteria.status=active'

  return vim.fn.system("curl -X GET -H 'Content-Type: application/json' -u " .. pat .. " \"" .. pr_url .. "\"")
end

function azure.find_pr()
  local env = get_env_variables()
  if env.repository == nil then
    print("Not a git repository")
    return
  end
  local result = get_pr_info(env)
  local start_idx = string.find(result, "\"pullRequestId\":")
  local stop_idx = string.find(result, ",", start_idx)
  local pr_number = string.sub(result, start_idx + 16, stop_idx - 1)
  vim.fn.setreg("+", "https://dev.azure.com/" .. env.organization .. "/" .. env.project .. "/_git/" ..
    env.repository ..
    "/pullrequest/" ..
    pr_number ..
    '?path=/' ..
    evn.path ..
    '&line=' ..
    env.line .. '&lineEnd=' .. (env.line + 1) .. '&lineStartColumn=1&lineEndColumn=1&lineStyle=plain&_a=files')
end

return azure


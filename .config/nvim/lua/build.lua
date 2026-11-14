-- Build the CMake project in the background and put compiler errors in the
-- quickfix list (jump with ]q / [q). Uses the nearest build-dev, build or
-- cmake-build-debug folder above the current file.
return function()
  local build_dir
  for _, name in ipairs({ "build-dev", "build", "cmake-build-debug" }) do
    build_dir = vim.fs.find(name, { upward = true, type = "directory", path = vim.fn.expand("%:p:h") })[1]
    if build_dir then break end
  end
  if not build_dir then
    vim.notify("No build-dev, build or cmake-build-debug folder found", vim.log.levels.WARN)
    return
  end

  vim.cmd("silent! wall")
  vim.notify("Building " .. vim.fn.fnamemodify(build_dir, ":~") .. " ...")
  vim.system({ "cmake", "--build", build_dir, "--parallel" }, { text = true }, function(res)
    vim.schedule(function()
      local lines = vim.split((res.stdout or "") .. (res.stderr or ""), "\n", { trimempty = true })
      vim.fn.setqflist({}, " ", { title = "cmake --build", lines = lines, efm = vim.o.errorformat })
      if res.code == 0 then
        vim.notify("Build succeeded")
        vim.cmd("cclose")
      else
        vim.notify("Build failed", vim.log.levels.ERROR)
        vim.cmd("cwindow")
      end
    end)
  end)
end

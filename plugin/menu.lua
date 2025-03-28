vim.cmd [[
  aunmenu PopUp
  anoremenu PopUp.Inspect            <cmd>Inspect<CR>
  amenu PopUp.-1-                    <NOP>
  anoremenu PopUp.Hover\ Info        <cmd>lua vim.lsp.buf.hover()<CR>
  anoremenu PopUp.References         <cmd>Telescope lsp_references<CR>
  anoremenu PopUp.Code\ Action       <cmd>lua vim.lsp.buf.code_action()<CR>
  amenu PopUp.-2-                    <NOP>
  anoremenu PopUp.Go\ To\ Definition <cmd>lua vim.lsp.buf.definition()<CR>
  anoremenu PopUp.Back               <C-t>
]]

local group = vim.api.nvim_create_augroup("nvim_popupmenu", { clear = true })
vim.api.nvim_create_autocmd("MenuPopup", {
  pattern = "*",
  group = group,
  desc = "Custom PopUp Setup",
  callback = function ()
    vim.cmd [[
      amenu disable PopUp.-1-
      amenu disable PopUp.Code\ Action
      amenu disable PopUp.References
      amenu disable PopUp.Hover\ Info
      amenu disable PopUp.-2-
      amenu disable PopUp.Go\ To\ Definition
    ]]
    if vim.lsp.get_clients({ bufnr = 0 })[1] then
      vim.cmd [[
        amenu enable PopUp.-1-
        amenu enable PopUp.Code\ Action
        amenu enable PopUp.References
        amenu enable PopUp.Hover\ Info
        amenu enable PopUp.-2-
        amenu enable PopUp.Go\ To\ Definition
      ]]
    end
  end
})

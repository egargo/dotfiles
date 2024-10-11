return {
  -- "gc" to comment visual regions/lines
  'numToStr/Comment.nvim',
  opts = {
    padding = true,
    sticky = true,
    toggler = {
      -- line = '<C-_>',
      line = 'gc',
      block = 'cb',
    },
  },
}

require('notify').setup {
  stages = 'fade_in_slide_out',
  on_open = function()
    return (
        {
          opacity = 0
        }
        )
  end
}

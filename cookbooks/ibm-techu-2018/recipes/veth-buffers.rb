aix_chdev 'ent0' do
  attributes(max_buf_tiny: '2048', max_buf_small: '2048', max_buf_medium: '2048', max_buf_large: '256', max_buf_huge: '128')
  need_reboot true
  action :update
end

aix_chdev 'ent0' do
  attributes(min_buf_tiny: '2048', min_buf_small: '2048', min_buf_medium: '2048', min_buf_large: '256', min_buf_huge: '128')
  need_reboot true
  action :update
end

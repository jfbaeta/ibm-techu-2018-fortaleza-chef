['fcs0', 'fcs1'].each do |fcs|
  aix_chdev fcs do
    attributes(num_cmd_elems: '512')
    need_reboot true
    action :update
  end
end

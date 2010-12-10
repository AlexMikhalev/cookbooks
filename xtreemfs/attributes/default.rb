set_unless[:xtreemfs][:version]      = "1.2.3" 
set_unless[:xtreemfs][:configure_flags] = [
]
set_unless[:xtreemfs][:architecture] = node[:kernel][:machine] == "x86_64" ? "amd64" : "i386"   
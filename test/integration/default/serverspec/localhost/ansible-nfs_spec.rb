require 'spec_helper'

describe "NFS related packages should be installed" do
  packages = case os[:family]
    when "ubuntu"
      %w(nfs-kernel-server)
    when "redhat" || "fedora"
      %w(nfs-utils)
    else
      []
    end
  packages.each do |p|
    describe package(p) do
      it { should be_installed }
    end
  end
end

describe "NFS related services should be enabled and running" do
  services = case os[:family]
    when "ubuntu"
      if os[:release].to_f <= 12.04
        %w(portmap nfs-kernel-server)
      elsif os[:release].to_f <= 14.10
        %w(rpcbind nfs-kernel-server)
      else
        %w(rpcbind nfs-server)
      end
    when "redhat"
      if os[:release].to_f < 7
        %w(rpcbind nfslock nfs)
      else
        %w(rpcbind nfs-lock nfs-server)
      end
    when "fedora"
      %w(rpcbind nfs-lock nfs-server)
    else
      []
    end
  services.each do |s|
    describe service(s) do
      it { should be_enabled }
      it { should be_running }
    end
  end
end

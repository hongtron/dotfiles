task :default => "install"

namespace "configs" do

  IGNORE = %w(Rakefile README.md Tomorrow-Night.vim bin nvim)

  desc "symlink files into home directory"
  task :install do
    home_dir = File.expand_path("~")
    working_dir = File.expand_path(File.dirname(__FILE__))
    my_dotfiles = Dir.glob(File.join(working_dir,"*"))

    my_dotfiles.each do |file|
      filename = File.basename(file)
      old_dotfile = File.join(home_dir,".#{filename}")

      next if IGNORE.include?(filename)

      if File.exist?(old_dotfile)
        File.rename(old_dotfile, "#{old_dotfile}.ash.bak")
      end

      sym_link = File.join(working_dir,"#{filename}")

      ln_s sym_link, old_dotfile
    end

    nvim_config_folder = File.expand_path("~/.config/nvim")
    mkdir_p nvim_config_folder unless File.exist?(nvim_config_folder)
    cp_r 'nvim/.', nvim_config_folder
  end

  desc "remove symlinks, add old files"
  task :uninstall do
    home_dir = File.expand_path("~")
    working_dir = File.expand_path(File.dirname(__FILE__))
    my_dotfiles = Dir.glob(File.join(working_dir,"*"))

    my_dotfiles.each do |file|
      filename = File.basename(file)
      dotfile = File.join(home_dir,".#{filename}")

      next if IGNORE.include?(filename)

      rm_rf(dotfile) if File.symlink?(dotfile) || File.exist?(dotfile)

      old_dotfile = File.join(home_dir,".#{filename}.ash.bak")
      if File.exist?(old_dotfile)
        File.rename(old_dotfile,dotfile)
      end
    end

    nvim_folder = File.join(home_dir,".config/nvim")
    rm_rf(nvim_folder) if File.symlink?(nvim_folder) || File.exist?(nvim_folder)

    old_nvim_folder = File.join(home_dir,"nvim.ash.bak")
    if File.exist?(old_nvim_folder)
      FileUtils.mv(old_nvim_folder,nvim_folder)
    end
  end
end

namespace "plugins" do
  PLUGIN_REPOSITORIES = {
    "Vundler" => {
      :type => :git,
      :uri => "https://github.com/VundleVim/Vundle.vim.git",
      :install_dir => "~/.vim/bundle/Vundle.vim",
      :commands => {
        :post_install => ["vim +PluginInstall +qall"]
      }
    }
  }

  desc "install prereqs"
  task :install  do
    PLUGIN_REPOSITORIES.each do |name, config|
      puts "Installing #{name}"

      if config[:type] == :git && config[:install_dir]
        install_dir = File.expand_path(config[:install_dir])
        parent_dir = File.dirname(install_dir)

        rm_rf(File.expand_path(install_dir))
        mkdir_p(parent_dir) unless File.exist?(parent_dir)

        system("git clone #{config[:uri]} #{install_dir}")
      end

      if config[:commands] && config[:commands][:post_install]
        config[:commands][:post_install].each { |command| system(command) }
      end
    end
  end

  desc "remove prereqs"
  task :uninstall do
    PLUGIN_REPOSITORIES.each do |name, config|
      puts "Uninstalling #{name}"
      if config[:type] == :git
        install_dir = File.expand_path(config[:install_dir])
        rm_rf(install_dir) if config[:install_dir] && File.directory?(install_dir)
      end
    end
  end
end

namespace "scripts" do
  INSTALL_DIR = File.expand_path("~/.bin")
  SCRIPT_DIR = File.expand_path(File.dirname(__FILE__))

  task :install do
    bin_scripts = Dir.glob(File.join(SCRIPT_DIR,"bin","*"))

    bin_scripts.each { |script| chmod( 0755, script) }

    if File.exist?(INSTALL_DIR)
      if File.symlink?(INSTALL_DIR)
        puts "WARNING: Bin symlink was present on install"
        rm(INSTALL_DIR)
      else
        puts "ERROR: Your bin folder is screwed up; can\"t install! #{INSTALL_DIR}"
        exit
      end
    end

    ln_s("#{SCRIPT_DIR}/bin", INSTALL_DIR)
  end

  task :uninstall do
    if File.symlink?(INSTALL_DIR)
      rm(INSTALL_DIR)
    elsif File.exist?(INSTALL_DIR)
      puts "WARNING: Leaving a non-empty bin directory behind"
    end
  end
end

task :install => ["scripts:install","configs:install", "plugins:install"]
task :uninstall => ["plugins:uninstall", "configs:uninstall", "scripts:uninstall"]
task "all:install" => [:install]

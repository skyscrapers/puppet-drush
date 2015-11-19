require 'spec_helper'

describe 'drush', :type => :class do
  let(:title) { 'drush' }

  it { should contain_wget__fetch('drush-install') \
    .with_source('https://github.com/drush-ops/drush/releases/download/8.0.0-rc4/drush.phar') \
    .with_execuser('root') \
    .with_destination('/usr/local/bin/drush')
  }

  it { should contain_exec('drush-test-download') \
    .with_command('php /usr/local/bin/drush core-status') \
    .with_user('root') \
    .with_cwd('/usr/local/bin')
  }

  it { should contain_exec('drush-fix-permissions') \
    .with_command('chmod a+x drush') \
    .with_user('root') \
    .with_cwd('/usr/local/bin')
  }

  describe 'with a given target_dir' do
    let(:params) {{ :target_dir => '/usr/bin' }}

    it { should contain_wget__fetch('drush-install') \
      .with_source('https://github.com/drush-ops/drush/releases/download/8.0.0-rc4/drush.phar') \
      .with_execuser('root') \
      .with_destination('/usr/bin/drush')
    }

    it { should contain_exec('drush-test-download') \
      .with_command('php /usr/bin/drush core-status') \
      .with_user('root') \
      .with_cwd('/usr/bin')
    }

    it { should contain_exec('drush-fix-permissions') \
      .with_command('chmod a+x drush') \
      .with_user('root') \
      .with_cwd('/usr/bin')
    }
  end

  describe 'with a given command_name' do
    let(:params) {{ :command_name => 'd' }}

    it { should contain_wget__fetch('drush-install') \
      .with_source('https://github.com/drush-ops/drush/releases/download/8.0.0-rc4/drush.phar') \
      .with_execuser('root') \
      .with_destination('/usr/local/bin/d')
    }

    it { should contain_exec('drush-test-download') \
      .with_command('php /usr/local/bin/d core-status') \
      .with_user('root') \
      .with_cwd('/usr/local/bin')
    }

    it { should contain_exec('drush-fix-permissions') \
      .with_command('chmod a+x d') \
      .with_user('root') \
      .with_cwd('/usr/local/bin')
    }
  end

  describe 'with a given user' do
    let(:params) {{ :user => 'pnx' }}

    it { should contain_wget__fetch('drush-install') \
      .with_source('https://github.com/drush-ops/drush/releases/download/8.0.0-rc4/drush.phar') \
      .with_execuser('pnx') \
      .with_destination('/usr/local/bin/drush')
    }

    it { should contain_exec('drush-test-download') \
      .with_command('php /usr/local/bin/drush core-status') \
      .with_user('pnx') \
      .with_cwd('/usr/local/bin')
    }

    it { should contain_exec('drush-fix-permissions') \
      .with_command('chmod a+x drush') \
      .with_user('pnx') \
      .with_cwd('/usr/local/bin')
    }
  end
end

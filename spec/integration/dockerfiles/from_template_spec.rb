# encoding: UTF-8
#
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2015 Xabier de Zuazo
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'spec_helper'

serverspec_tests do
  describe 'Build a Dockerfile from a template' do
    template = DockerspecTests.fixture_file('Dockerfile1.erb')

    describe docker_build(template: template, tag: 'from_template_spec') do
      describe docker_run('from_template_spec') do
        describe package('alpine-base') do
          it { should be_installed }
        end

        it 'is a Linux distro' do
          expect(command('uname').stdout).to include 'Linux'
        end
      end
    end
  end
end

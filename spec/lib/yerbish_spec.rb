require 'spec_helper'
require 'yerbish'

describe Yerbish do
  let(:test_local_variables) { { test_local_variable: 'test-local-variable-value' } }

  describe '#create_binding' do
    subject { described_class.create_binding 'test-base-path', test_local_variable: 'test-local-variable-value' }

    it 'should mix in Yerbish' do
      expect(subject.eval 'self.private_methods').to include :base_path
      expect(subject.eval 'self.private_methods').to include :base_path=
      expect(subject.eval 'self.private_methods').to include :create_binding
      expect(subject.eval 'self.private_methods').to include :load
      expect(subject.eval 'self.private_methods').to include :render
      expect(subject.eval 'self.private_methods').to include :render_json
    end

    it 'should set the specified local variables' do
      expect(subject.eval 'test_local_variable').to eq 'test-local-variable-value'
    end

    it 'should set base_path' do
      expect(subject.eval 'base_path').to eq 'test-base-path'
    end
  end

  describe '#load' do
    subject { described_class.load File.expand_path('../resources/load_test', __dir__) }

    it { is_expected.to include 'key' => 'value' }
  end

  describe '#render' do
    subject { described_class.render file_path, test_local_variables }

    context 'given an absolute file path' do
      let(:file_path) { File.expand_path '../resources/render_test', __dir__ }

      it { is_expected.to match /key: test-local-variable-value/ }
    end

    context 'given a base path and a relative file path' do
      let(:file_path) { 'render_test' }

      before { described_class.base_path = File.expand_path '../resources', __dir__ }
      # As base_path is set on the module, we need to reset it as other tests expext it to be nil.
      after { described_class.base_path = nil }

      it { is_expected.to match /key: test-local-variable-value/ }
    end

    context 'given a file path with a .yml.erb extension' do
      let(:file_path) { File.expand_path '../resources/render_test.yml.erb', __dir__ }

      it { is_expected.to match /key: test-local-variable-value/ }
    end
  end

  describe '#render_json' do
    subject { described_class.render_json File.expand_path('../resources/render_json_test', __dir__) }

    it { is_expected.to match /"key": "value"/ }

    it 'should render valid JSON' do
      expect { JSON.parse subject }.to_not raise_error
    end
  end

  describe 'nested rendering' do
    subject do
      json = described_class.render_json(
        File.expand_path('../resources/nested_render_test', __dir__),
        test_local_variables
      )
      JSON.parse json
    end

    before { described_class.base_path = File.expand_path '../resources', __dir__ }

    it 'should render three nested files' do
      expect(subject['key1']).to eq 'test-local-variable-value'
      expect(subject['key2']).to eq 'test-local-variable2-value'
      expect(subject['key3']).to eq File.expand_path('../resources', __dir__)
    end
  end
end

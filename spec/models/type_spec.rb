require 'spec_helper'

describe Type do

	before { @type = Type.new(name: "Recover") }

	subject { @type }

	it { should respond_to(:name) }

	it { should be_valid }

end

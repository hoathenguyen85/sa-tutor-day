require_relative 'stack'
require_relative 'node'

describe MyStack do
let(:a_node) {Node.new('a')}
let(:b_node) {Node.new('b')}
let(:empty_stack) {MyStack.new}
let(:a_stack) {MyStack.new(a_node)}

  context '#initialize' do
    it "is a MyStack class" do
      expect(empty_stack.instance_of?(MyStack)).to eq(true)
    end

    it "initialized empty" do
      expect(empty_stack.top).to be_nil
    end

    it "initialized with a node on top" do
      expect(a_stack.top).to_not be_nil
    end

    it "has #top defined" do
      expect(a_stack.top).to eq(a_node)
    end
  end

  context '#push' do
    it "is defined" do
      expect(MyStack.method_defined?(:push)).to eq(true)
    end

    it 'should return node added to stack' do
      expect(empty_stack.push(a_node)).to be(a_node)
    end
  end

  context '#pop' do
    it "is defined" do
      expect(MyStack.method_defined?(:pop)).to eq(true)
    end

    it 'should return node removed top of the stack' do
      expect(a_stack.pop).to be(a_node)
    end
  end

  context '#count' do
    it "is defined" do
      expect(MyStack.method_defined?(:count)).to eq(true)
    end

    it 'should be 0 on empty stack' do
      expect(empty_stack.count).to be(0)
    end

    it 'should go up 1 from a #push' do
      empty_stack.push(a_node)
      expect(empty_stack.count).to be(1)
    end

    it 'should go up 2 from 2 #push' do
      empty_stack.push(a_node)
      empty_stack.push(b_node)
      expect(empty_stack.count).to be(2)
    end

    it 'should go down 1 from a #pop' do
      a_stack.pop
      expect(a_stack.count).to be(0)
    end
  end
end

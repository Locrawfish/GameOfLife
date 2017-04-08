require 'pry'
require "rspec"
require_relative "../lib/cell"

describe Cell do
  subject { Cell.new(:alive) }
  it 'exists' do
    expect(subject).to be_truthy
  end

  describe '#make_alive' do
    subject { Cell.new(:dead) }
    it 'becomes alive with if has 2-3 neighbors' do
      subject.make_alive
      expect(subject.alive?).to eq true
    end
  end

  describe '#alive_neighbor_count' do
    it 'should return the number of alive neighbors' do
      count = rand(0..100)
      neighbors = []
      count.times { neighbors << Cell.new(:alive) }
      count.times { neighbors << Cell.new(:dead) }
      expect(subject.alive_neighbor_count(neighbors)).to eq count
    end
  end

  describe '#should_live?' do
    context 'on a live cell' do
      subject { Cell.new(:alive) }
      context 'with fewer than two live neighbors' do
        it 'should return false' do
          neighbors = []
          rand(0..1).times { neighbors << Cell.new(:alive) }
          expect(subject.should_live?(neighbors)).to be false
        end
      end

      context 'with more than three live neighbors' do
        it 'should return false' do
          neighbors = []
          4.times { neighbors << Cell.new(:alive) }
          expect(subject.should_live?(neighbors)).to be false
        end
      end

      context 'with two or three live neighbors' do
        it 'should return true' do
          neighbors = []
          rand(2..3).times { neighbors << Cell.new(:alive) }
          expect(subject.should_live?(neighbors)).to be true
        end
      end
    end

    context 'on a dead cell' do
      subject { Cell.new(:dead) }
      context 'with exactly three live neighbors' do
        it 'should return true' do
          neighbors = []
          3.times { neighbors << Cell.new(:alive) }
          expect(subject.should_live?(neighbors)).to be true
        end
      end
    end
  end
end

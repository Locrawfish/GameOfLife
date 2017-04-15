require 'pry'
require 'rspec'
require_relative '../lib/cell'

describe Cell do
  subject { Cell.new(state, neighbors) }

  def randomized_neighbors(alive_count)
    alive_neighbors = Array.new(alive_count, Cell.new(:alive, []))
    dead_neighbors = Array.new(rand(100), Cell.new(:dead, []))
    alive_neighbors + dead_neighbors
  end

  describe '#revive' do
    let(:state) { :dead }
    let(:neighbors) { Array.new(rand(2..3)) }
    it 'becomes alive' do
      subject.revive
      expect(subject.alive?).to eq true
    end
  end

  describe '#alive_neighbor_count' do
    let(:state) { :dead }
    let(:neighbors) { randomized_neighbors(@count) }
    before { @count = rand(100) }
    it 'should return the number of alive neighbors' do
      expect(subject.alive_neighbor_count).to eq @count
    end
  end

  describe '#should_live?' do
    context 'on an alive cell' do
      let(:state) { :alive }
      context 'with fewer than two live neighbors' do
        let(:neighbors) { randomized_neighbors(rand(0..1)) }
        it 'should return false' do
          expect(subject.should_live?).to be false
        end
      end

      context 'with more than three live neighbors' do
        let(:neighbors) { randomized_neighbors(rand(3..100)) }
        it 'should return false' do
          expect(subject.should_live?).to be false
        end
      end

      context 'with two or three live neighbors' do
        let(:neighbors) { randomized_neighbors(rand(2..3)) }
        it 'should return true' do
          expect(subject.should_live?).to be true
        end
      end
    end

    context 'on a dead cell' do
      let(:state) { :dead }
      context 'with exactly three live neighbors' do
        let(:neighbors) { randomized_neighbors(3) }
        it 'should return true' do
          expect(subject.should_live?).to be true
        end
      end
    end
  end
end

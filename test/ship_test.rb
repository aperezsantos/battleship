require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_it_exists
    cruiser = Ship.new("Cruiser", 3)

    assert_instance_of Ship, cruiser
  end

  def test_it_has_name
    cruiser = Ship.new("Cruiser", 3)

    assert_equal "Cruiser", cruiser.name
  end

  def test_it_starts_with_length
    # skip
    cruiser = Ship.new("Cruiser", 3)

    assert_equal 3, cruiser.length
  end

  def test_it_starts_with_health_equal_to_length
    # skip
    cruiser = Ship.new("Cruiser", 3)

    assert_equal 3, cruiser.health
  end

  def test_it_is_not_sunk
    # skip
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, cruiser.sunk?
  end

  def test_health_decreases_when_hit
    # skip
    cruiser = Ship.new("Cruiser", 3)

    assert_equal 3, cruiser.health
    cruiser.hit
    assert_equal 2, cruiser.health
    cruiser.hit
    assert_equal 1, cruiser.health
    cruiser.hit
    assert_equal 0, cruiser.health
    assert_equal 3, cruiser.length
  end

  def test_ship_sunk_when_health_reaches_zero
    # skip
    cruiser = Ship.new("Cruiser", 3)

    assert_equal 3, cruiser.health
    assert_equal false, cruiser.sunk?
    cruiser.hit
    assert_equal 2, cruiser.health
    assert_equal false, cruiser.sunk?
    cruiser.hit
    assert_equal 1, cruiser.health
    assert_equal false, cruiser.sunk?
    cruiser.hit
    assert_equal 0, cruiser.health
    assert_equal true, cruiser.sunk?
  end

end

import cocotb
from cocotb.regression import TestFactory
from cocotb.triggers import RisingEdge, FallingEdge

@cocotb.test()
async def test_hazard_unit(dut):
    """Test hazard unit"""

    # Define the clock period
    clock_period = 1  # adjust this to your actual clock period

    # Reset the design
    dut.reset <= 1
    dut.rs <= 0
    dut.rt <= 0
    dut.rd <= 0

    await FallingEdge(dut.clock)
    dut.reset <= 0
    await FallingEdge(dut.clock)

    # Test case where there are no hazards
    dut.rs <= 1
    dut.rt <= 2
    dut.rd <= 3
    await FallingEdge(dut.clock)

    assert dut.stall == 0, "Incorrect control signal for no hazard case"
    assert dut.flush == 0, "Incorrect control signal for no hazard case"
    assert dut.forward == 0, "Incorrect control signal for no hazard case"

    # Test case where a hazard should cause a stall
    dut.rs <= 1
    dut.rt <= 2
    dut.rd <= 1
    await FallingEdge(dut.clock)

    assert dut.stall == 1, "Incorrect control signal for stall hazard case"

    # Test more cases...

tf = TestFactory(test_hazard_unit)
tf.generate_tests()

import cocotb
from cocotb.regression import TestFactory
from cocotb.triggers import RisingEdge, FallingEdge

@cocotb.test()
async def test_branch_predictor(dut):
    """Test branch predictor"""

    # Define the clock period
    clock_period = 1  # adjust this to your actual clock period

    # Reset the design
    dut.reset <= 1
    dut.pc <= 0
    dut.branch <= 0
    dut.taken <= 0
    dut.target_address <= 0

    await FallingEdge(dut.clock)
    dut.reset <= 0
    await FallingEdge(dut.clock)

    # Start with no branch
    dut.branch <= 0
    dut.taken <= 0
    dut.target_address <= 0
    await FallingEdge(dut.clock)

    # Test a branch not taken
    dut.branch <= 1
    dut.taken <= 0
    dut.target_address <= 0x100
    await FallingEdge(dut.clock)

    assert dut.pc == 4, "PC did not increment correctly"

    # Test a branch taken
    dut.branch <= 1
    dut.taken <= 1
    dut.target_address <= 0x100
    await FallingEdge(dut.clock)

    assert dut.pc == 0x100, "PC did not branch correctly"

    # Test a few more cases here...

tf = TestFactory(test_branch_predictor)
tf.generate_tests()

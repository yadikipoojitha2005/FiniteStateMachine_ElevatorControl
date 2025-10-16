# FiniteStateMachine_ElevatorControl
Elevator control system implemented in Verilog using finite state machines for managing multi-floor requests and elevator movement.


This project implements a digital elevator control system using finite state machines (FSM) in Verilog HDL. The elevator moves between four floors (0 to 3) responding to input requests and controls the current floor display.


Features
Uses a state machine approach to manage elevator states and transitions.
Supports multiple state machine designs (three variants M1, M2, M3) with different coding styles.
Determines elevator floor based on current state.
Includes reset and clock-driven synchronous state transitions.
Inputs: ra, rb, rc, rd (floor request buttons for floors 0 to 3).



Output: 2-bit floor indicating current floor index.

Design Details

The state machine maintains states representing elevator positions and movements: Idle at floors, Moving Up (BU, CU), Moving Down (BD, CD), Door open (D).
State transitions depend on floor requests and elevator direction.
Reset initializes the elevator to floor 0 (state = A).
Controlled on negative edge of the clock for synchronization.

z = 20;
visible = false;

moving = false;
turning = false;
resetAim = false;

startX = x;
startY = y;

mouseStartX = mouse_x;
mouseStartY = mouse_y;

nextX = x;
nextY = y;

dir = 0;
startDir = dir;
nextDir = dir;

// yaw and pitch here are interchanble with [x,y] however it is better to think in terms of rotation
yaw = 0;
yawStart = 0;
pitch = 0;
pitchStart = 0;

// counter for lerping yaw and pitch to 0 when ending freelook
aimCounter = 0;
aimCounterMax = 20;
aimCounterInc = 1;

// counter for moving player
moveCounter = 0;
moveCounterMax = 30;
moveCounterInc = 1;

// counter for rotating player
turnCounter = 0;
turnCounterMax = 20;
turnCounterInc = 1;
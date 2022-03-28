
class Speedometer {
  double currentSpeed;
  int time0_48;
  int time48_0;
  int range;

  Speedometer(
      {required this.currentSpeed,
        required this.time0_48,
        required this.time48_0,

        this.range = LESS_0});
}


const FROM_0_TO_48 = 1;
const FROM_48_TO_0 = 2;
const LESS_0 = 0;
const OVER_48 = 3;
const SPEED_0 = 10;
const SPEED_48 = 30;

// Height fuction for edu and work experience sections
int heightFunction(
    {required String sectionType,
    required int length,
    required String screen}) {
  if (screen == 'resume-template') {
    if (sectionType == 'edu') {
      int eduLength = length;
      if (eduLength == 1) {
        return 110;
      } else if (eduLength == 2) {
        return 220;
      } else if (eduLength == 3) {
        return 330;
      } else if (eduLength == 4) {
        return 440;
      } else {
        return 550;
      }
    } else {
      int workExpLength = length;
      if (workExpLength == 1) {
        return 140;
      } else if (workExpLength == 2) {
        return 280;
      } else if (workExpLength == 3) {
        return 420;
      } else if (workExpLength == 4) {
        return 560;
      } else {
        return 700;
      }
    }
  } else {
    if (sectionType == 'edu') {
      int eduLength = length;
      if (eduLength == 1) {
        return 125;
      } else if (eduLength == 2) {
        return 250;
      } else if (eduLength == 3) {
        return 375;
      } else if (eduLength == 4) {
        return 500;
      } else {
        return 625;
      }
    } else {
      int workExpLength = length;
      if (workExpLength == 1) {
        return 125;
      } else if (workExpLength == 2) {
        return 250;
      } else if (workExpLength == 3) {
        return 375;
      } else if (workExpLength == 4) {
        return 500;
      } else {
        return 625;
      }
    }
  }
}

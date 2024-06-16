enum PlayerState {
  idle(state: 'Idle'),
  run(state: 'Run'),
  jump(state: 'Jump'),
  fall(state: 'Fall');

  final String state;

  const PlayerState({ required this.state });

  String getState () {
    return state;
  }

  bool isJumpable() {
    return this == idle || this == run;
  }

}
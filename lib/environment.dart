/// Freezes opted-in infinite animations; finite transitions remain enabled.
const bool disableInfiniteAnimations = bool.fromEnvironment(
  'DISABLE_INFINITE_ANIMATIONS',
);

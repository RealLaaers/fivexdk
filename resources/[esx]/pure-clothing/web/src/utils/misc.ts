// Will return whether the current environment is in a regular browser
// and not CEF
export const isEnvBrowser = (): boolean => !(window as any).invokeNative;
export const getResourceName = (): string => {
  if (isEnvBrowser()) return 'clothing';
  return (window as any).GetParentResourceName();
};

// Basic no operation function
export const noop = () => {};

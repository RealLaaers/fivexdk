import React, {
  Context,
  createContext,
  useContext,
  useEffect,
  useState,
} from 'react';
import { useNuiEvent } from '../hooks/useNuiEvent';

const VisibilityCtx = createContext<VisibilityProviderValue | null>(null);

interface VisibilityProviderValue {
  setVisible: (visible: boolean) => void;
  visible: boolean;
}

// This should be mounted at the top level of your application, it is currently set to
// apply a CSS visibility value. If this is non-performant, this should be customized.
export const VisibilityProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const [visible, setVisible] = useState(false);

  useNuiEvent<boolean>('setVisible', setVisible);

  // Handle pressing escape/backspace
  useEffect(() => {
    // Only attach listener when we are visible
    if (!visible) return;

    const keyHandler = (e: KeyboardEvent) => {
      if (['Escape'].includes(e.code)) {
        // if (!isEnvBrowser()) console.log('Sending setVisible(false)');
        // else setVisible(!visible);
        setVisible(false);
      }
    };

    window.addEventListener('keydown', keyHandler);

    const buttonRipple: any = document.querySelectorAll('.ripple-animation');

    buttonRipple.forEach((button: any) => {
      button.onclick = ({
        pageY,
        currentTarget,
      }: {
        pageY: any;
        currentTarget: any;
      }) => {
        const x = 15;
        let y = pageY - currentTarget.offsetTop;
        if (y < 0) {
          y = 15;
        }
        const ripple = document.createElement('span');
        // make the style of the ripple with the overflow hidden
        ripple.classList.add('ripple-effect');
        ripple.style.left = `${x}px`;
        ripple.style.top = `${y}px`;
        button.appendChild(ripple);
        setTimeout(() => {
          ripple.remove();
        }, 600);
      };
    });

    return () => window.removeEventListener('keydown', keyHandler);
  }, [visible]);

  return (
    <VisibilityCtx.Provider
      value={{
        visible,
        setVisible,
      }}
    >
      <div style={{ display: visible ? 'block' : 'none', height: '100%' }}>
        {children}
      </div>
    </VisibilityCtx.Provider>
  );
};

export const useVisibility = () =>
  useContext<VisibilityProviderValue>(
    VisibilityCtx as Context<VisibilityProviderValue>
  );

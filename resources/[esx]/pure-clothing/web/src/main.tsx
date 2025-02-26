import React from 'react';
import ReactDOM from 'react-dom/client';
import { VisibilityProvider } from './providers/VisibilityProvider';
import App from './App';
import { Provider } from 'react-redux';
import { clothingStore } from './store/store';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    {/* <Provider store={clothingStore}>
      <App />
    </Provider> */}
    <VisibilityProvider>
      <Provider store={clothingStore}>
        <App />
      </Provider>
    </VisibilityProvider>
  </React.StrictMode>
);
